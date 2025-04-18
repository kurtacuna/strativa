from transaction.models import Transactions
from transaction import models as transaction_models

def log_transaction(
    amount,
    transaction_type,
    sender,
    receiver,
    note
):
    transaction_models.Transactions.objects.create(
        amount=amount,
        transaction_type=transaction_models.TransactionTypes.objects.get(type=transaction_type),
        sender=sender,
        receiver=receiver,
        note=note
    )
