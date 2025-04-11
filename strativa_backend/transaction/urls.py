from django.urls import path
from . import views

urlpatterns = [
    path('me/', views.UserTransactionsView.as_view(), name='user-transactions')
]
