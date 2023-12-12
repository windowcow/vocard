import pyrebase
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from django.conf import settings
from drf_spectacular.utils import extend_schema, inline_serializer, extend_schema_view 
from rest_framework import serializers

# firebase initialization 
firebase = pyrebase.initialize_app(getattr(settings, "FIREBASE_CONFIG"))
authen = firebase.auth()
db = firebase.database()

@extend_schema_view(
    get = extend_schema(
        description="Get a list of words.",
        responses={
            200: inline_serializer(
                name='getWordResponse',
                fields={
                    'word_name': serializers.DictField(default={
                        'kr_name':"string",
                        'meaning': "string",
                        'pos': "string"})
                }
            ),
            500:'',
        }
    ),
    post = extend_schema(
        request=inline_serializer(
            name='postWordRequest',
            fields={
                'kr_name': serializers.CharField(),
                'meaning': serializers.CharField(),
                'pos': serializers.CharField(),
            }
        ),
        description="Add word entry.",
        responses={
            201: '',
            500: inline_serializer(
                name='postWordError',
                fields={
                    "error": serializers.CharField(default="Failed to POST!"),
                }
            )
        }
    )
)

@api_view(['GET', 'POST'])
def default_word_list(request):
    if request.method == 'GET':
        words = db.child('words').get()
        return Response(words.val(), status=status.HTTP_200_OK)
     
    elif request.method == 'POST':
        try:
            word_name = list(request.data)
            data = {
                'kr_name': request.data[word_name[0]]['kr_name'],
                'meaning': request.data[word_name[0]]['meaning'],
                'pos': request.data[word_name[0]]['pos']
            }
            db.child('words').child(word_name[0]).set(data)
            return Response(status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response({'error': 'Failed to POST!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@extend_schema_view(
    get = extend_schema(
        description="Get word information based on the word_name.",
        responses={
            200: inline_serializer(
                name='getWordDetailResponse',
                fields={
                    'kr_name': serializers.CharField(),
                    'meaning': serializers.CharField(),
                    'pos': serializers.CharField(),
                }
            ),
            500: inline_serializer(
                name='getWordDetailError',
                fields={
                    'error': serializers.CharField(default='word does not exist in Firebase DB')
                }
            ),
        }
    ),
    put = extend_schema(
        request=inline_serializer(
            name='putWordDetailRequest',
            fields={
                'kr_name': serializers.CharField(),
                'meaning': serializers.CharField(),
                'pos': serializers.CharField(),
            }
        ),
        description="Update word information based on the word_name.",
        responses={
            200: '',
            500:'',
        }
    ),
    delete = extend_schema(
        description="Delete word information from specified word entry.",
        responses={
            204: inline_serializer(
                name="deleteWordDetailError",
                fields={
                    'entry': serializers.CharField(default='"word_name" removed')
                }
            ),
            500:''
        }
    )
)

@api_view(['GET','PUT','DELETE'])
def default_word_detail(request, word):
    if request.method == 'GET':
        word_detail = db.child('words').child(word).get().val()
        if word_detail is None:
            return Response({'error': 'word does not exist in Firebase DB'}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(word_detail, status=status.HTTP_200_OK)
    elif request.method == 'PUT':
        try:
            data = {
                'kr_name': request.data['kr_name'],
                'meaning': request.data['meaning'],
                'pos': request.data['pos'],
            }
            db.child('words').child(word).update(data)
            return Response(status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    elif request.method == 'DELETE':
        try:
            db.child('words').child(word).remove()
            return Response({'entry': f'"{word}" removed'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)