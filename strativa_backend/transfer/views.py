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
from other_banks import models as other_banks_models
from transfer.utils.transfer_logic import transfer_logic
from utils.const import BackendConstants
from . import models


class TransferView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        # For testing only
        # transaction_details = request.data.get('transaction_details')

        # Uncomment when integrating with frontend
        transaction_details = request.query_params.get('transaction_details')
        transaction_details = json.loads(transaction_details)
        transaction_details = transaction_details.get('transaction_details')
        
        transaction_type = transaction_details.get('transaction_type', None)
        sender_data = transaction_details.get('sender', {})
        sender_account_number = sender_data.get('account_number', None)
        # for now, sender_bank is always from Strativa
        # uncomment if a transfer came from other bank
        # sender_bank = sender_data.get('bank', None)
        receiver_data = transaction_details.get('receiver', {})
        receiver_account_number = receiver_data.get('account_number', None)
        receiver_bank = receiver_data.get('bank', None)
        amount = Decimal(transaction_details.get('amount'))
        note = transaction_details.get('note')

        try:
            if sender_account_number == receiver_account_number:
                return Response(
                    {"detail": "Can't transfer to the same account."},
                    status=status.HTTP_400_BAD_REQUEST
                )

            result = transfer_logic(
                transaction_type=transaction_type,
                sender_account_number=sender_account_number,
                # sender_bank=sender_bank,
                receiver_account_number=receiver_account_number,
                receiver_bank=receiver_bank,
                amount=amount,
                note=note
            )

            if result == "insufficient balance":
                return Response(
                    {"detail": "Not enough balance."},
                    status=status.HTTP_400_BAD_REQUEST    
                )

            return Response(status=status.HTTP_200_OK)
        except my_accounts_models.UserAccounts.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)