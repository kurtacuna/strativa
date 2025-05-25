from django.db import models
from django.contrib.auth.models import User

class AdminLog(models.model):
    user = models.ForeignKey(User, on_delete=models.PROTECT)
    login_time = models.DateTimeField(auto_now_add=True)

def __str__(self):
        return f"{self.user.username} logged in at {self.login_time}"