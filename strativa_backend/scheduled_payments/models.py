from django.db import models
from django.contrib.auth.models import User
from datetime import timedelta
from transaction import models as transaction_models
from django.utils import timezone

# Create your models here.
class ScheduledPayments(models.Model):
    class Status(models.TextChoices):
        ACTIVE = 'active'
        PAUSED = 'paused'
        CANCELLED = 'cancelled'
        COMPLETED = 'completed'

    # sender_account_number belongs to user (user is the one who created the scheduled payment)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    transaction_type = models.ForeignKey(transaction_models.TransactionTypes, on_delete=models.SET_DEFAULT, default=1)
    sender_account_number = models.CharField(max_length=30)
    sender_bank = models.CharField(max_length=255)
    receiver_account_number = models.CharField(max_length=30)
    receiver_bank = models.CharField(max_length=255)
    amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    note = models.CharField(max_length=255, blank=True)

    frequency = models.PositiveSmallIntegerField()
    start_date = models.DateTimeField()
    duration = models.PositiveSmallIntegerField()
    
    next_payment_date = models.DateTimeField()
    progress = models.PositiveSmallIntegerField(default=0)
    end_date = models.DateTimeField()
    status = models.CharField(max_length=15, choices=Status.choices)

    def __str__(self):
        return self.user.username

    def save(self, *args, **kwargs):
        self.update_payment()

        super().save(*args, **kwargs)

    def update_payment(self):
        if self.status != self.Status.ACTIVE:
            return
        
        if (
            self.status == self.Status.ACTIVE 
            and self.next_payment_date <= timezone.now()
            and self.end_date >= timezone.now()
            and self.progress < self.duration
        ):
            self.next_payment_date += timedelta(days=self.frequency)
            self.progress += 1
            if self.progress == self.duration:
                self.status = self.Status.COMPLETED

    class Meta:
        verbose_name = "Scheduled Payment"
        verbose_name_plural = "Scheduled Payments"