from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from . import models, serializers
from utils import server_error

class UserDataView(APIView):
  permission_classes = [IsAuthenticated]

  def get(self, request):
    user_id = request.user.id
    
    try:
      user_data = models.UserData.objects.select_related('user_card_details').get(user=user_id)
      serializer = serializers.UserDataSerializer(user_data)
    except models.UserData.DoesNotExist:
      return Response(
        {"detail": "User not found"},
        status=status.HTTP_404_NOT_FOUND
      )
    except Exception:
      return server_error(Exception)
    
    return Response(serializer.data, status=status.HTTP_200_OK)