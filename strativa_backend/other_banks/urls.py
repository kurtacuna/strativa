from django.urls import path
from . import views

urlpatterns = [
    path('other_banks/', views.OtherBanksView.as_view(), name="other-banks"),
    path('check_other_bank_account/', views.CheckIfOtherBankAccountExistsView.as_view(), name="check-if-other-bank-account-exists"),
]