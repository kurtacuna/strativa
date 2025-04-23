from django.test import TestCase
from django.urls import reverse
from django.contrib.auth.models import User
from my_accounts.models import UserCardDetails
from rest_framework.test import APITestCase, APIClient
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
from . import models
import json
from transaction import models as transaction_models


# class UserCardDetailsTest(TestCase):
#     def test_online_card_activation(self):
#         user = User.objects.create(username="testuser")

#         card = UserCardDetails.objects.create(
#             user=User.objects.get(id=1),
#         )
#         card.save()

#         self.assertIsNone(card.online_card_number)

#         card.is_online_card_active = True
#         card.create_online_card()

#         # print(card.online_card_number)
#         # print(card.online_card_cvv)

#         self.assertIsNotNone(card.online_card_number)


class UserDataViewTest(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(username="testuser", password="pass")
        transaction_type = transaction_models.TransactionTypes.objects.create(type="other")
        user_type = models.UserTypes.objects.create(
            user_type="regular"
        )
        user_card_details = UserCardDetails.objects.create(user_id=1)
        user_data = models.UserData.objects.create(
            first_name="test", 
            last_name="user", 
            user_id=1, 
            user_card_details=UserCardDetails.objects.get(user_id=1),
        )
        account_type = models.AccountTypes.objects.create(
            account_type="Savings",
            code="S"
        )
        user_account = models.UserAccounts.objects.create(
            user=self.user,
            account_type=account_type,
            account_number="p23pi5j",
        )
        
        self.client = APIClient()

        refresh = RefreshToken.for_user(self.user)
        token = str(refresh.access_token)

        self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {token}')

    def test_user_data_view(self):
        url = reverse('user-data')
        response = self.client.get(url)

        print(response.content)
        
        self.assertEqual(response.status_code, status.HTTP_200_OK)

    # def test_user_accounts_view(self):
    #     url = reverse('user-accounts')
    #     response = self.client.get(url)

    #     print(response.content)

    # def test_check_if_user_account_exists(self):
    #     url = reverse("check-if-account-exists")
    #     response = self.client.post(
    #         url,
    #         content_type="application/json",
    #         data=json.dumps({
    #             "account_number": "p23pi5j"
    #         })
    #     )

    #     print(response.content)