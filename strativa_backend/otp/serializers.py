from rest_framework import serializers
from . import models


class UserOtpSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.UserOtp
        exclude = ['user']