from datetime import datetime, timezone
from unittest.mock import patch
from django.utils import timezone
from django.test import TestCase
from rest_framework.test import APIClient
from authentication.models import User

# Create your tests here.
class Test(TestCase):
    mock_date = datetime(2022, 1, 1, 1, 1, 1, tzinfo=timezone.utc)
    mock_usr_id = 'fc3fa40c-6c43-4f67-bc01-73da3a126123'
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
    
    def test_user_detail(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        client.force_authenticate(user=user)
        response = client.get(f'/auth/users/{user.usr_id}/')
        data = response.data
        self.assertEqual(data.get('usr_id'), str(user.usr_id))
        self.assertEqual(data.get('nickname'), user.nickname)
        self.assertEqual(data.get('total_studied'), user.total_studied)
        self.assertEqual(data.get('latest_studied'), user.latest_studied)
    
    def test_user_detail_not_exist(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        client.force_authenticate(user=user)
        response = client.get(f'/auth/999/')

        self.assertEqual(response.status_code, 404)

    # should assert 401 Unauthorized because anonuser
    def test_user_detail_invalid_auth(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        # client.force_authenticate(user=dummy_user)
        response = client.get(f'/auth/users/{user.usr_id}/')
        self.assertEqual(response.status_code, 401)

    # Assert 404 because IsAuthenticated=True but not owner (fails filter) 
    def test_user_detail_invalid_owner(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        dummy_user = User.objects.create_user(nickname='dummy-nickname', oauth_id='dummy-oauth-id')
        client = APIClient()
        client.force_authenticate(user=dummy_user)
        response = client.get(f'/auth/users/{user.usr_id}/')
        self.assertEqual(response.status_code, 404)
    
    # Assert 204 upon successful removal
    def test_user_destroy(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        client.force_authenticate(user=user)
        response = client.delete(f'/auth/users/remove/{user.usr_id}/')
        self.assertEqual(response.status_code, 204)
    
    def test_user_destroy_invalid_owner(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        dummy_user = User.objects.create_user(nickname='dummy-nickname', oauth_id='dummy-oauth-id')
        client = APIClient()
        client.force_authenticate(user=dummy_user)
        response = client.delete(f'/auth/users/remove/{user.usr_id}/')
        self.assertEqual(response.status_code, 404)
    
    def test_user_destroy_invalid_auth(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        client = APIClient()
        response = client.delete(f'/auth/users/remove/{user.usr_id}/')
        self.assertEqual(response.status_code, 401)

    def test_user_details_update(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        new_mock_nickname = 'new-mock-nickname-1'
        data = {
            'nickname': new_mock_nickname
        }
        client = APIClient()
        client.force_authenticate(user=user)
        response = client.put(f'/auth/users/{user.usr_id}/', data=data)
        self.assertEqual(response.status_code, 200)

    def test_user_details_update_invalid_owner(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        dummy_user = User.objects.create_user(nickname='dummy-nickname', oauth_id='dummy-oauth-id')
        new_mock_nickname = 'new-mock-nickname-1'
        data = {
            'nickname': new_mock_nickname
        }
        client = APIClient()
        client.force_authenticate(user=dummy_user)
        response = client.put(f'/auth/users/{user.usr_id}/', data=data)
        self.assertEqual(response.status_code, 404)
    
    def test_user_details_update_invalid_auth(self):
        user = User.objects.get(oauth_id=self.mock_oauth_id)
        new_mock_nickname = 'new-mock-nickname-1'
        data = {
            'nickname': new_mock_nickname
        }
        client = APIClient()
        response = client.put(f'/auth/users/{user.usr_id}/', data=data)
        self.assertEqual(response.status_code, 401)
