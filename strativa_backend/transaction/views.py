from rest_framework import status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from . import models, serializers
from utils.server_error import return_server_error

class UserTransactionsView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        user_id = request.user.id
        query = request.query_params.get('type')

        if not query:
            return Response(
                {"detail": "No query found."},
                status=status.HTTP_400_BAD_REQUEST
            )

        try:
            if (query == "all"):
                user_transactions = models.UserTransactions.objects.select_related(
                    'transaction'
                ).filter(user=user_id).order_by('-transaction__datetime')

            else:
                user_transactions = models.UserTransactions.objects.select_related(
                    'transaction'
                ).filter(
                    user=user_id, transaction__transaction_type__type=query
                ).order_by('-transaction__datetime')
                

            if not user_transactions.exists():
                return Response({"transactions": []}, status=status.HTTP_200_OK)

            serializer = serializers.UserTransactionsSerializer(user_transactions, many=True)
            return Response({"transactions": serializer.data}, status=status.HTTP_200_OK)
        except Exception as e:
            return return_server_error(e)