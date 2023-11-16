import pyrebase
from django.shortcuts import render
from rest_framework import status
from rest_framework.decorators import api_view
from rest_framework.response import Response
from django.conf import settings
from openai import OpenAI
from drf_spectacular.utils import extend_schema, inline_serializer
from rest_framework import serializers

# firebase initialization 
firebase = pyrebase.initialize_app(getattr(settings, "FIREBASE_CONFIG"))
authen = firebase.auth()
db = firebase.database()
storage = firebase.storage()
client = OpenAI(api_key=getattr(settings, "OPENAI_API_KEY"))

@extend_schema(
    request=inline_serializer(
        name='requestSerializer',
        fields={
            'style': serializers.CharField(),
            'sentence': serializers.CharField()
        }
    ),
    description="Generate an image based on word and user sentence",
    responses={
        201: inline_serializer(
            name='img_url',
            fields={
                "img_url": serializers.CharField()
            }
        ),
        500: inline_serializer(
            name='error',
            fields={
                "error": serializers.CharField(default="Failed to POST"),
                "style": serializers.CharField(),
                "sentence": serializers.CharField()
            }
        )
    }
)

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
                 'sentence': request.data['sentence']},
                 status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )

@extend_schema(
    request=inline_serializer(
        name='requestSerializer',
        fields={
            'word': serializers.CharField(),
            'dfn': serializers.CharField(),
            'sentence': serializers.CharField(),
        }
    ),
    description="Receive evaluation from ChatGPT on a certain user sentence based on the request word and definition",
    responses={
        200: inline_serializer(
            name='responseSerializer',
            fields={
                "response": serializers.CharField()
            }
        ),
        500: inline_serializer(
            name='errorSerializer',
            fields={
                "error": serializers.CharField(default="exception_message"),
            }
        )
    }
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