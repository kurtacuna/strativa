from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from . import models, serializers
from utils.server_error import return_server_error
from utils.user_not_found import return_user_not_found

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
    
