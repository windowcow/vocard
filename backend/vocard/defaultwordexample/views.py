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
        description="Get a list of word examples.",
        responses={
            200: inline_serializer(
                name='getExampleResponse',
                fields={
                    'word_name': serializers.DictField(default={
                        'sentence1':"string",
                        'sentence1': "string",
                        'sentence3': "string",})
                }
            ),
            500:'',
        }
    ),
    post = extend_schema(
        request=inline_serializer(
            name='postExampleRequest',
            fields={
                'sentence1': serializers.CharField(),
                'sentence2': serializers.CharField(),
                'sentence3': serializers.CharField(),
            }
        ),
        description="Add examples to word_name.",
        responses={
            201: '',
            500: inline_serializer(
                name='postExampleError',
                fields={
                    "error": serializers.CharField(default="Failed to POST!"),
                }
            )
        }
    )
)


@api_view(['GET', 'POST'])
def default_example_list(request):
    if request.method == 'GET':
        try:
            examples = db.child('words_example').get()
            return Response(examples.val(), status=status.HTTP_200_OK)
        except:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    
    elif request.method == 'POST':
        try:
            word_name = list(request.data)
            data = {
                'sentence1': request.data[word_name[0]]['sentence1'],
                'sentence2': request.data[word_name[0]]['sentence2'],
                'sentence3': request.data[word_name[0]]['sentence3']
            }
            db.child('words_example').child(word_name[0]).set(data)
            return Response(status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response({'error': 'Failed to POST!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        
@extend_schema_view(
    get = extend_schema(
        description="Get examples based on the word_name.",
        responses={
            200: inline_serializer(
                name='getExampleDetailResponse',
                fields={
                    'sentence1': serializers.CharField(),
                    'sentence2': serializers.CharField(),
                    'sentence3': serializers.CharField(),
                }
            ),
            500: inline_serializer(
                name='getExampleDetailError',
                fields={
                    'error': serializers.CharField(default='example does not exist in Firebase DB')
                }
            ),
        }
    ),
    put = extend_schema(
        request=inline_serializer(
            name='putExampleDetailRequest',
            fields={
                'sentence1': serializers.CharField(),
                'sentence2': serializers.CharField(),
                'sentence3': serializers.CharField(),
            }
        ),
        description="Update example based on the word_name.",
        responses={
            200: '',
            500:'',
        }
    ),
    delete = extend_schema(
        description="Delete examples from specified word entry.",
        responses={
            204: inline_serializer(
                name="deleteExampleDetailError",
                fields={
                    'entry': serializers.CharField(default='"word_name"s examples removed')
                }
            ),
            500:''
        }
    )
)

@api_view(['GET','PUT','DELETE'])
def default_example_detail(request, word):
    if request.method == 'GET':
        word_detail = db.child('words_example').child(word).get().val()
        if word_detail is None:
            return Response({'error': 'example does not exist in Firebase DB'}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(word_detail, status=status.HTTP_200_OK)
    elif request.method == 'PUT':
        try:
            data = {
                'sentence1': request.data['sentence1'],
                'sentence2': request.data['sentence2'],
                'sentence3': request.data['sentence3']
            }
            db.child('words_example').child(word).update(data)
            return Response(status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    elif request.method == 'DELETE':
        try:
            db.child('words_example').child(word).remove()
            return Response({'entry': f'"{word}"s examples removed'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
