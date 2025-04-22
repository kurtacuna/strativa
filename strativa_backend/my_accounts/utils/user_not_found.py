from rest_framework import status
from rest_framework.response import Response

def return_user_not_found():
    return Response(
        {"detail": "User not found"},
        status=status.HTTP_404_NOT_FOUND
    )