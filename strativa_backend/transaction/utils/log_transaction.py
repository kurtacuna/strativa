from transaction.models import Transactions
from transaction import models as transaction_models

def log_transaction(
    amount,
    transaction_type,
    sender,
    sender_account_number,
    receiver,
    receiver_account_number,
    note
):
    transaction_models.Transactions.objects.create(
        amount=amount,
        transaction_type=transaction_models.TransactionTypes.objects.get(type=transaction_type),
        sender=sender,
        sender_account_number=sender_account_number,
        receiver=receiver,
        receiver_account_number=receiver_account_number,
        note=note
    )
