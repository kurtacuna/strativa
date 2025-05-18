from rest_framework import serializers
from . import models
from utils.common_serializers import UserSerializer
from other_banks import models as other_banks_models
from other_banks import serializers as other_banks_serializers


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
        profile_picture = user_data.profile_picture.url if user_data else "/media/images/logo.png"
        serializer = UserSerializer(obj.sender)
        data = serializer.data
        data['full_name'] = full_name
        data['profile_picture'] = profile_picture
        return data
    
    def get_receiver(self, obj):
        if obj.receiver_bank == 'Strativa':
            user_data = getattr(obj.receiver, 'userdata', None)
            full_name = user_data.full_name if user_data else "Deleted"
            profile_picture = user_data.profile_picture.url if user_data else "/media/images/logo.png"
            serializer = UserSerializer(obj.receiver)
            data = serializer.data
            data['full_name'] = full_name
            data['profile_picture'] = profile_picture
            return data
        else:
            other_bank_account_data = other_banks_models.OtherBankAccounts.objects.get(
                bank__bank_name=obj.receiver_bank,
                account_number=obj.receiver_account_number
            )
            serializer = other_banks_serializers.OtherBankAccountsSerializer(other_bank_account_data)
            serializer.fields.pop("balance")
            data = serializer.data
            data["username"] = other_bank_account_data.user.username
            data["profile_picture"] = "/media/images/logo.png"
            return data

    class Meta:
        model = models.Transactions
        exclude = ['id']


class TransactionTypesSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.TransactionTypes
        fields = ['type']


class TransactionFeesSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.TransactionFees
        exclude = ["id"]


class TransactionFeesInTransactionSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.TransactionFeesInTransaction
        exclude = ["id", "transaction_id", "transaction_reference_id"]