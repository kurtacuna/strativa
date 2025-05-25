from django.contrib.auth.signals import user_logged_in
from django.dispatch import receiver
from .models import AdminLog

@receiver(user_logged_in)
def log_admin_login(sender, request, user, **kwargs):
    
    if user.is_staff or user.is_superuser:
        AdminLog.objects.create(user=user)