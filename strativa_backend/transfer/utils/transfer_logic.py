from django.db import transaction
from my_accounts import models as my_accounts_models
from other_banks import models as other_banks_models
from transaction.utils.log_transaction import log_transaction
from transaction import models as transaction_models
import utils.hash_function as h
import utils.aes_encryption_decryption as aes
from decimal import Decimal

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
        other_bank_transaction_fees = other_banks_models.OtherBankAccounts.objects.none()

        # For logging the transaction
        original_amount = amount

        sender_account_details = my_accounts_models.UserAccounts.objects.select_related('user').get(
            hashed_account_number=h.hash_data(sender_account_number)
        )
        receiver_account_details = None

        if receiver_bank == "Strativa":
            receiver_account_details = my_accounts_models.UserAccounts.objects.select_related('user').get(
                hashed_account_number=h.hash_data(receiver_account_number)
            )
        else:
            receiver_account_details = other_banks_models.OtherBankAccounts.objects.get(
                bank__bank_name=receiver_bank,
                account_number=receiver_account_number
            )
            # Get all transaction fees to other banks
            other_bank_transaction_fees = transaction_models.TransactionFees.objects.filter(
                type__contains="OtherBank"
            )

        if (amount > Decimal(aes.decrypt(sender_account_details.balance))):
            return "insufficient balance"
        
        # Add other bank transfer fees to total amount
        if other_bank_transaction_fees.exists():
            for transaction_fee in other_bank_transaction_fees:
                amount += transaction_fee.fee

        sender_account_details.balance = aes.encrypt(Decimal(aes.decrypt(sender_account_details.balance)) - amount)
        sender_account_details.save()
        receiver_account_details.balance = aes.encrypt(Decimal(aes.decrypt(receiver_account_details.balance)) + amount)
        receiver_account_details.save()

        log_transaction(
            amount=aes.encrypt(original_amount),
            transaction_type=transaction_type,
            sender=sender_account_details.user,
            sender_account_number=sender_account_details.account_number,
            sender_bank=sender_account_details.bank.bank_name,
            receiver=receiver_account_details.user,
            receiver_account_number=receiver_account_details.account_number,
            receiver_bank=receiver_account_details.bank.bank_name,
            note=aes.encrypt(note),
            other_bank_transaction_fees=other_bank_transaction_fees
        )

        return 0