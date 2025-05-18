from django.contrib import admin
from . import models

# Register your models here.
admin.site.register(models.UserTransactions)
admin.site.register(models.Transactions)
admin.site.register(models.TransactionTypes)
admin.site.register(models.TransactionFees)
admin.site.register(models.TransactionFeesInTransaction)