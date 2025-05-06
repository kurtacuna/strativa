from rest_framework import serializers
from . import models


class OtherBankAccountsSerializer(serializers.ModelSerializer):
    bank = serializers.SerializerMethodField()
    
    def get_bank(self, obj):
        serializer = OtherBanksSerializer(obj.bank)
        return serializer.data
    
    class Meta:
        model = models.OtherBankAccounts
        exclude = ['id']


class OtherBanksSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.OtherBanks
        fields = ['bank_name']