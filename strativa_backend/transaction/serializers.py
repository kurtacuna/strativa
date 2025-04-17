from rest_framework import serializers
from . import models
from utils import common_serializers


class UserTransactionsSerializer(serializers.ModelSerializer):
    transaction = serializers.SerializerMethodField()

    def get_transaction(self, obj):
        serializer = TransactionsSerializer(obj.transaction)
        return serializer.data
    
    class Meta:
        model = models.UserTransactions
        exclude = ['id', 'user']


class TransactionsSerializer(serializers.ModelSerializer):
    transaction_type = serializers.SerializerMethodField()
    sender = serializers.SerializerMethodField()
    receiver = serializers.SerializerMethodField()

    def get_transaction_type(self, obj):
        serializer = TransactionTypesSerializer(obj.transaction_type)
        return serializer.data
    
    def get_sender(self, obj):
        user_data = getattr(obj.sender, 'userdata', None)
        full_name = user_data.full_name if user_data else "Deleted"
        profile_picture = user_data.profile_picture.url if user_data else "/images/logo.png"
        serializer = common_serializers.UserSerializer(obj.sender)
        data = serializer.data
        data['full_name'] = full_name
        data['profile_picture'] = profile_picture
        return data
    
    def get_receiver(self, obj):
        user_data = getattr(obj.receiver, 'userdata', None)
        full_name = user_data.full_name if user_data else "Deleted"
        profile_picture = user_data.profile_picture.url if user_data else "/images/logo.png"
        serializer = common_serializers.UserSerializer(obj.receiver)
        data = serializer.data
        data['full_name'] = full_name
        data['profile_picture'] = profile_picture
        return data

    class Meta:
        model = models.Transactions
        exclude = ['id']


class TransactionTypesSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.TransactionTypes
        fields = ['type']