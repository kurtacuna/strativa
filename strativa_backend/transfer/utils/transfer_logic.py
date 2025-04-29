from rest_framework.response import Response
from rest_framework import status
from django.db import transaction
from my_accounts import models as my_accounts_models
from other_banks import models as other_banks_models
from decimal import Decimal
from transaction.utils.log_transaction import log_transaction

def transfer_logic(
        transaction_type,
        sender_account_number,
        # sender_bank,
        receiver_account_number,
        receiver_bank,
        amount,
        note
):
    with transaction.atomic():
        sender_account_details = my_accounts_models.UserAccounts.objects.select_related('user').get(
            account_number=sender_account_number
        )
        receiver_account_details = {}

        if receiver_bank == "Strativa":
            receiver_account_details = my_accounts_models.UserAccounts.objects.select_related('user').get(
                account_number=receiver_account_number
            )
        else:
            receiver_account_details = other_banks_models.OtherBankAccounts.objects.get(
                bank__bank_name=receiver_bank,
                account_number=receiver_account_number
            )

        if (Decimal(amount) > sender_account_details.balance):
            return "insufficient balance"

        sender_account_details.balance -= Decimal(amount)
        sender_account_details.save()
        receiver_account_details.balance += Decimal(amount)
        receiver_account_details.save()

        log_transaction(
            amount=amount,
            transaction_type=transaction_type,
            sender=sender_account_details.user,
            sender_account_number=sender_account_details.account_number,
            sender_bank=sender_account_details.bank.bank_name,
            receiver=receiver_account_details.user,
            receiver_account_number=receiver_account_details.account_number,
            receiver_bank=receiver_account_details.bank.bank_name,
            note=note
        )

        return 0