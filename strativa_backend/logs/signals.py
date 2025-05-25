from django.contrib.auth.signals import user_logged_in
from django.dispatch import receiver
from django.utils import timezone
from datetime import timedelta
from .models import AdminLog

@receiver(user_logged_in)
def log_admin_login(sender, request, user, **kwargs):
    if not user.is_staff and not user.is_superuser:
        return  # Only log admin/staff logins

    user_agent = request.META.get('HTTP_USER_AGENT', '')

    # Avoid duplicate logs within 5 seconds
    recent_log_exists = AdminLog.objects.filter(
        user=user,
        login_time__gte=timezone.now() - timedelta(seconds=5)
    ).exists()

    if not recent_log_exists:
        AdminLog.objects.create(user=user, user_agent=user_agent)