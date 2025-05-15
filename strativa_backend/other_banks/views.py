from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.response import Response
from rest_framework import status
from . import models, serializers
from my_accounts.utils.user_not_found import return_user_not_found
from utils.server_error import return_server_error

# Create your views here.
class OtherBanksView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            other_banks = models.OtherBanks.objects.all()
            serializer = serializers.OtherBanksSerializer(other_banks, many=True)

            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            return return_server_error(e)



class CheckIfOtherBankAccountExistsView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        other_bank_account_details = request.data.get('other_bank_account_details')
        other_bank_account_bank = other_bank_account_details.get('bank')
        other_bank_account_number = other_bank_account_details.get('account_number')
        other_bank_account_full_name = other_bank_account_details.get('full_name')

        try:
            other_bank_account = models.OtherBankAccounts.objects.get(
                bank__bank_name=other_bank_account_bank,
                account_number=other_bank_account_number,
                full_name=other_bank_account_full_name
            )
            return Response(status=status.HTTP_200_OK)
        except models.OtherBankAccounts.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)