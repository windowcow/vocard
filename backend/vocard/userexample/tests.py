from datetime import datetime, timezone
from unittest.mock import patch
from django.utils import timezone
from django.test import TestCase
from rest_framework.test import APIClient
from authentication.models import User
import pyrebase
from django.conf import settings
firebase_config = {
    "apiKey": getattr(settings, "APIKEY"),
    "databaseURL": getattr(settings, "DATABASEURL"),
    "authDomain": getattr(settings, "AUTHDOMAIN"),
    "projectId": getattr(settings, "PROJECTID"),
    "storageBucket": getattr(settings, "STORAGEBUCKET"),
    "messagingSenderId": getattr(settings, "MESSAGINGSENDERID"),
    "appId": getattr(settings, "APPID"),
    "measurementId": getattr(settings, "MEASUREMENTID")
}

# firebase initialization 
firebase = pyrebase.initialize_app(firebase_config)
authen = firebase.auth()
db = firebase.database()


# Create your tests here.
class Test(TestCase):
    mock_date = datetime(2022, 1, 1, 1, 1, 1, tzinfo=timezone.utc)
    mock_usr_id = '5cb7a137-5fd6-41a0-929a-18737f1653c6'
    mock_nickname = 'mock-nickname'
    mock_oauth_id = 'mock-oauth-id'
    mock_acc_created = mock_date
    mock_last_sync = mock_date
    mock_total_studied = 0
    mock_latest_studied = 0


    @patch('django.utils.timezone.now', return_value=mock_date)
    def setUp(self, mock_now) -> None:
        User.objects.create(
            usr_id = self.mock_usr_id,
            nickname = self.mock_nickname,
            oauth_id = self.mock_oauth_id,
            acc_created = self.mock_acc_created,
            last_sync = self.mock_last_sync,
            total_studied = self.mock_total_studied,
            latest_studied= self.mock_latest_studied,
        )
    
    def test_user_example_list(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        client.force_authenticate(user=user)
        response = client.get(f'/userexample/{user.usr_id}/')
        self.assertEqual(response.status_code, 200)
    
    def test_user_example_list_invalid_auth(self):
        client = APIClient()
        response = client.get(f'/userexample/123/')
        self.assertEqual(response.status_code, 401)
    
    def test_user_example_list_invalid_owner(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        client.force_authenticate(user=user)
        response = client.get(f'/userexample/usr_id/')
        self.assertEqual(response.status_code, 401)
    
    def test_user_example_list_create(self):
        data = {
            'dummyword':
            {
                'sentence': "this is a dummysentence"
            }
        }
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        client.force_authenticate(user=user)
        response = client.post(f'/userexample/{user.usr_id}/', data=data, format='json')
        if response.status_code == 200:
            db.child('user_example').child(user.usr_id).child('dummyword').remove()
            print('test_user_example_list_create: cleaned db')
            self.assertEqual(response.status_code, 200)

    def test_user_example_list_create_invalid_auth(self):
        data = {
            'dummyword':
            {
                'sentence': "this is a dummysentence"
            }
        }
        client = APIClient()
        response = client.post(f'/userexample/usr_id/', data=data, format='json')
        self.assertEqual(response.status_code, 401)
    
    def test_user_example_list_create_invalid_owner(self):
        data = {
            'dummyword':
            {
                'sentence': "this is a dummysentence"
            }
        }
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        client.force_authenticate(user=user)
        response = client.post(f'/userexample/usr_id/', data=data, format='json')
        self.assertEqual(response.status_code, 401)
