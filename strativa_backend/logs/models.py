from django.db import models
from django.contrib.auth.models import User

class RequestLog(models.Model):
    user = models.ForeignKey(User, null=True, blank=True, on_delete=models.SET_NULL)
    timestamp = models.DateTimeField(auto_now_add=True)
    request_method = models.CharField(max_length=10)
    request_path = models.TextField()
    status_code = models.IntegerField()
    ip_address = models.GenericIPAddressField()
    user_agent = models.TextField()
    request_body = models.TextField(blank=True, null=True)
    response_time_ms = models.FloatField(null=True, blank=True)
    source = models.CharField(max_length=50, default="mobile")

    def __str__(self):
        return f"{self.timestamp} - {self.request_method} {self.request_path}"
