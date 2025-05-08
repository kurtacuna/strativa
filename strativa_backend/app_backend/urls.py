"""
URL configuration for app_backend project.

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/5.1/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path, include
from django.conf import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),

    path('auth/', include('djoser.urls')),
    path('auth/', include('djoser.urls.jwt')),

    # Every transaction must go through otp verification
    path('otp/', include('otp.urls')),

    path('api/my_accounts/', include('my_accounts.urls')),
    path('api/transaction/', include('transaction.urls')),
    path('api/other_banks/', include('other_banks.urls')),
    path('api/scheduled_payments/', include('scheduled_payments.urls')),
    path('api/transfer/', include('transfer.urls')),



    # For testing only
    path('api/transfer/', include('transfer.urls')),
]

# For fetching images
if settings.DEBUG:
    urlpatterns.extend(static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT))
