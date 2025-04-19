from django.urls import path
from . import views

urlpatterns = [
    path('me/', views.UserDataView.as_view(), name="user-data"),
    path('me/accounts', views.UserAccountsView.as_view(), name="user-accounts")
]
