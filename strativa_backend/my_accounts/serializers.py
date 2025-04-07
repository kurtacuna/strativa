from rest_framework import serializers
from . import models
from django.contrib.auth.models import User

class UserDataSerializer(serializers.ModelSerializer):
  user = serializers.SerializerMethodField()
  user_card_details = serializers.SerializerMethodField()

  def get_user(self, obj):
    serializer = UserSerializer(obj.user)
    return serializer.data

  def get_user_card_details(self, obj):
    serializer = UserCardDetailsSerializer(obj.user_card_details)
    return serializer.data

  class Meta:
    model = models.UserData
    # fields = '__all__'
    exclude = ['id']

class UserCardDetailsSerializer(serializers.ModelSerializer):
  class Meta:
    model = models.UserCardDetails
    # fields = '__all__'
    exclude = ['id', 'user']

class UserSerializer(serializers.ModelSerializer):
  class Meta:
    model = User
    fields = ['username']