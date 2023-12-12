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
storage = firebase.storage()

@extend_schema_view(
    get = extend_schema(
        description="Get a list of img urls.",
        responses={
            200: inline_serializer(
                name='getImgResponse',
                fields={
                    'word_name': serializers.DictField(default={
                        'url1':"string",
                        'url2': "string",
                        'url3': "string",})
                }
            ),
            500:'',
        }
    ),
    post = extend_schema(
        request=inline_serializer(
            name='postImgRequest',
            fields={
                'url1': serializers.CharField(),
                'url2': serializers.CharField(),
                'url3': serializers.CharField(),
            }
        ),
        description="Add img urls to word_name.",
        responses={
            201: '',
            500: inline_serializer(
                name='postImgError',
                fields={
                    "error": serializers.CharField(default="Failed to POST!"),
                }
            )
        }
    )
)

@api_view(['GET', 'POST'])
def default_img_list(request):
    if request.method == 'GET':
        try:
            examples = db.child('word_imgs').get()
            return Response(examples.val(), status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    elif request.method == 'POST':
        try:
            word_name = list(request.data)
            data = {
                'url1': request.data[word_name[0]]['url1'],
                'url2': request.data[word_name[0]]['url2'],
                'url3': request.data[word_name[0]]['url3'],
            }
            db.child('word_imgs').child(word_name[0]).set(data)
            return Response(status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response({'error': 'Failed to POST!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@extend_schema_view(
    get = extend_schema(
        description="Get img url based on the word_name.",
        responses={
            200: inline_serializer(
                name='getImgDetailResponse',
                fields={
                    'url1': serializers.CharField(),
                    'url2': serializers.CharField(),
                    'url3': serializers.CharField(),
                }
            ),
            500: inline_serializer(
                name='getImgDetailError',
                fields={
                    'error': serializers.CharField(default='(word_name) does not exist in Firebase DB')
                }
            ),
        }
    ),
    put = extend_schema(
        request=inline_serializer(
            name='putImgDetailRequest',
            fields={
                'url1': serializers.CharField(),
                'url2': serializers.CharField(),
                'url3': serializers.CharField(),
            }
        ),
        description="Update img url information based on the word_name.",
        responses={
            200: '',
            500:'',
        }
    ),
    delete = extend_schema(
        description="Delete img urls from specified word entry.",
        responses={
            204: inline_serializer(
                name="deleteImgDetailError",
                fields={
                    'entry': serializers.CharField(default='"word_name"s img urls removed')
                }
            ),
            500:''
        }
    )
)

@api_view(['GET','PUT','DELETE'])
def default_img_detail(request, word):
    if request.method == 'GET':
        word_detail = db.child('word_imgs').child(word).get().val()
        if word_detail is None:
            return Response({'error': f'({word}) does not exist in Firebase DB'}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(word_detail, status=status.HTTP_200_OK)
    elif request.method == 'PUT':
        try:
            data = {
                'url1': request.data['url1'],
                'url2': request.data['url2'],
                'url3': request.data['url3'],
            }
            db.child('words_example').child(word).update(data)
            return Response(status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    elif request.method == 'DELETE':
        try:
            db.child('word_imgs').child(word).remove()
            return Response({'entry': f'"{word}"s img urls removed'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
