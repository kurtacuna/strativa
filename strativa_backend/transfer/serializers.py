from rest_framework import serializers
from . import models


class TransferFeesSerializer(serializers.ModelSerializer):
    class Meta:
        model = models.TransferFees
        exclude = ["id"]