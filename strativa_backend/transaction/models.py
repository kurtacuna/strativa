from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from utils.const import BackendConstants
from my_accounts import models as my_accounts_models
from decimal import Decimal


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
    sender_account_number = models.CharField(max_length=30)
    receiver = models.ForeignKey(User, on_delete=models.SET_DEFAULT, default=1, related_name='receiver_transactions_set')
    receiver_account_number = models.CharField(max_length=30)
    note = models.CharField(max_length=255, blank=True)

    def __str__(self):
        return self.reference_id
    
    def save(self, *args, **kwargs):
        self.reference_id = BackendConstants.get_uuid()
        self.datetime = timezone.now()

        super().save(*args, **kwargs)
        
        sender_account_balance = my_accounts_models.UserAccounts.objects.get(
            account_number=self.sender_account_number
        ).balance
        UserTransactions.objects.create(
            user=self.sender,
            transaction=self,
            direction=UserTransactions.Direction.SEND,
            resulting_balance=Decimal(sender_account_balance) - Decimal(self.amount)
        )
        
        receiver_account_balance = my_accounts_models.UserAccounts.objects.get(
            account_number=self.receiver_account_number
        ).balance
        UserTransactions.objects.create(
            user=self.receiver,
            transaction=self,
            direction=UserTransactions.Direction.RECEIVE,
            resulting_balance=Decimal(receiver_account_balance) + Decimal(self.amount)
        )
    
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