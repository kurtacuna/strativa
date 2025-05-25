from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
from user_agents import parse as parse_ua

class AdminLog(models.Model):
    user = models.ForeignKey(User, on_delete=models.PROTECT)
    login_time = models.DateTimeField(auto_now_add=True)
    user_agent = models.CharField(max_length=255, null=True, blank=True)

    def __str__(self):
        local_time = timezone.localtime(self.login_time)
        if self.user_agent:
            ua = parse_ua(self.user_agent)
            browser_info = f"{ua.browser.family} {ua.browser.version_string}"
        else:
            browser_info = "Unknown browser"
        return f"{self.user.username} logged in at {local_time.strftime('%B %d, %Y | %H:%M:%S')} using {browser_info}"