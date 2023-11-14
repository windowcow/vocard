import pyrebase
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.conf import settings
from openai import OpenAI

# firebase initialization 
firebase = pyrebase.initialize_app(getattr(settings, "FIREBASE_CONFIG"))
authen = firebase.auth()
db = firebase.database()
storage = firebase.storage()
client = OpenAI(api_key=getattr(settings, "OPENAI_API_KEY"))

@api_view(['POST'])
def img_generate(request):
        try:
            img_prompt = f"Generate an image in a {request.data['style']} style that depicts the following sentence: {request.data['sentence']}. DO NOT HAVE ANY letters or text in the image"
            response = client.images.generate(
                model="dall-e-3",
                prompt=img_prompt,
                size="1024x1024",
                quality="standard",
                n=1,
            )
            img_url = response.data[0].url
            return Response({'img_url': img_url}, status=status.HTTP_201_CREATED)
        except Exception as e:
            print(e)
            return Response(
                {'error': 'Failed to POST!',
                 'style': request.data['style'],
                 'example': request.data['sentence']},
                 status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )

@api_view(['POST'])
def grade_example(request):
    try:
        prompt = f"Evaluate the correctness of the sentence based on the definition of the word. Word: {request.data['word']}. Definition: {request.data['dfn']}. Sentence: {request.data['sentence']}"
        chat_completion = client.chat.completions.create(
            model="gpt-3.5-turbo",
            messages=[
                {'role':'system', 'content': "You are a teacher evaluating the correctness of a student's example sentence. If the example sentence is wrong, provide details on how to make the sentence correct"},
                {'role':'user', 'content': prompt}
            ],
            max_tokens=2000
        )
        response = chat_completion.choices[0].message.content.strip()
        return Response({"response": response}, status=status.HTTP_200_OK)
    except Exception as e:
        print(e)
        return Response({"error": e}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)