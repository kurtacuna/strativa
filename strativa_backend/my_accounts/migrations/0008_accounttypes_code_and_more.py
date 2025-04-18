# Generated by Django 5.1.7 on 2025-04-18 15:51

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("my_accounts", "0007_usercarddetails_account_number"),
    ]

    operations = [
        migrations.AddField(
            model_name="accounttypes",
            name="code",
            field=models.CharField(default="SA", max_length=10, unique=True),
        ),
        migrations.AlterField(
            model_name="usercarddetails",
            name="account_number",
            field=models.CharField(max_length=50, unique=True),
        ),
    ]
