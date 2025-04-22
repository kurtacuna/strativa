from django.contrib import admin
from . import models

# Register your models here.
admin.site.register(models.UserData)
admin.site.register(models.UserCardDetails)
admin.site.register(models.UserAccounts)
admin.site.register(models.AccountTypes)