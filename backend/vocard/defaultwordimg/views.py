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
storage = firebase.storage()

@api_view(['GET', 'POST'])
def default_img_list(request):
    if request.method == 'GET':
        examples = db.child('word_imgs').get()
        return Response(examples.val(), status=status.HTTP_200_OK)
    
    elif request.method == 'POST':
        try:
            word_name = list(request.data)
            data = {
                'url': request.data[word_name[0]]['url'],
            }
            db.child('word_imgs').child(word_name[0]).set(data)
            return Response(status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response({'error': 'Failed to POST!'}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)

@api_view(['GET','PUT','DELETE'])
def default_img_detail(request, word):
    if request.method == 'GET':
        word_detail = db.child('word_imgs').child(word).get().val()
        if word_detail is None:
            return Response({'error': 'example does not exist in Firebase DB'}, status=status.HTTP_404_NOT_FOUND)
        else:
            return Response(word_detail, status=status.HTTP_200_OK)
    elif request.method == 'PUT':
        try:
            data = {
                'url': request.data['url'],
            }
            db.child('words_example').child(word).update(data)
            return Response(status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
    elif request.method == 'DELETE':
        try:
            db.child('word_imgs').child(word).remove()
            return Response({'entry': f'"{word}"s img url removed'}, status=status.HTTP_200_OK)
        except Exception as e:
            print(e)
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
