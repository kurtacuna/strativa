from transaction import models as transaction_models

def log_transaction(
    amount,
    transaction_type,
    sender,
    sender_account_number,
    sender_bank,
    receiver,
    receiver_account_number,
    receiver_bank,
    note
):
    transaction_models.Transactions.objects.create(
        amount=amount,
        transaction_type=transaction_models.TransactionTypes.objects.get(type=transaction_type),
        sender=sender,
        sender_account_number=sender_account_number,
        sender_bank=sender_bank,
        receiver=receiver,
        receiver_account_number=receiver_account_number,
        receiver_bank=receiver_bank,
        note=note
    )
