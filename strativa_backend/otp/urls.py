from django.urls import path
from . import views

urlpatterns = [
    path('create/', views.CreateOtpView.as_view(), name='create-otp'),
    path('verify/', views.VerifyOtpView.as_view(), name='verify-otp'), 
]