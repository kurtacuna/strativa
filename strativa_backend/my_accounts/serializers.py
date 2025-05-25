from rest_framework import serializers
from . import models
from utils.common_serializers import UserSerializer
from transaction import serializers as transaction_serializers
import utils.aes_encryption_decryption as aes
from datetime import datetime

class UserDataSerializer(serializers.ModelSerializer):
  user = serializers.SerializerMethodField()
  user_type = serializers.SerializerMethodField()
  profile_picture = serializers.SerializerMethodField()
  user_card_details = serializers.SerializerMethodField()

  def get_user(self, obj):
    serializer = UserSerializer(obj.user)
    return serializer.data
  
  def get_user_type(self, obj):
    serializer = UserTypesSerializer(obj.user_type)
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


class UserTypesSerializer(serializers.ModelSerializer):
  transaction_category = serializers.SerializerMethodField()

  def get_transaction_category(self, obj):
    serializer = transaction_serializers.TransactionTypesSerializer(obj.transaction_category)
    return serializer.data

  class Meta:
    model = models.UserTypes
    exclude = ['id']


class UserCardDetailsSerializer(serializers.ModelSerializer):
  strativa_card_number = serializers.SerializerMethodField()
  strativa_card_created = serializers.SerializerMethodField()
  strativa_card_expiry = serializers.SerializerMethodField()
  strativa_card_cvv = serializers.SerializerMethodField()

  is_online_card_active = serializers.SerializerMethodField()
  online_card_number = serializers.SerializerMethodField()
  online_card_created = serializers.SerializerMethodField()
  online_card_expiry = serializers.SerializerMethodField()
  online_card_cvv = serializers.SerializerMethodField()

  def get_strativa_card_number(self, obj):
      return aes.decrypt(obj.strativa_card_number)

  def get_strativa_card_created(self, obj):
      return aes.decrypt(obj.strativa_card_created)

  def get_strativa_card_expiry(self, obj):
      return aes.decrypt(obj.strativa_card_expiry)

  def get_strativa_card_cvv(self, obj):
      return aes.decrypt(obj.strativa_card_cvv)
  
  def get_is_online_card_active(self, obj):
      return bool(aes.decrypt(obj.is_online_card_active))

  def get_online_card_number(self, obj):
      if not obj.online_card_number:
         return obj.online_card_cvv
      return aes.decrypt(obj.online_card_number)

  def get_online_card_created(self, obj):
      if not obj.online_card_created:
         return obj.online_card_cvv
      return aes.decrypt(obj.online_card_created)

  def get_online_card_expiry(self, obj):
      if not obj.online_card_expiry:
         return obj.online_card_cvv
      return aes.decrypt(obj.online_card_expiry)

  def get_online_card_cvv(self, obj):
      if not obj.online_card_cvv:
         return obj.online_card_cvv
      return aes.decrypt(obj.online_card_cvv)

  
  class Meta:
    model = models.UserCardDetails
    exclude = ['user']

  
class UserAccountsSerializer(serializers.ModelSerializer):
  def __init__(self, *args, **kwargs):
    filter = kwargs.pop("filter", {})
    include_fields = filter.get('include_fields')
    exclude_fields = filter.get('exclude_fields')
    super().__init__(*args, **kwargs)

    if include_fields is not None:
      all_fields = set(self.fields)
      included_fields = set(include_fields)
      for field in all_fields - included_fields:
        self.fields.pop(field, None)

    if exclude_fields is not None:
      for field in exclude_fields:
        self.fields.pop(field, None)

  account_type = serializers.SerializerMethodField()
  bank = serializers.SerializerMethodField()
  account_number = serializers.SerializerMethodField()
  balance = serializers.SerializerMethodField()

  def get_account_type(self, obj):
    serializer = AccountTypesSerializer(obj.account_type)
    return serializer.data

  def get_bank(self, obj):
    serializer = StrativaBanksSerializer(obj.bank)
    return serializer.data
  
  def get_account_number(self, obj):
    return aes.decrypt(obj.account_number)
  
  def get_balance(self, obj):
    return aes.decrypt(obj.balance)

  class Meta:
    model = models.UserAccounts
    exclude = ['id', 'user', 'hashed_account_number']


class AccountTypesSerializer(serializers.ModelSerializer):
  class Meta:
    model = models.AccountTypes
    fields = ['account_type']


class StrativaBanksSerializer(serializers.ModelSerializer):
  class Meta:
    model = models.StrativaBanks
    exclude = ['id']