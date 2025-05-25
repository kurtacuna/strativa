from django.contrib.auth.signals import user_logged_in, user_logged_out
from django.dispatch import receiver
from django.utils import timezone
from datetime import timedelta
from .models import AdminLog

def get_client_ip(request):
    x_forwarded_for = request.META.get("HTTP_X_FORWARDED_FOR")
    if x_forwarded_for:
        return x_forwarded_for.split(",")[0]
    return request.META.get("REMOTE_ADDR")

@receiver(user_logged_in)
def log_admin_login(sender, request, user, **kwargs):
    if not user.is_staff and not user.is_superuser:
        return

    user_agent = request.META.get("HTTP_USER_AGENT", "")
    ip_address = get_client_ip(request)

    # Avoid duplicate logs within 5 seconds
    recent_log_exists = AdminLog.objects.filter(
        user=user,
        action='login',
        timestamp__gte=timezone.now() - timedelta(seconds=5)
    ).exists()

    if not recent_log_exists:
        AdminLog.objects.create(
            user=user,
            action='login',
            ip_address=ip_address,
            user_agent=user_agent,
        )

@receiver(user_logged_out)
def log_admin_logout(sender, request, user, **kwargs):
    if not user or (not user.is_staff and not user.is_superuser):
        return

    user_agent = request.META.get("HTTP_USER_AGENT", "")
    ip_address = get_client_ip(request)

    AdminLog.objects.create(
        user=user,
        action='logout',
        ip_address=ip_address,
        user_agent=user_agent,
    )
