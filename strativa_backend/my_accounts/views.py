from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from . import models, serializers
from utils.server_error import return_server_error
from my_accounts.utils.user_not_found import return_user_not_found

class UserDataView(APIView):
  permission_classes = [IsAuthenticated]

  def get(self, request):
    user_id = request.user.id
    
    try:
      user_data = models.UserData.objects.select_related('user_card_details').get(user=user_id)
      serializer = serializers.UserDataSerializer(user_data)

      return Response(serializer.data, status=status.HTTP_200_OK)
    except models.UserData.DoesNotExist:
      return return_user_not_found()
    except Exception as e:
      return return_server_error(e)
    

class UserAccountsView(APIView):
  permission_classes = [IsAuthenticated] 

  def get(self, request):
    user_id = request.user.id

    try:
      user_accounts = models.UserAccounts.objects.filter(user=user_id)

      if not user_accounts.exists():
        return Response({"user_accounts": []}, status=status.HTTP_200_OK)
      
      serializer = serializers.UserAccountsSerializer(user_accounts, many=True)
      return Response({"user_accounts": serializer.data}, status=status.HTTP_200_OK)
    except Exception as e:
      return return_server_error(e)
    
    
class CheckIfAccountExistsView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request):
        account_number = request.data.get('account_number')

        try:
            account = models.UserAccounts.objects.get(account_number=account_number)
            serializer = serializers.UserAccountsSerializer(account)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except models.UserAccounts.DoesNotExist:
            return return_user_not_found()
        except Exception as e:
            return return_server_error(e)