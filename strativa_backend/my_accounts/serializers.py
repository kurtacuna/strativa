from rest_framework import serializers
from . import models
from utils import common_serializers

class UserDataSerializer(serializers.ModelSerializer):
  user = serializers.SerializerMethodField()
  profile_picture = serializers.SerializerMethodField()
  user_card_details = serializers.SerializerMethodField()

  def get_user(self, obj):
    serializer = common_serializers.UserSerializer(obj.user)
    return serializer.data
  
  def get_profile_picture(self, obj):
    if obj.profile_picture:
      return obj.profile_picture.url

  def get_user_card_details(self, obj):
    serializer = UserCardDetailsSerializer(obj.user_card_details)
    return serializer.data

  class Meta:
    model = models.UserData
    fields = '__all__'


class UserCardDetailsSerializer(serializers.ModelSerializer):
  class Meta:
    model = models.UserCardDetails
    exclude = ['user']

  
class UserAccountsSerializer(serializers.ModelSerializer):
  account_type = serializers.SerializerMethodField()

  def get_account_type(self, obj):
    serializer = AccountTypesSerializer(obj.account_type)
    return serializer.data

  class Meta:
    model = models.UserAccounts
    exclude = ['id', 'user']


class AccountTypesSerializer(serializers.ModelSerializer):
  class Meta:
    model = models.AccountTypes
    fields = ['account_type']