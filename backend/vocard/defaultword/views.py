import pyrebase
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from django.conf import settings

# firebase initialization 
firebase = pyrebase.initialize_app(getattr(settings, "FIREBASE_CONFIG"))
authen = firebase.auth()
db = firebase.database()

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
                'meaning': request.data[word_name[0]]['meaning']
            }
            db.child('words').child(word_name[0]).set(data)
            return Response(status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response({'error': 'Failed to POST!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

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