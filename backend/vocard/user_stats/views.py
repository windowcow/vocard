import pyrebase
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.conf import settings
from drf_spectacular.utils import extend_schema, inline_serializer, extend_schema_view 
from rest_framework import serializers

# firebase initialization 
firebase = pyrebase.initialize_app(getattr(settings, "FIREBASE_CONFIG"))
authen = firebase.auth()
db = firebase.database()

@extend_schema_view(
    get = extend_schema(
        description="Get a list of a user's stats. User Authentication Required.",
        responses={
            200: inline_serializer(
                name='getUserStatResponse',
                fields={
                    'word_name': serializers.DictField(default={'last_studied':0, 'mem_score': 0, 'num_studied': 0, 'study_score': 0})
                }
            ),
            500: inline_serializer(
                name='getUserStatError',
                fields={
                    'usr_id': serializers.CharField(default="usr_id"),
                    'error': serializers.CharField(default='no such user in database')
                }
            ),
        }
    ),
    post = extend_schema(
        request=inline_serializer(
            name='postUserStatRequest',
            fields={
                'last_studied': serializers.IntegerField(),
                'mem_score': serializers.IntegerField(),
                'num_studied': serializers.IntegerField(),
                'study_score': serializers.IntegerField(), 
            }
        ),
        description="Add the provided stat information to the user's user_stats entry. User Authentication Required.",
        responses={
            201: '',
            500: inline_serializer(
                name='postUserStatError',
                fields={
                    "error": serializers.CharField(default="Failed to POST!"),
                }
            )
        }
    )
)

@api_view(['GET', 'POST'])
def user_stats_list(request, usr_id):
    # Authentication
    # if not hasattr(request.user, 'usr_id'):
    #     return Response({'error': 'anonuser cannot access user_stats'}, status=status.HTTP_401_UNAUTHORIZED)
    # else:
    #     request_usr_id = str(request.user.usr_id)
    # if request_usr_id != usr_id:
    #     return Response({'error': request_usr_id}, status=status.HTTP_401_UNAUTHORIZED)
    
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


@extend_schema_view(
    get = extend_schema(
        description="Get a user's stat information based on the word_name. User Authentication Required.",
        responses={
            200: inline_serializer(
                name='getUserStatDetailResponse',
                fields={
                    'last_studied': serializers.IntegerField(),
                    'mem_score': serializers.IntegerField(),
                    'num_studied': serializers.IntegerField(),
                    'study_score': serializers.IntegerField(), 
                }
            ),
            500: inline_serializer(
                name='getUserStatDetailError',
                fields={
                    'usr_id': serializers.CharField(default="usr_id"),
                    'error': serializers.CharField(default='user has no entry (word_name) in usr_stats!')
                }
            ),
        }
    ),
    put = extend_schema(
        request=inline_serializer(
            name='putUserStatDetailRequest',
            fields={
                'last_studied': serializers.IntegerField(),
                'mem_score': serializers.IntegerField(),
                'num_studied': serializers.IntegerField(),
                'study_score': serializers.IntegerField(), 
            }
        ),
        description="Update the provided information to the user's usr_stats's word_name entry. User Authentication Required.",
        responses={
            200: '',
            400: inline_serializer(
                name='postUserStatDetailError',
                fields={
                    "error": serializers.CharField(default="invalid key (key)"),
                }
            )
        }
    ),
    delete = extend_schema(
        description="Delete stats from user's specified word entry. User Authentication Required.",
        responses={
            204: inline_serializer(
                name="deleteUserStatDetailError",
                fields={
                    'entry': serializers.CharField(default='"word_name"s stats removed')
                }
            ),
            500:''
        }
    )
)

@api_view(['GET', 'PUT', 'DELETE'])
def user_stats_detail(request, word, usr_id):
    # Authentication
    # if not hasattr(request.user, 'usr_id'):
    #     return Response({'error': 'anonuser cannot access user_example'}, status=status.HTTP_401_UNAUTHORIZED)
    # else:
    #     request_usr_id = str(request.user.usr_id)
    # if request_usr_id != usr_id:
    #     return Response({'error': request_usr_id}, status=status.HTTP_401_UNAUTHORIZED)
    
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