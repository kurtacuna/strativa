from rest_framework import serializers
from . import models

class UserDataSerializer(serializers.ModelSerializer):
  class Meta:
    model = models.UserData
    fields = '__all__'

class UserCardDetailsSerailzer(serializers.ModelSerializer):
  class Meta:
    model = models.UserCardDetails
    fields = '__all__'