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
def default_quiz_list(request, num):
    if request.method == 'GET':
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
            return Response({'entry': f'"{word}"s example removed'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
