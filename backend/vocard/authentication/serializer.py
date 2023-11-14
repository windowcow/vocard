from rest_framework import serializers
from authentication.models import User


class UserSerializer(serializers.ModelSerializer):
    serializers.PrimaryKeyRelatedField(many=True, queryset=User.objects.all())

    class Meta:
        model = User
        fields = ['usr_id', 'oauth_id', 'nickname', 'acc_created', 'last_sync', 'total_studied', 'latest_studied',]