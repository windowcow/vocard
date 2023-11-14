from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager, PermissionsMixin
import uuid
from rest_framework.response import Response
from rest_framework import status

# Create your models here.
class UserManager(BaseUserManager):
    def create_superuser(self, nickname, oauth_id, password=None, **extra_fields):
        if not nickname:
            raise ValueError('Enter a Nickname')
        if not oauth_id:
            raise ValueError('Enter OAuth ID')
        user = self.model(nickname=nickname, oauth_id=oauth_id, **extra_fields)
        user.set_password(password)
        user.is_superuser = True
        user.is_staff = True
        user.save(using=self._db)
        return user
    
    def create_user(self, nickname: str = None, oauth_id: str = None, **extra_fields):
        if not nickname:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        if not oauth_id:
            return Response(status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        else:
            self.create(
                nickname=nickname,
                oauth_id=oauth_id,
                **extra_fields,
            )
        user = self.get(oauth_id=oauth_id)
        return user

class User(AbstractBaseUser, PermissionsMixin):
    is_superuser = models.BooleanField(default=False)
    is_staff = models.BooleanField(default=False)
    usr_id = models.UUIDField(primary_key=True, default=uuid.uuid4)
    oauth_id = models.CharField(max_length=255, unique=True, db_index=True)
    nickname = models.CharField(max_length=20)
    acc_created = models.DateTimeField(auto_now_add=True)
    last_sync = models.DateTimeField(auto_now=True)
    total_studied = models.IntegerField(default=0)
    latest_studied = models.IntegerField(default=0)
    
    USERNAME_FIELD = 'oauth_id'
    REQUIRED_FIELDS = ['nickname']

    objects = UserManager()

    def has_module_perms(self, app_label):
        if self.is_staff:
            return True
        else:
            return False

    def __str__(self):
        return self.nickname