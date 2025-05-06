from django.db import models
from django.contrib.auth.models import User

# Create your models here.
class OtherBankAccounts(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE, default=3)
    bank = models.ForeignKey('OtherBanks', on_delete=models.CASCADE)
    full_name = models.CharField(max_length=255)
    account_number = models.CharField(max_length=255)
    balance = models.DecimalField(max_digits=10, decimal_places=2, default=0)

    def __str__(self):
        return self.account_number

    class Meta:
        verbose_name = "Other Bank Account"
        verbose_name_plural = "Other Bank Accounts"


class OtherBanks(models.Model):
    bank_name = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.bank_name
    
    class Meta:
        verbose_name = "Other Bank"
        verbose_name_plural = "Other Banks"