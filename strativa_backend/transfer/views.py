from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from my_accounts import models as my_accounts_models
from utils.server_error import return_server_error
from my_accounts.utils.user_not_found import return_user_not_found
from decimal import Decimal
from django.db import transaction
from transaction.utils.log_transaction import log_transaction
import json

class TransferView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        transaction_details = request.query_params.get('transaction_details')
        transaction_details = json.loads(transaction_details)
        transaction_details = transaction_details.get('transaction_details')
        
        transaction_type = transaction_details.get('transaction_type', None)
        sender_data = transaction_details.get('sender', {})
        sender_account_number = sender_data.get('account_number', None)
        receiver_data = transaction_details.get('receiver', {})
        receiver_account_number = receiver_data.get('account_number', None)
        amount = transaction_details.get('amount')
        note = transaction_details.get('note')

        try:
            with transaction.atomic():
                sender_account_details = my_accounts_models.UserAccounts.objects.select_related('user').get(
                    account_number=sender_account_number
                )
                receiver_account_details = my_accounts_models.UserAccounts.objects.select_related('user').get(
                    account_number=receiver_account_number
                )

                # print(f"senderbefore: {sender_account_details.balance}")
                # print(f"receiverbefore: {receiver_account_details.balance}")

                if (Decimal(amount) < sender_account_details.balance):
                    sender_account_details.balance -= Decimal(amount)
                else:
                    return Response(
                        {"detail": "Not enough balance."},
                        status=status.HTTP_400_BAD_REQUEST    
                    )

                receiver_account_details.balance += Decimal(amount)

                # print(f"senderafter: {sender_account_details.balance}")
                # print(f"receiverafter: {receiver_account_details.balance}")
                
                # Log transaction first before saving balance of both users to not double the amount
                log_transaction(
                    amount=amount,
                    transaction_type=transaction_type,
                    sender=sender_account_details.user,
                    sender_account_number=sender_account_number,
                    receiver=receiver_account_details.user,
                    receiver_account_number=receiver_account_number,
                    note=note
                )

                sender_account_details.save()
                receiver_account_details.save()

                return Response(status=status.HTTP_200_OK)
        except my_accounts_models.UserAccounts.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)   
