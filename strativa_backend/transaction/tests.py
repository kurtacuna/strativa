from django.test import TestCase
from django.contrib.auth.models import User
from . import models
from my_accounts import models as my_accounts_models
from my_accounts import serializers as my_accounts_serializers
from . import serializers
from rest_framework.test import APIClient, APITestCase
from rest_framework_simplejwt.tokens import RefreshToken
from django.urls import reverse
from django.db.models import Q, Prefetch

# class UserTransactionsTest(TestCase):
#     def test_user_transactions(self):
#         sender = User.objects.create(username="testsender")
#         receiver = User.objects.create(username="testreceiver")
#         user = User.objects.get(id=1)
#         transaction_type = models.TransactionTypes.objects.create(type="all")
        
#         transaction = models.Transactions.objects.create(
#             amount=100,
#             transaction_type=models.TransactionTypes.objects.get(id=1),
#             sender=User.objects.get(id=1),
#             receiver=User.objects.get(id=2),
#         )
#         transaction2 = models.Transactions.objects.create(
#             amount=100,
#             transaction_type=models.TransactionTypes.objects.get(id=1),
#             sender=User.objects.get(id=1),
#             receiver=User.objects.get(id=2),
#         )

#         user_transactions = models.UserTransactions.objects.create(
#             user=User.objects.get(id=1),
#             transaction=models.Transactions.objects.get(id=1),
#             direction=models.UserTransactions.Direction.SEND,
#             resulting_balance=200.00
#         )
#         user_transactions2 = models.UserTransactions.objects.create(
#             user=User.objects.get(id=1),
#             transaction=models.Transactions.objects.get(id=2),
#             direction=models.UserTransactions.Direction.SEND,
#             resulting_balance=400.00
#         )
        
#         transactions = models.UserTransactions.objects.filter(user=User.objects.get(id=1))
#         serializer = serializers.UserTransactionsSerializer(transactions, many=True)

#         print(serializer.data)

#         self.assertIsNotNone(models.Transactions.objects.get(id=1))


class UserTransactionsViewTest(APITestCase):
    def setUp(self):
        sender = User.objects.create(username="testsender")
        receiver = User.objects.create(username="testreceiver")
        user_card_details=my_accounts_models.UserCardDetails.objects.create(user=User.objects.get(id=1), balance=1)
        sender_data = my_accounts_models.UserData.objects.create(
            user=User.objects.get(id=1), 
            first_name="hello", 
            last_name="hello", 
            user_card_details=my_accounts_models.UserCardDetails.objects.get(user=User.objects.get(id=1))
        )
        transaction_type = models.TransactionTypes.objects.create(type="shopping")
        transaction_type = models.TransactionTypes.objects.create(type="food")
        types = models.TransactionTypes.objects.all()
        serializer1 = serializers.TransactionTypesSerializer(types, many=True)
        print(serializer1.data)
        
        transaction = models.Transactions.objects.create(
            amount=100,
            transaction_type=models.TransactionTypes.objects.get(id=1),
            sender=User.objects.get(id=1),
            receiver=User.objects.get(id=2),
        )
        transaction2 = models.Transactions.objects.create(
            amount=100,
            transaction_type=models.TransactionTypes.objects.get(id=2),
            sender=User.objects.get(id=1),
            receiver=User.objects.get(id=2),
        )
        transaction3 = models.Transactions.objects.create(
            amount=100,
            transaction_type=models.TransactionTypes.objects.get(id=2),
            sender=User.objects.get(id=1),
            receiver=User.objects.get(id=2),
        )
        
        user_transction = models.UserTransactions.objects.create(
            user=User.objects.get(id=1),
            transaction=models.Transactions.objects.get(id=1),
            direction=models.UserTransactions.Direction.SEND,
            resulting_balance=200.00
        )
        user_transction = models.UserTransactions.objects.create(
            user=User.objects.get(id=1),
            transaction=models.Transactions.objects.get(id=2),
            direction=models.UserTransactions.Direction.SEND,
            resulting_balance=400.00
        )
        user_transction = models.UserTransactions.objects.create(
            user=User.objects.get(id=1),
            transaction=models.Transactions.objects.get(id=3),
            direction=models.UserTransactions.Direction.SEND,
            resulting_balance=400.00
        )

        self.client = APIClient()
        self.user = User.objects.get(id=1)
        refresh = RefreshToken.for_user(self.user)
        self.token = str(refresh.access_token)

        self.client.credentials(HTTP_AUTHORIZATION=f'Bearer {self.token}')

    def test_user_transaction_view(self):
        url = reverse('user-transactions') + '?type=food'
        response = self.client.get(url)

        print(response.status_code)
        print(response.content)