from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
import random

card_expiry_years = 3

# Create your models here.
class UserData(models.Model):
  user = models.ForeignKey(User, on_delete=models.CASCADE)
  first_name = models.CharField(max_length=255, blank=False)
  middle_name = models.CharField(max_length=255, blank=True)
  last_name = models.CharField(max_length=255, blank=False)
  user_card_details = models.ForeignKey('UserCardDetails', blank=False, null=False, on_delete=models.CASCADE)

  def __str__(self):
    return self.user.username

  class Meta:
    verbose_name = "User Data"
    verbose_name_plural = "User Data"


class UserCardDetails(models.Model):
  user = models.ForeignKey(User, on_delete=models.CASCADE)
  balance = models.DecimalField(max_digits=10, decimal_places=2, default=0)

  strativa_card_number = models.CharField(max_length=19, blank=False)
  strativa_card_created = models.DateTimeField(blank=False)
  strativa_card_expiry = models.DateTimeField(blank=False)
  strativa_card_cvv = models.IntegerField(blank=False)

  is_online_card_active = models.BooleanField(default=False)
  online_card_number = models.CharField(max_length=19, blank=True, null=True)
  online_card_created = models.DateTimeField(blank=True, null=True)
  online_card_expiry = models.DateTimeField(blank=True, null=True)
  online_card_cvv = models.IntegerField(blank=True, null=True)

  def __str__(self):
    return self.user.username
  
  def create_strativa_card(self):
    if not self.strativa_card_number:
      self.strativa_card_number = self.generate_strativa_card_number()
      self.strativa_card_created = timezone.now()
      self.strativa_card_expiry = timezone.now().replace(year=timezone.now().year + card_expiry_years)
      self.strativa_card_cvv = self.generate_cvv()

  def create_online_card(self):
    if self.is_online_card_active and not self.online_card_number:
      self.online_card_number = self.generate_online_card_number()
      self.online_card_created = timezone.now()
      self.online_card_expiry = timezone.now().replace(year=timezone.now().year + card_expiry_years)
      self.online_card_cvv = self.generate_cvv()

  @staticmethod
  def generate_card_number():
    card_number = ''.join(str(random.randint(0, 9)) for _ in range(16))
    return f'{card_number[:4]} {card_number[4:8]} {card_number[8:12]} {card_number[12:16]}'
  
  @staticmethod
  def luhn_check(card_number):
    card_number = card_number.replace(" ", "")
    digits = [int(d) for d in card_number]
    checksum = 0
    reversed_card_number = digits[::-1]

    for index, number in enumerate(reversed_card_number):
      if index % 2 == 1:
        number *= 2
        if number > 9:
          number -= 9
      checksum += number
    
    return checksum % 10 == 0
    
  @staticmethod
  def generate_strativa_card_number():
    while True:
      number = UserCardDetails.generate_card_number()
      if UserCardDetails.luhn_check(number) and not UserCardDetails.objects.filter(strativa_card_number=number).exists():
        return number
      
  @staticmethod
  def generate_online_card_number():
    while True:
      number = UserCardDetails.generate_card_number()
      if UserCardDetails.luhn_check(number) and not UserCardDetails.objects.filter(online_card_number=number).exists():
        return number
      
  @staticmethod
  def generate_cvv():
    cvv = ''.join(str(random.randint(0, 9)) for _ in range(3))
    return int(cvv)
  
  class Meta:
    verbose_name = "User Card Detail"
    verbose_name_plural = "User Card Details"