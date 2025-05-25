import time
from .models import RequestLog
from django.utils.deprecation import MiddlewareMixin

class RequestLoggingMiddleware(MiddlewareMixin):
    def process_request(self, request):
        request.start_time = time.time()
        
        # Read body early and store it for later
        try:
            request._body = request.body  # force reading now
        except Exception:
            request._body = b''

    def process_response(self, request, response):
        response_time = (time.time() - request.start_time) * 1000  # in ms

        # Get user, skip if admin/staff
        user = request.user if hasattr(request, 'user') and request.user.is_authenticated else None
        if user and (user.is_staff or user.is_superuser):
            return response  # skip logging for admin/staff

        # Safely decode cached body
        try:
            body = request._body.decode('utf-8')[:1000]
        except Exception:
            body = '[Unreadable Body]'

        # Create log
        RequestLog.objects.create(
            user=user,
            request_method=request.method,
            request_path=request.get_full_path(),
            status_code=response.status_code,
            ip_address=request.META.get('REMOTE_ADDR', ''),
            user_agent=request.META.get('HTTP_USER_AGENT', ''),
            request_body=body,
            response_time_ms=response_time,
            source="mobile"
        )
        return response
