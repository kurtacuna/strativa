from django.urls import path
from . import views


# For testing only
urlpatterns = [
    path('', views.TransferView.as_view(), name="transfer"),
    path('transfer_fees/', views.TransferFeeView.as_view(), name="transfer-fees")
]