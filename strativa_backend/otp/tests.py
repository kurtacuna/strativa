from django.test import TestCase
from rest_framework.test import APITestCase, APIClient
from django.contrib.auth.models import User
from my_accounts import models as my_accounts_models
from django.urls import reverse
from otp import models as otp_models
from my_accounts import models as my_accounts_models
import pyotp
from utils.const import BackendConstants
import time


class OtpViewsTest(APITestCase):
    def setUp(self):
        account_type = my_accounts_models.AccountTypes.objects.create(
            account_type="Card/Wallet",
            code="CW"
        )
        self.user = User.objects.create(username="testuser")
        user_card_details = my_accounts_models.UserCardDetails.objects.create(user=self.user)
        user_account_details = my_accounts_models.UserAccounts.objects.create(
            user=self.user,
            account_type=account_type,
            account_number="123",
            balance=200
        )
        user_data = my_accounts_models.UserData.objects.create(
            user=self.user,
            first_name="test",
            last_name="user",
            email="csprojectserver@gmail.com",
            user_card_details=user_card_details
        )
        self.client = APIClient()
    
    def test_create_otp(self):
        create_otp_url = reverse('create-otp')
        create_otp_response = self.client.post(
            create_otp_url,
            data={"account_number": "123"}
        )

        self.otp = pyotp.TOTP(
            otp_models.UserOtp.objects.get(id=1).otp_secret, 
            digits=BackendConstants.otp_length, 
            interval=BackendConstants.otp_valid_duration
        ).now()

        print(self.otp)

        peek_url = reverse('verify-otp') + '?type=peekbalance'
        peek_response = self.client.post(
            peek_url,
            data={
                "account_number": "123",
                "otp": self.otp
            }
        )

        print(peek_response.content)