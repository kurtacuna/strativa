from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth.models import User
from utils.server_error import return_server_error
from utils.user_not_found import return_user_not_found
from . import models
import pyotp
from utils.const import BackendConstants
from django.utils import timezone
from my_accounts import models as my_accounts_models
from utils.send_email import send_email
import pyotp


class CreateOtpView(APIView):
    def post(self, request):
        username = request.data.get('username')

        try:
            user_data = my_accounts_models.UserData.objects.select_related('user').get(user__username=username)
            user_otp, created = models.UserOtp.objects.update_or_create(user=user_data.user)

            otp = pyotp.TOTP(
                    user_otp.otp_secret,
                    digits=BackendConstants.otp_length,
                    interval=BackendConstants.otp_valid_duration
                ).now()

            send_email(
                subject="Strativa OTP",
                message=f"Your OTP is {otp}. This is valid for {BackendConstants.otp_valid_duration} seconds.",
                recipients=[user_data.email]
            )

            return Response(status=status.HTTP_200_OK)
        except my_accounts_models.UserData.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)
        

# TODO: create view for otp when logged in
class CommonOtpView(APIView):
    pass


class VerifyOtpView(APIView):
    def post(self, request):
        username = request.data.get('username')
        otp = request.data.get('otp')
        query = request.query_params.get('type')

        try:
            user_otp = models.UserOtp.objects.get(user__username=username)
            totp = pyotp.TOTP(
                user_otp.otp_secret, 
                digits=BackendConstants.otp_length,
                interval=BackendConstants.otp_valid_duration
            )
            # 
            if (totp.verify(otp) and user_otp.valid_date > timezone.now()):
                if (query == "peekbalance"):
                    user_balance = my_accounts_models.UserCardDetails.objects.get(user__username=username).balance
                    return Response(
                        {"detail": f"PHP {user_balance}"},
                        status=status.HTTP_200_OK
                    )
            else:
                return Response(
                    {"detail": "OTP invalid."},
                    status=status.HTTP_400_BAD_REQUEST
                )

        except models.UserOtp.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)