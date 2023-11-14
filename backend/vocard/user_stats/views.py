import pyrebase
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.conf import settings

# firebase initialization 
firebase = pyrebase.initialize_app(getattr(settings, "FIREBASE_CONFIG"))
authen = firebase.auth()
db = firebase.database()

@api_view(['GET', 'POST'])
def user_stats_list(request, usr_id):
    # Authentication
    if not hasattr(request.user, 'usr_id'):
        return Response({'error': 'anonuser cannot access user_stats'}, status=status.HTTP_401_UNAUTHORIZED)
    else:
        request_usr_id = str(request.user.usr_id)
    if request_usr_id != usr_id:
        return Response({'error': request_usr_id}, status=status.HTTP_401_UNAUTHORIZED)
    
    if request.method == 'GET':
        is_user = db.child('users').child(usr_id).get().val()
        usr_ex = db.child('usr_stats').child(usr_id).get().val()
        # User with usr_id does not exist
        if is_user is None:
            return Response({'usr_id': usr_id, 'error': 'no such user in database'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        # User with usr_id exists, but no associated information in user_example
        elif is_user is not None and usr_ex is None:
            return Response({'usr_id': usr_id, 'error': 'user has no entries in user_example!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else: 
            return Response(usr_ex, status=status.HTTP_200_OK)
    
    elif request.method == 'POST':
        try:
            word_name = list(request.data)
            data = {
                'study_score': request.data[word_name[0]]['study_score'],
                'mem_score': request.data[word_name[0]]['mem_score'],
                'num_studied': request.data[word_name[0]]['num_studied'],
                'last_studied': request.data[word_name[0]]['last_studied'],
            }
            db.child('usr_stats').child(usr_id).child(word_name[0]).set(data)
            return Response(status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response({'error': 'Failed to POST!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET', 'PUT', 'DELETE'])
def user_stats_detail(request, word, usr_id):
    # Authentication
    if not hasattr(request.user, 'usr_id'):
        return Response({'error': 'anonuser cannot access user_example'}, status=status.HTTP_401_UNAUTHORIZED)
    else:
        request_usr_id = str(request.user.usr_id)
    if request_usr_id != usr_id:
        return Response({'error': request_usr_id}, status=status.HTTP_401_UNAUTHORIZED)
    
    if request.method == "GET":
        usr_stats_entry = db.child('usr_stats').child(usr_id).child(word).get().val()
        # User with entry does not exist
        if usr_stats_entry is None:
            return Response({'error': f'user has no entry ({word}) in usr_stats!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else: 
            return Response(usr_stats_entry, status=status.HTTP_200_OK)
        
    elif request.method == "PUT":
        key_list = ['last_studied', 'mem_score', 'num_studied', 'study_score']
        data = {}
        # parse through request.data to check which field needs updating 
        # don't allow invalid keys to go through
        print(request.data)
        for key, value in request.data.items():
            if key in key_list:
                data[key] = value
            else:
                return Response({'error': f"invalid key ({key})"}, status=status.HTTP_400_BAD_REQUEST)
        db.child('usr_stats').child(usr_id).child(word).update(data=data)
        return Response(data, status=status.HTTP_200_OK)
    
    elif request.method == "DELETE":
        try:
            db.child('usr_stats').child(usr_id).child(word).remove()
            return Response({'entry': f'"{word}"s stats removed'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)