from django.urls import path
from . import views

urlpatterns = [
    path('me/', views.UserTransactionsView.as_view(), name='user-transactions'),
    path('transaction_fees/', views.TransactionFeesView.as_view(), name="transaction-fees"),
    path('transaction_fees_in_transaction/', views.TransactionFeesInTransactionView.as_view(), name='transaction-fees-in-transaction')
]
