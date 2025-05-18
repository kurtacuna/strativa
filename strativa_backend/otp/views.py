from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from utils.server_error import return_server_error
from my_accounts.utils.user_not_found import return_user_not_found
from . import models
import pyotp
from utils.const import BackendConstants
from django.utils import timezone
from my_accounts import models as my_accounts_models
from utils.celery_workers.send_email import send_email
import pyotp
from transfer import views as transfer_views
from scheduled_payments import views as scheduled_payments_views
from rest_framework.permissions import AllowAny


class VerifyOtpView(APIView):
    permission_classes = [AllowAny]
    authentication_classes = []

    def post(self, request):
        # used for all otp verification
        account_number = request.data.get('account_number')
        otp = request.data.get('otp')
        query = request.query_params.get('type')

        # used for requests that require user id
        user_id = request.user.id

        # used for transactions that send transaction_details
        transaction_details = request.data.get('transaction_details')
        
        try:
            user = my_accounts_models.UserAccounts.objects.get(account_number=account_number).user
            user_otp = models.UserOtp.objects.get(user=user)
            totp = pyotp.TOTP(
                user_otp.otp_secret, 
                digits=BackendConstants.otp_length,
                interval=BackendConstants.otp_valid_duration
            )

            if (totp.verify(otp, valid_window=2) and user_otp.valid_date > timezone.now()):
                request.query_params._mutable = True
                if (query == "peekbalance"):
                    request.query_params['account_number'] = account_number
                    peek_balance_view = PeekBalanceView.as_view()
                    return peek_balance_view(request._request)
                
                elif(query == "scheduledpayment"):
                    request.query_params['user_id'] = user_id
                    request.query_params['transaction_details'] = transaction_details
                    scheduled_payments_view = scheduled_payments_views.SchedulePaymentView.as_view()
                    return scheduled_payments_view(request._request)
                    
                elif (query == "common"):
                    request.query_params['transaction_details'] = transaction_details
                    transfer_view = transfer_views.TransferView.as_view()
                    return transfer_view(request._request)
                
            else:
                return Response(
                    {"detail": "OTP invalid."},
                    status=status.HTTP_400_BAD_REQUEST
                )

        except models.UserOtp.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)
        

class CreateOtpView(APIView):
    permission_classes = [AllowAny]
    authentication_classes = []

    def post(self, request):
        account_number = request.data.get('account_number')

        try:
            account_data = my_accounts_models.UserAccounts.objects.select_related('user').get(
                account_number=account_number
            )
            user_data = my_accounts_models.UserData.objects.get(user=account_data.user)

            user_otp, created = models.UserOtp.objects.update_or_create(
                user=user_data.user,   
            )

            otp = pyotp.TOTP(
                user_otp.otp_secret,
                digits=BackendConstants.otp_length,
                interval=BackendConstants.otp_valid_duration
            ).now()

            # .delay means it will be offloaded to celery
            send_email.delay(
                subject=f"Strativa OTP: {otp}",
                message=f"Your OTP is {otp}. This is valid for {BackendConstants.otp_valid_duration} seconds.",
                recipients=[user_data.email]
            )

            return Response(status=status.HTTP_200_OK)
        except my_accounts_models.UserAccounts.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)


class PeekBalanceView(APIView):
    permission_classes = [AllowAny]
    authentication_classes = []

    def post(self, request):
        account_number = request.query_params.get('account_number')

        try:
            user_balance = my_accounts_models.UserAccounts.objects.get(account_number=account_number).balance
            return Response(
                {"detail": f"PHP {user_balance}"},
                status=status.HTTP_200_OK
            )
        except models.UserOtp.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)