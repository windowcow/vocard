import requests
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework import status
from rest_framework.response import Response

def handle_request(method, url=None, **kwargs):
    response = requests.request(method, url, **kwargs)
    if not response.ok:
        print(response.reason)
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    content = response.json()
    if content.get('error') is not None:
        print(content.get('error'))
        return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    return content


def handle_get(url, params=None, **kwargs):
    return handle_request('get', url, params=params, **kwargs)


def handle_post(url, data=None, json=None, **kwargs):
    return handle_request('post', url, data=data, json=json, **kwargs)


def get_tokens_for_user(user):
    refresh_token = RefreshToken.for_user(user)
    return (
        str(refresh_token.access_token),
        str(refresh_token)
    )