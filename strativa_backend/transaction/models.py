from django.db import models
from django.contrib.auth.models import User
import uuid
from django.utils import timezone


class UserTransactions(models.Model):
    class Direction(models.TextChoices):
        SEND = 'send'
        RECEIVE = 'receive'

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    transaction = models.ForeignKey('Transactions', on_delete=models.CASCADE)
    direction = models.CharField(max_length=20, choices=Direction.choices)
    resulting_balance = models.DecimalField(max_digits=10, decimal_places=2, blank=False, null=False)

    def __str__(self):
        return self.user.username

    class Meta:
        verbose_name = "User Transaction"
        verbose_name_plural = "User Transactions"


class Transactions(models.Model):
    reference_id = models.CharField(max_length=32, unique=True)
    datetime = models.DateTimeField()
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    transaction_type = models.ForeignKey('TransactionTypes', on_delete=models.SET_DEFAULT, default=1)
    sender = models.ForeignKey(User, on_delete=models.SET_DEFAULT, default=1, related_name='sender_transactions_set')
    receiver = models.ForeignKey(User, on_delete=models.SET_DEFAULT, default=1, related_name='receiver_transactions_set')
    note = models.CharField(max_length=255, blank=True)

    def __str__(self):
        return self.reference_id
    
    def save(self, *args, **kwargs):
        self.reference_id = uuid.uuid4().hex.upper()
        self.datetime = timezone.now()
        super().save(*args, **kwargs)
    
    class Meta:
        verbose_name = 'Transaction'
        verbose_name_plural = 'Transactions'


class TransactionTypes(models.Model):
    type = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.type
    
    class Meta:
        verbose_name = 'Transaction Type'
        verbose_name_plural = 'Transaction Types'