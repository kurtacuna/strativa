from django.test import SimpleTestCase, TestCase, Client
from django.urls import reverse, resolve
from django.contrib.auth.models import User
from my_accounts.models import UserCardDetails
from rest_framework.test import APITestCase, APIClient
from rest_framework import status
from rest_framework_simplejwt.tokens import RefreshToken
from . import views
from . import models

# class UserCardDetailsTest(TestCase):
#     def test_online_card_activation(self):
#         user = User.objects.create(username="testuser")
#         print(user)

#         card = UserCardDetails.objects.create(
#             user_id=1,
#             strativa_card_number="1234 5678 9012 3456",
#             strativa_card_expiry="2027-02-01",
#             strativa_card_cvv="123"
#         )

#         self.assertIsNone(card.online_card_number)

#         card.is_online_card_active = True
#         card.save()

#         print(card.online_card_number)
#         print(card.online_card_cvv)

#         self.assertIsNotNone(card.online_card_number)

class UserDataViewTest(APITestCase):
    def setUp(self):
        self.user = User.objects.create_user(username="testuser", password="pass")
        self.userdata = models.UserData.objects.create(first_name="test", last_name="user", user_id=1)
        
        self.client = APIClient()

        refresh = RefreshToken.for_user(self.user)
        self.token = str(refresh.access_token)

        self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {self.token}')

    def test_user_data_view(self):
        url = reverse('user_data')
        response = self.client.get(url)
        
        self.assertEqual(response.status_code, status.HTTP_200_OK)