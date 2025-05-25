from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from user_agents import parse as parse_ua

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


# models.py

class AdminLog(models.Model):
    ACTION_CHOICES = [
        ('login', 'Login'),
        ('logout', 'Logout'),
    ]

    user = models.ForeignKey(User, on_delete=models.PROTECT)
    action = models.CharField(max_length=10, choices=ACTION_CHOICES)
    timestamp = models.DateTimeField(auto_now_add=True)
    ip_address = models.GenericIPAddressField(null=True, blank=True)
    user_agent = models.TextField(null=True, blank=True)
   
    def __str__(self):
        local_time = timezone.localtime(self.timestamp)
        action_display = self.get_action_display()
        if self.user_agent:
            ua = parse_ua(self.user_agent)
            browser_info = f"{ua.browser.family} {ua.browser.version_string}"
        else:
            browser_info = "Unknown browser"
        return f"{self.user.username} {action_display.lower()} at {local_time.strftime('%B %d, %Y | %H:%M:%S')} using {browser_info}"
