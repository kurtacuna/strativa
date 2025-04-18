from rest_framework.test import APITestCase, APIClient
from django.contrib.auth.models import User
from django.urls import reverse
from my_accounts import models as my_accounts_models
from transaction import models as transaction_models
from rest_framework_simplejwt.tokens import RefreshToken
import json


class TransferViewTest(APITestCase):
    def setUp(self):
        self.user1 = User.objects.create(username="testuser")
        self.user1_card_details = my_accounts_models.UserCardDetails.objects.create(
            user=self.user1,
            account_number="CW-L2345B6JK",
            balance=200
        )

        account_type = my_accounts_models.AccountTypes.objects.create(
            account_type="Savings Account",
            code="SA"
        )

        self.user2 = User.objects.create(username="receiveruser")
        self.user2_account_details = my_accounts_models.UserAccounts.objects.create(
            user=self.user2,
            account_type=account_type,
            account_number="SA-KL2345H6J",
            balance=0
        )

        transaction_models.TransactionTypes.objects.create(type="transfers")

        self.client = APIClient()
        
        refresh = RefreshToken.for_user(self.user1)
        token = refresh.access_token

        self.client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")
    
    def test_transfer_view(self):
        url = reverse('transfer')
        
        print(f"sender before balance: {self.user1_card_details.balance}")
        print(f"receiver before balance: {self.user2_account_details.balance}")

        response = self.client.post(
            url,
            content_type="application/json",
            data=json.dumps({
                "transaction_details": {
                    "transaction_type": "transfers",
                    "amount": "123.00",
                    "note": "payment",
                    "sender": {
                        "account_number": "CW-L2345B6JK",
                    },
                    "receiver": {
                        "account_number": "SA-KL2345H6J",
                    },
                },
            })
        )

        self.user1_card_details.refresh_from_db()
        self.user2_account_details.refresh_from_db()

        print(f"sender after balance: {self.user1_card_details.balance}")
        print(f"receiver after balance: {self.user2_account_details.balance}")

        print(transaction_models.Transactions.objects.all().values())

        print(response.content)