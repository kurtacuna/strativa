from django.db import models
from django.contrib.auth.models import User
from django.utils import timezone
import random
import os

card_expiry_years = 3

# Create your models here.
class UserData(models.Model):
  def save_profile_picture_to(instance, filename):
    return os.path.join('profile_pictures', f"{instance.id}_{instance.user.username}_{filename}")

  user = models.OneToOneField(User, primary_key=True, on_delete=models.CASCADE)
  first_name = models.CharField(max_length=255, blank=False)
  middle_name = models.CharField(max_length=255, blank=True)
  last_name = models.CharField(max_length=255, blank=False)
  profile_picture = models.ImageField(upload_to=save_profile_picture_to, default='images/logo.png')
  user_card_details = models.ForeignKey('UserCardDetails', blank=False, null=False, on_delete=models.CASCADE)

  def __str__(self):
    return self.user.username
  
  @property
  def get_full_name(self):
    return f"{self.first_name} {f"{self.middle_name} " if self.middle_name else ""}{self.last_name}"

  class Meta:
    verbose_name = "User Data"
    verbose_name_plural = "User Data"


class UserCardDetails(models.Model):
  user = models.OneToOneField(User, primary_key=True, on_delete=models.CASCADE)
  balance = models.DecimalField(max_digits=10, decimal_places=2, default=0)

  strativa_card_number = models.CharField(max_length=16, unique=True)
  strativa_card_created = models.DateTimeField()
  strativa_card_expiry = models.DateTimeField()
  strativa_card_cvv = models.CharField(max_length=3)

  is_online_card_active = models.BooleanField(default=False)
  online_card_number = models.CharField(max_length=19, unique=True, blank=True, null=True)
  online_card_created = models.DateTimeField(blank=True, null=True)
  online_card_expiry = models.DateTimeField(blank=True, null=True)
  online_card_cvv = models.CharField(max_length=3, blank=True, null=True)

  def __str__(self):
    return self.user.username
  
  def save(self, *args, **kwargs):
    self.create_strativa_card()
    super().save(*args, **kwargs)
  
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
    return card_number
  
  @staticmethod
  def luhn_check(card_number):
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