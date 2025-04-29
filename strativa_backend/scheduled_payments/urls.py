from django.urls import path
from . import views

# For testing only
urlpatterns = [
    path('', views.SchedulePaymentView.as_view(), name="scheduled-payment")
]