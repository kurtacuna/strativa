from django.core.management.base import BaseCommand, CommandError
from scheduled_payments import models as scheduled_payments_models
from transfer.utils.transfer_logic import transfer_logic


class Command(BaseCommand):
    help = "Checks if there are scheduled payments for the day and executes them."

    def handle(self, *args, **options):
        try:
            unfinished_scheduled_payments = scheduled_payments_models.ScheduledPayments.objects.filter(
                status=scheduled_payments_models.ScheduledPayments.Status.ACTIVE
            )

            if unfinished_scheduled_payments == []:
                raise scheduled_payments_models.ScheduledPayments.DoesNotExist

            for scheduled_payment in unfinished_scheduled_payments:
                result = transfer_logic(
                    transaction_type=scheduled_payment.transaction_type,
                    sender_account_number=scheduled_payment.sender_account_number,
                    # sender_bank=scheduled_payment.sender_bank,
                    receiver_account_number=scheduled_payment.receiver_account_number,
                    receiver_bank=scheduled_payment.receiver_bank,
                    amount=scheduled_payment.amount,
                    note=scheduled_payment.note
                )
                
                if result == 0:
                    scheduled_payment.save()
                    self.stdout.write(self.style.SUCCESS(
                        f'Payment {scheduled_payment.id} successful.'
                    ))
                else:
                    if result == "insufficient balance":
                        scheduled_payment.status=scheduled_payment.Status.PAUSED
                        # TODO: notify user through app and email
                        scheduled_payment.save()

                    self.stdout.write(self.style.ERROR(
                        f'Payment {scheduled_payment.id} unsuccessful. {result}'
                    ))

            self.stdout.write(self.style.SUCCESS(
                'Payments executed'
            ))
        except scheduled_payments_models.ScheduledPayments.DoesNotExist:
            self.stdout.write(self.style.SUCCESS(
                'No scheduled payments found.'
            ))
        except Exception as e:
            raise CommandError(e)

            