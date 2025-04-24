from django.urls import reverse
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.test import APIClient, APITestCase
from django.contrib.auth.models import User
from my_accounts import models as my_accounts_models
from transaction import models as transaction_models
from . import models
import json

# Create your tests here.
class CheckIfOtherAccountExistsViewTest(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(username="testuser", password="pass")
        other_bank_user  = User.objects.create(id=3, username="other bank user")
        transaction_type = transaction_models.TransactionTypes.objects.create(type="other")
        user_type = my_accounts_models.UserTypes.objects.create(
            user_type="regular"
        )
        user_card_details = my_accounts_models.UserCardDetails.objects.create(user_id=1)
        user_data = my_accounts_models.UserData.objects.create(
            first_name="test", 
            last_name="user", 
            user_id=1, 
            user_card_details=my_accounts_models.UserCardDetails.objects.get(user_id=1),
        )
        account_type = my_accounts_models.AccountTypes.objects.create(
            account_type="Savings",
            code="S"
        )
        user_account = my_accounts_models.UserAccounts.objects.create(
            user=self.user,
            account_type=account_type,
            account_number="p23pi5j",
        )

        other_bank = models.OtherBanks.objects.create(bank_name="Banco de Oro")
        other_bank = models.OtherBanks.objects.create(bank_name="Banco de Oro1")
        other_bank = models.OtherBanks.objects.create(bank_name="Banco de Oro2")
        other_bank = models.OtherBanks.objects.create(bank_name="Banco de Oro3")
        other_bank = models.OtherBanks.objects.create(bank_name="Banco de Oro4")
        other_bank = models.OtherBanks.objects.create(bank_name="Banco de Oro5")
        other_bank_account = models.OtherBankAccounts.objects.create(
            bank=other_bank,
            full_name="OtherBankUser",
            account_number="1234"
        )

        self.client = APIClient()
        
        refresh = RefreshToken.for_user(self.user)
        token = str(refresh.access_token)

        self.client.credentials(HTTP_AUTHORIZATION=f"Bearer {token}")

    def test_get_other_banks(self):
        url = reverse('other-banks')
        response = self.client.get(url)

        print(response.content)

    # def test_check_if_other_bank_account_exists(self):
    #     url = reverse("check-if-other-bank-account-exists")
    #     response = self.client.post(
    #         url,
    #         content_type="application/json",
    #         data=json.dumps({
    #             "other_bank_account_details": {
    #                 "bank": "Banco De Oro",
    #                 "account_number": "1234"
    #             }
    #         })
    #     )

    #     print(response.content)
        
