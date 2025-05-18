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
    note,
    other_bank_transaction_fees,
):
    transaction = transaction_models.Transactions.objects.create(
        amount=amount,
        transaction_type=transaction_models.TransactionTypes.objects.get(type=transaction_type),
        sender=sender,
        sender_account_number=sender_account_number,
        sender_bank=sender_bank,
        receiver=receiver,
        receiver_account_number=receiver_account_number,
        receiver_bank=receiver_bank,
        note=note,
        transaction_fees_applied=(
            True if other_bank_transaction_fees.exists() else False
        )
    )

    if other_bank_transaction_fees.exists():
        for transaction_fee in other_bank_transaction_fees:
            transaction_models.TransactionFeesInTransaction.objects.create(
                transaction_id=transaction,
                transaction_reference_id=transaction.reference_id,
                type=transaction_fee.type,
                fee=transaction_fee.fee
            )
