from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from utils.const import BackendConstants
from my_accounts import models as my_accounts_models
from decimal import Decimal
import utils.aes_encryption_decryption as aes


class UserTransactions(models.Model):
    class Direction(models.TextChoices):
        SEND = 'send'
        RECEIVE = 'receive'

    user = models.ForeignKey(User, on_delete=models.CASCADE)
    transaction = models.ForeignKey('Transactions', on_delete=models.CASCADE)
    direction = models.CharField(max_length=20, choices=Direction.choices)
    resulting_balance = models.TextField()

    def __str__(self):
        return self.user.username

    class Meta:
        verbose_name = "User Transaction"
        verbose_name_plural = "User Transactions"


class Transactions(models.Model):
    reference_id = models.CharField(max_length=32, unique=True)
    datetime = models.TextField()
    amount = models.TextField()
    transaction_type = models.ForeignKey('TransactionTypes', on_delete=models.SET_DEFAULT, default=1)
    sender = models.ForeignKey(User, on_delete=models.SET_DEFAULT, default=1, related_name='sender_transactions_set')
    sender_account_number = models.TextField()
    sender_bank = models.CharField(max_length=255)
    receiver = models.ForeignKey(User, on_delete=models.SET_DEFAULT, default=1, related_name='receiver_transactions_set')
    receiver_account_number = models.TextField()
    receiver_bank = models.CharField(max_length=255)
    note = models.TextField(blank=True)
    transaction_fees_applied = models.BooleanField()

    def __str__(self):
        return self.reference_id
    
    def save(self, *args, **kwargs):
        self.reference_id = BackendConstants.get_uuid()
        self.datetime = aes.encrypt(timezone.now())

        super().save(*args, **kwargs)
        
        sender_account_balance = my_accounts_models.UserAccounts.objects.get(
            account_number=self.sender_account_number
        ).balance
        UserTransactions.objects.create(
            user=self.sender,
            transaction=self,
            direction=UserTransactions.Direction.SEND,
            resulting_balance=sender_account_balance
        )
        
        if self.receiver_bank == "Strativa":
            receiver_account_balance = my_accounts_models.UserAccounts.objects.get(
                account_number=self.receiver_account_number
            ).balance
            UserTransactions.objects.create(
                user=self.receiver,
                transaction=self,
                direction=UserTransactions.Direction.RECEIVE,
                resulting_balance=receiver_account_balance
            )
    
    class Meta:
        verbose_name = 'Transaction'
        verbose_name_plural = 'Transactions'


# The transaction fees applied to a particular transaction
class TransactionFeesInTransaction(models.Model):
    transaction_id = models.ForeignKey(Transactions, on_delete=models.PROTECT)
    transaction_reference_id = models.CharField(max_length=255)
    type = models.CharField(max_length=255)
    fee = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return str(self.transaction_id)

    class Meta:
        verbose_name = 'Transaction Fees in Transaction'
        verbose_name_plural = 'Transaction Fees in Transactions'


# Holds all transaction fees
class TransactionFees(models.Model):
    type = models.CharField(max_length=255)
    fee = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return self.type

    class Meta:
        verbose_name = "Transaction Fee"
        verbose_name_plural = "Transaction Fees"


class TransactionTypes(models.Model):
    type = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.type
    
    class Meta:
        verbose_name = 'Transaction Type'
        verbose_name_plural = 'Transaction Types'