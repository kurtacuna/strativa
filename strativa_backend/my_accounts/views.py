from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from . import models, serializers

class UserDataView(APIView):
  permission_classes = [IsAuthenticated]

  def get(self, request):
    user_id = request.user.id
    
    if not user_id:
      return Response(
        {"message": "A user ID is required."},
        status=status.HTTP_400_BAD_REQUEST
      )
    
    try:
      user_data = models.UserData.objects.get(id=user_id)
      serializer = serializers.UserDataSerializer(instance=user_data)
    except models.UserData.DoesNotExist:
      return Response(
        {"message": "User not found"},
        status=status.HTTP_404_NOT_FOUND
      )
    
    return Response(serializer.data, status=status.HTTP_200_OK)
    
    