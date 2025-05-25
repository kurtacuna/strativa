from django.db import models, IntegrityError
from django.contrib.auth.models import User
from django.utils import timezone
import random
import os
from utils.const import BackendConstants
from transaction import models as transaction_models
import utils.aes_encryption_decryption as aes
import utils.hash_function as h

# Create your models here.
class UserData(models.Model):
  def save_profile_picture_to(instance, filename):
    return os.path.join('profile_pictures', f"{instance.id}_{instance.user.username}_{filename}")

  user = models.OneToOneField(User, primary_key=True, on_delete=models.CASCADE)
  user_type = models.ForeignKey('UserTypes', on_delete=models.SET_DEFAULT, default=1)
  first_name = models.CharField(max_length=255)
  middle_name = models.CharField(max_length=255, blank=True)
  last_name = models.CharField(max_length=255)
  full_name = models.CharField(max_length=765)
  profile_picture = models.ImageField(upload_to=save_profile_picture_to, default='images/logo.png')
  user_card_details = models.ForeignKey('UserCardDetails', on_delete=models.CASCADE)
  email = models.EmailField(max_length=255)
  # TODO: add refresh token for logging out and tracking sessions, maybe in another app

  def __str__(self):
    return self.user.username
  
  def save(self, *args, **kwargs):
    self.full_name = self.get_full_name

    super().save(*args, **kwargs)
  
  @property
  def get_full_name(self):
    return f"{self.first_name} {f"{self.middle_name} " if self.middle_name else ""}{self.last_name}"

  class Meta:
    verbose_name = "User Data"
    verbose_name_plural = "User Data"

  
class UserTypes(models.Model):
  user_type = models.CharField(max_length=255, unique=True)
  transaction_category = models.ForeignKey(transaction_models.TransactionTypes, on_delete=models.SET_DEFAULT, default=1)

  def __str__(self):
    return self.user_type
  
  class Meta:
    verbose_name = "User Type"
    verbose_name_plural = "User Types"


class UserCardDetails(models.Model):
  user = models.OneToOneField(User, primary_key=True, on_delete=models.CASCADE)

  strativa_card_number = models.TextField()
  strativa_card_created = models.TextField()
  strativa_card_expiry = models.TextField()
  strativa_card_cvv = models.TextField()

  is_online_card_active = models.TextField()
  online_card_number = models.TextField(blank=True, null=True)
  online_card_created = models.TextField(blank=True, null=True)
  online_card_expiry = models.TextField(blank=True, null=True)
  online_card_cvv = models.TextField(blank=True, null=True)

  def __str__(self):
    return self.user.username
  
  def save(self, *args, **kwargs):
    self.create_strativa_card

    super().save(*args, **kwargs)
  
  @property
  def create_strativa_card(self):
    if not self.strativa_card_number:
      while True:
        try:
          self.strativa_card_number = aes.encrypt(self.generate_card_number())
          break
        except IntegrityError:
          continue

      self.strativa_card_created = aes.encrypt(timezone.now())
      self.strativa_card_expiry = aes.encrypt(timezone.now().replace(year=timezone.now().year + BackendConstants.card_expiry_years))
      self.strativa_card_cvv = aes.encrypt(self.generate_cvv())

  @property
  def create_online_card(self):
    if bool(aes.decrypt(self.is_online_card_active)) and not self.online_card_number:
      while True:
        try:
          self.online_card_number = aes.encrypt(self.generate_card_number())
          break
        except IntegrityError:
          continue

      self.online_card_created = aes.encrypt(timezone.now())
      self.online_card_expiry = aes.encrypt(timezone.now().replace(year=timezone.now().year + BackendConstants.card_expiry_years))
      self.online_card_cvv = aes.encrypt(self.generate_cvv())

  @staticmethod
  def generate_card_number():
    while True:
      card_number = ''.join(str(random.randint(0, 9)) for _ in range(16))
      if UserCardDetails.luhn_check(card_number):
        return card_number
      else:
        continue
  
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
  def generate_cvv():
    cvv = ''.join(str(random.randint(0, 9)) for _ in range(3))
    return int(cvv)
  
  class Meta:
    verbose_name = "User Card Detail"
    verbose_name_plural = "User Card Details"


class UserAccounts(models.Model):
  user = models.ForeignKey(User, on_delete=models.CASCADE)
  account_type = models.ForeignKey('AccountTypes', on_delete=models.CASCADE)
  hashed_account_number = models.TextField(blank=True)
  account_number = models.TextField(unique=True, blank=True)
  balance = models.TextField(blank=True)
  bank = models.ForeignKey('StrativaBanks', on_delete=models.CASCADE, default=1)

  def __str__(self):
    return self.user.username
  
  def save(self, *args, **kwargs):
    if not self.account_number:
      account_type_code = AccountTypes.objects.get(account_type=self.account_type).code
      account_number = f"{account_type_code}-{BackendConstants.get_uuid(half=True)}"
      self.hashed_account_number = h.hash_data(account_number)
      self.account_number = aes.encrypt(account_number)
    
    if not self.balance:
      self.balance = aes.encrypt(0)
    
    super().save(*args, **kwargs)

  class Meta:
    verbose_name = "User Account"
    verbose_name_plural = "User Accounts"


class AccountTypes(models.Model):
  account_type = models.CharField(max_length=255, unique=True)
  code = models.CharField(max_length=10, unique=True)

  def __str__(self):
    return self.account_type

  class Meta:
    verbose_name = "Account Type"
    verbose_name_plural = "Account Types"

  
class StrativaBanks(models.Model):
    bank_name = models.CharField(max_length=255, unique=True)

    def __str__(self):
        return self.bank_name
    
    class Meta:
        verbose_name = "Strativa Bank"
        verbose_name_plural = "Strativa Banks"