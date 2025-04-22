from django.db import models
from django.contrib.auth.models import User
import pyotp
from datetime import timedelta
from django.utils import timezone
from utils.const import BackendConstants


class UserOtp(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    otp_secret = models.CharField(max_length=BackendConstants.otp_length)
    valid_date = models.DateTimeField()

    def save(self, *args, **kwargs):
        otp_secret, valid_date = self.create_otp()
        if not self.otp_secret:
            self.otp_secret = otp_secret
        self.valid_date = valid_date
        super().save(*args, **kwargs)

    @staticmethod
    def create_otp():
        totp = pyotp.TOTP(
            pyotp.random_base32(),
            digits=BackendConstants.otp_length, 
            interval=BackendConstants.otp_valid_duration
        )
        valid_date = timezone.now() + timedelta(seconds=BackendConstants.otp_valid_duration)
        return [totp.secret, valid_date]
    
    class Meta:
        verbose_name = 'User OTP'
        verbose_name_plural = 'User OTPs'