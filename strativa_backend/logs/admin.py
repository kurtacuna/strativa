from django.contrib import admin
from .models import RequestLog
from . import models
from user_agents import parse as parse_ua
from django.utils import timezone

@admin.register(models.AdminLog)
class AdminLogAdmin(admin.ModelAdmin):
    def browser_info(self, obj):
        if obj.user_agent:
            ua = parse_ua(obj.user_agent)
            return f"{ua.browser.family} {ua.browser.version_string}"
        return "Unknown"

    def formatted_timestamp(self, obj):
        return timezone.localtime(obj.timestamp).strftime('%Y-%m-%d %H:%M:%S')

    list_display = ('formatted_timestamp', 'user', 'action', 'ip_address', 'browser_info')
    list_filter = ('action',)
    search_fields = ('user__username', 'ip_address', 'user_agent')

    browser_info.short_description = "Browser"
    formatted_timestamp.admin_order_field = 'timestamp'
    formatted_timestamp.short_description = 'Timestamp'

@admin.register(RequestLog)
class RequestLogAdmin(admin.ModelAdmin):
    list_display = ('timestamp', 'user', 'request_method', 'request_path', 'status_code', 'ip_address', 'source')
    list_filter = ('status_code', 'request_method', 'source')
    search_fields = ('request_path', 'user__username', 'ip_address')

