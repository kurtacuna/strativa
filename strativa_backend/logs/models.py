from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone

class AdminLog(models.Model):
    user = models.ForeignKey(User, on_delete=models.PROTECT)
    login_time = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        local_time = timezone.localtime(self.login_time)
        return f"{self.user.username} logged in at {local_time.strftime('%B %d, %Y'' | ''%H:%M:%S')}"