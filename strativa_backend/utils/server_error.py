from rest_framework.response import Response
from rest_framework import status

def return_server_error(error: Exception):
    print(f"Error: {error}")
    return Response(
        {"detail": "An error occurred while processing your request."},
        status=status.HTTP_500_INTERNAL_SERVER_ERROR
    )