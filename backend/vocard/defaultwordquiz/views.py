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
        description="Get a list of quizzes.",
        responses={
            200: inline_serializer(
                name='getQuizResponse',
                fields={
                    'word_name': serializers.DictField(default={
                        'answer':"string",
                        'choice1': "string",
                        'choice2': "string",
                        'choice3': "string",
                        'choice4': "string",
                        'question': "string"})
                }
            ),
            400:'',
        }
    ),
    post = extend_schema(
        request=inline_serializer(
            name='postQuizRequest',
            fields={
                'answer': serializers.CharField(),
                'choice1': serializers.CharField(),
                'choice2': serializers.CharField(),
                'choice3': serializers.CharField(),
                'choice4': serializers.CharField(),
                'question': serializers.CharField(),
            }
        ),
        description="Add quiz information to the quiz (num).",
        responses={
            201: '',
            500: inline_serializer(
                name='postQuizError',
                fields={
                    "error": serializers.CharField(default="Failed to POST!"),
                }
            )
        }
    )
)

@api_view(['GET', 'POST'])
def default_quiz_list(request, num):
    if request.method == 'GET':
        if num > 3:
            return Response(status=status.HTTP_400_BAD_REQUEST)
        quiz = db.child('words_quiz').child(f'quiz{num}').get()
        return Response(quiz.val(), status=status.HTTP_200_OK)
    
    elif request.method == 'POST':
        try:
            word_name = list(request.data)
            data = {
                'question': request.data[word_name[0]]['question'],
                'choice1': request.data[word_name[0]]['choice1'],
                'choice2': request.data[word_name[0]]['choice2'],
                'choice3': request.data[word_name[0]]['choice3'],
                'choice4': request.data[word_name[0]]['choice4'],
                'answer': request.data[word_name[0]]['answer'],
            }
            db.child('words_quiz').child(f'quiz{num}').child(word_name[0]).set(data)
            return Response(status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response({'error': 'Failed to POST!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)


@extend_schema_view(
    get = extend_schema(
        description="Get quiz based on the word_name.",
        responses={
            200: inline_serializer(
                name='getQuizDetailResponse',
                fields={
                    'answer': serializers.CharField(),
                    'choice1': serializers.CharField(),
                    'choice2': serializers.CharField(),
                    'choice3': serializers.CharField(),
                    'choice4': serializers.CharField(),
                    'question': serializers.CharField(),
                }
            ),
            500: inline_serializer(
                name='getQuizDetailError',
                fields={
                    'error': serializers.CharField(default='(word_name) has no quiz entry in Firebase DB (quiz(quiz_num))')
                }
            ),
        }
    ),
    put = extend_schema(
        request=inline_serializer(
            name='putQuizDetailRequest',
            fields={
                    'answer': serializers.CharField(),
                    'choice1': serializers.CharField(),
                    'choice2': serializers.CharField(),
                    'choice3': serializers.CharField(),
                    'choice4': serializers.CharField(),
                    'question': serializers.CharField(),
            }
        ),
        description="Update quiz information based on the word_name.",
        responses={
            200: '',
            500:'',
        }
    ),
    delete = extend_schema(
        description="Delete quiz from specified word entry.",
        responses={
            204: inline_serializer(
                name="deleteQuizDetailError",
                fields={
                    'entry': serializers.CharField(default='"word_name"s quiz removed')
                }
            ),
            500:''
        }
    )
)

@api_view(['GET','PUT','DELETE'])
def default_quiz_detail(request, word, num):
    if request.method == 'GET':
        quiz_detail = db.child('words_quiz').child(f'quiz{num}').child(word).get().val()
        if quiz_detail is None:
            return Response({'error': f'{word} has no quiz entry in Firebase DB (quiz{num})'}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(quiz_detail, status=status.HTTP_200_OK)
    elif request.method == 'PUT':
        try:
            data = {
                'question': request.data['question'],
                'choice1': request.data['choice1'],
                'choice2': request.data['choice2'],
                'choice3': request.data['choice3'],
                'choice4': request.data['choice4'],
                'answer': request.data['answer'],
            }
            db.child('words_quiz').child(f'quiz{num}').child(word).update(data)
            return Response(status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    elif request.method == 'DELETE':
        try:
            db.child('words_quiz').child(f'quiz{num}').child(word).remove()
            return Response({'entry': f'"{word}"s quiz removed'}, status=status.HTTP_204_NO_CONTENT)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
