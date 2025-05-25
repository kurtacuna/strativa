from rest_framework import serializers
from . import models
import utils.aes_encryption_decryption as aes


class OtherBankAccountsSerializer(serializers.ModelSerializer):
    bank = serializers.SerializerMethodField()
    balance = serializers.SerializerMethodField()
    
    def get_bank(self, obj):
        serializer = OtherBanksSerializer(obj.bank)
        return serializer.data
    
    def get_balance(self, obj):
        return aes.encrypt(obj.balance)
    
    class Meta:
        model = models.OtherBankAccounts
        exclude = ['id']


class OtherBanksSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.OtherBanks
        fields = ['bank_name']