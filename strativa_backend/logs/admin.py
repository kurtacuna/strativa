# logs/admin.py

from django.contrib import admin
from .models import RequestLog
from . import models

admin.site.register(models.AdminLog)

@admin.register(RequestLog)
class RequestLogAdmin(admin.ModelAdmin):
    list_display = ('timestamp', 'user', 'request_method', 'request_path', 'status_code', 'ip_address', 'source')
    list_filter = ('status_code', 'request_method', 'source')
    search_fields = ('request_path', 'user__username', 'ip_address')

