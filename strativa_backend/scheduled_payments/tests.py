from rest_framework.test import APITestCase, APIClient
from rest_framework_simplejwt.tokens import RefreshToken
from django.urls import reverse
from django.contrib.auth.models import User
from my_accounts import models as my_accounts_models
from other_banks import models as other_banks_models
import json
from scheduled_payments import models as scheduled_payments_models
from transaction import models as transaction_models
from django.core.management import call_command
from django.utils import timezone
from unittest.mock import patch
from datetime import datetime


class ScheduledPaymentsTest(APITestCase):
    def setUp(self):
        account_type = my_accounts_models.AccountTypes.objects.create(
            account_type="Savings Account",
            code="SA"
        )
        self.user1 = User.objects.create(username="testuser")
        strativa_bank = my_accounts_models.StrativaBanks.objects.create(bank_name='Strativa')
        self.user1_account_details = my_accounts_models.UserAccounts.objects.create(
            user=self.user1,
            account_type=account_type,
            account_number="SA-456LJK54",
            balance=200
        )

        self.user2 = User.objects.create(username="receiveruser")
        self.user2_account_details = my_accounts_models.UserAccounts.objects.create(
            user=self.user2,
            account_type=account_type,
            account_number="SA-KL2345H6J",
        )

        other_bank_user = User.objects.create(id=3, username="other bank user")
        other_bank = other_banks_models.OtherBanks.objects.create(bank_name="Banco de Oro")
        self.other_bank_account = other_banks_models.OtherBankAccounts.objects.create(
            bank=other_bank,
            full_name="Other Bank User",
            account_number="1234"
        )

        transaction_type = transaction_models.TransactionTypes.objects.create(type="bills")

        self.client = APIClient()

        refresh = RefreshToken.for_user(self.user1)
        token = refresh.access_token
        self.client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")

    def test_1_scheduled_payment(self):
        url = reverse("scheduled-payment")
        response = self.client.post(
            url,
            content_type="application/json",
            data=json.dumps({
                "user_id": "1",
                "transaction_details": {
                    "transaction_type": "bills",
                    "start_date": "2025-05-28 18:37:59.123456+00:00",
                    # frequency in days (e.g. every 10 days)
                    "frequency": "10",
                    # duration is how many times the payment should happen
                    "duration": "3",
                    "amount": "125",
                    "note": "payment",
                    "sender": {
                        "account_number": "SA-456LJK54",
                        "bank": "Strativa"
                    },
                    "receiver": {
                        "bank": "Banco de Oro",
                        "account_number": "1234"
                    }
                }
            })
        )
        
        print(scheduled_payments_models.ScheduledPayments.objects.all().values())

        print(self.user1_account_details.balance)
        print(self.other_bank_account.balance)   
        
        with patch('django.utils.timezone.now') as mock_now:
            mock_now.return_value = timezone.make_aware(datetime(2025, 5, 30, 10, 0, 0))
            
            print("before command")
            call_command('execute_scheduled_payments')
            self.user1_account_details.refresh_from_db()
            self.other_bank_account.refresh_from_db()
            
            print("after command")
            print(scheduled_payments_models.ScheduledPayments.objects.all().values())
            self.user1_account_details.refresh_from_db()
            self.other_bank_account.refresh_from_db()
            print(self.user1_account_details.balance)
            print(self.other_bank_account.balance)

        print(transaction_models.Transactions.objects.all().values())