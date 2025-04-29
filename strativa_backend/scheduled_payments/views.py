from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from . import models
from utils.server_error import return_server_error
from my_accounts.utils.user_not_found import return_user_not_found
from django.contrib.auth.models import User
from my_accounts import models as my_accounts_models
from other_banks import models as other_banks_models
from transaction import models as transaction_models
import json
from datetime import timedelta, datetime


class SchedulePaymentView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        # For testing only
        transaction_details = request.data.get('transaction_details')
        user_id = request.data.get('user_id')

        # Uncomment when integrating with frontend
        # user_id = request.query_params.get('user_id')
        # transaction_details = request.query_params.get('transaction_details')
        # transaction_details = json.loads(transaction_details)
        # transaction_details = transaction_details.get('transaction_details')
        
        transaction_type = transaction_details.get('transaction_type', None)
        sender_data = transaction_details.get('sender', {})
        sender_account_number = sender_data.get('account_number', None)

        # for now, sender_bank is always from Strativa
        # uncomment if a transfer came from other bank
        # sender_bank = sender_data.get('bank', None)

        receiver_data = transaction_details.get('receiver', {})
        receiver_account_number = receiver_data.get('account_number', None)
        receiver_bank = receiver_data.get('bank', None)
        amount = transaction_details.get('amount', None)
        note = transaction_details.get('note', None)
        frequency = int(transaction_details.get('frequency', None))
        start_date = datetime.fromisoformat(transaction_details.get('start_date', None))
        duration = int(transaction_details.get('duration', None))
    
        
        try:
            user = User.objects.get(id=user_id)
            sender_account_details = my_accounts_models.UserAccounts.objects.get(
                account_number=sender_account_number
            )
            
            receiver_account_details = {}
            if receiver_bank == "Strativa":
                receiver_account_details = my_accounts_models.UserAccounts.objects.get(
                    account_number=receiver_account_number
                )
            else:
                receiver_account_details = other_banks_models.OtherBankAccounts.objects.get(
                    account_number=receiver_account_number
                )

            new_scheduled_payment = models.ScheduledPayments.objects.create(
                user=user,
                transaction_type=transaction_models.TransactionTypes.objects.get(
                    type=transaction_type
                ),
                sender_account_number=sender_account_details.account_number,
                sender_bank=sender_account_details.bank.bank_name,
                receiver_account_number=receiver_account_details.account_number,
                receiver_bank=receiver_account_details.bank.bank_name,
                amount=amount,
                note=note,
                frequency=frequency,
                start_date=start_date,
                duration=duration,
                # next_payment_date is the start_date upon creation of scheduled payment
                next_payment_date=start_date,
                # progress is 0 upon creation of scheduled payment
                progress=0,
                end_date=(
                    start_date + timedelta(days=duration * frequency)
                ),
                status=models.ScheduledPayments.Status.ACTIVE   
            )

            
            return Response(status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)
