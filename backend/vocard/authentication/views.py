import os
import requests
from django.shortcuts import redirect
from django.http import JsonResponse
from rest_framework import status, fields, generics
from rest_framework.decorators import api_view, permission_classes
from rest_framework.response import Response
from rest_framework.permissions import AllowAny, IsAdminUser, IsAuthenticated
from authentication.models import User
from authentication.serializer import UserSerializer
from authentication.filters import IsOwnerFilterBackend
from authentication.utils import get_tokens_for_user
from django.conf import settings
from json.decoder import JSONDecodeError
from allauth.socialaccount.providers.kakao import views as kakao_view
from allauth.socialaccount.providers.oauth2.client import OAuth2Client
from dj_rest_auth.registration.views import SocialLoginView
import pyrebase


BASE_URL = "http://localhost:8000/"
KAKAO_CALLBACK_URI = BASE_URL + 'auth/kakao/callback/'
firebase = pyrebase.initialize_app(getattr(settings, "FIREBASE_CONFIG"))
authen = firebase.auth()
db = firebase.database()

class UserDestroy(generics.DestroyAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    permission_classes = [IsAuthenticated]
    filter_backends = [IsOwnerFilterBackend]

    def destroy(self, request, *args, **kwargs):
        instance = self.get_object()
        try:
            db.child('users').child(instance.usr_id).remove()
            self.perform_destroy(instance)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_400_BAD_REQUEST)
        return Response(status=status.HTTP_204_NO_CONTENT)

class UserList(generics.ListAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    # change to IsAdmin for prod build!
    permission_classes = [AllowAny]

class UserRetrieve(generics.RetrieveUpdateAPIView):
    queryset = User.objects.all()
    serializer_class = UserSerializer
    # change to IsAuthenticated for prod build!
    permission_classes = [IsAuthenticated]
    filter_backends = [IsOwnerFilterBackend]
    
    def update(self, request, *args, **kwargs):
        print(request)
        old_data = []
        changed_data = []
        update_data = []
        data_db = {}
        instance = self.get_object()
        print(instance)
        print(getattr(instance, 'usr_id'))
        serializer = self.get_serializer(instance, data=request.data, partial=True)
        serializer.is_valid(raise_exception=True)
        print(serializer.validated_data.items())
        for field, value in serializer.validated_data.items():
            new_value = value
            changed_data.append(new_value)
            old_value = getattr(instance, field)
            old_data.append(old_value)
        print(old_data)
        print(changed_data)
        for index, (first, second) in enumerate(zip(old_data, changed_data)):
            if first != second:
                update_data.append(index)
        print(update_data)
        self.perform_update(serializer)
        try:
            for index in update_data:
                if index == 2:
                    data_db.update({'nickname': serializer.data['nickname']})
                elif index == 3:
                    data_db.update({'total_studied': serializer.data['total_studied']})
                elif index == 4:
                    data_db.update({'latest_studied': serializer.data['latest_studied']})
        except Exception as e:
            print(e)
        print(data_db)
        db.child('users').child(serializer.data['usr_id']).update(data_db)
        return Response(serializer.data)
    
def kakao_login(request):
    client_id = getattr(settings, "SOCIAL_AUTH_KAKAO_KEY")
    return redirect(f"https://kauth.kakao.com/oauth/authorize?client_id={client_id}&redirect_uri={KAKAO_CALLBACK_URI}&response_type=code"
    )

# Creates user via Kakao Login
@api_view(['GET', 'POST'])
def kakao_callback(request):
    client_id = getattr(settings, "SOCIAL_AUTH_KAKAO_KEY")
    code = request.GET.get("code")
    redirect_uri = KAKAO_CALLBACK_URI

    # Access Token Request
    token_req = requests.get(f"https://kauth.kakao.com/oauth/token?grant_type=authorization_code&client_id={client_id}&redirect_uri={redirect_uri}&code={code}")
    token_req_json = token_req.json()
    print(token_req_json)
    err = token_req_json.get("error")
    if err is not None:
        raise JSONDecodeError(err)
    access_token = token_req_json.get("access_token")
    refresh_token = token_req_json.get("refresh_token")

    # Nickname Request
    profile_request = requests.get("https://kapi.kakao.com/v2/user/me", headers={"Authorization": f"Bearer {access_token}"})
    profile_json = profile_request.json()
    err = profile_json.get("error")
    if err is not None:
        raise JSONDecodeError(err)
    kakao_account = profile_json.get('kakao_account')
    profile = kakao_account.get('profile')
    nickname = profile.get('nickname')
    oauth_id = profile_json.get('id')
    try:
        user = User.objects.filter(oauth_id=oauth_id).exists()
        print(user)
        # if user exists, GET current nickname & token information 
        if user is True:
            return Response({
                "nickname": nickname,
                "access_token": access_token,
                "refresh_token": refresh_token,
                "user_exists": True,
            })
        # user does not exist
        else:
            user = User.objects.create_user(
                nickname = nickname,
                oauth_id = oauth_id
            )
            serializer = UserSerializer(user)
            data = {
                'usr_id': serializer.data['usr_id'],
                'oauth_id': serializer.data['oauth_id'],
                'nickname': serializer.data['nickname'],
                'acc_created': serializer.data['acc_created'],
                'last_sync': serializer.data['last_sync'],
                'total_studied': serializer.data['total_studied'],
                'latest_studied': serializer.data['latest_studied']
            }
            # create user in Firebase db too
            db.child('users').child(user.usr_id).set(data)
            return Response({
            "nickname": nickname,
            "oauth_id": oauth_id,
            "access_token": access_token,
            "refresh_token": refresh_token,
            "db_entry_created": True
        })
    except Exception as e:
        print(e)
        return Response(status=status.HTTP_400_BAD_REQUEST)

class KakaoLogin(SocialLoginView):
    adapter_class = kakao_view.KakaoOAuth2Adapter
    client_class = OAuth2Client
    callback_url = KAKAO_CALLBACK_URI