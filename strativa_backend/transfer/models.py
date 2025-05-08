from django.db import models

# Create your models here.
class TransferFees(models.Model):
    type = models.CharField(max_length=255)
    fee = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return self.type

    class Meta:
        verbose_name = "Transfer Fee"
        verbose_name_plural = "Transfer Fees"