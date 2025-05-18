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
        

class TransactionFeesView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        try:
            transaction_fees = models.TransactionFees.objects.all()
            serializer = serializers.TransactionFeesSerializer(transaction_fees, many=True)
            return Response({"fees": serializer.data}, status=status.HTTP_200_OK)
        except Exception as e:
            return return_server_error(e)
        

class TransactionFeesInTransactionView(APIView):
    premission_classes = [IsAuthenticated]

    def post(self, request):
        user_id = request.user.id
        transaction_reference_id = request.query_params.get("reference_id")

        try:
            sender = models.UserTransactions.objects.get(
                user=user_id,
                transaction__reference_id=transaction_reference_id,
                direction=models.UserTransactions.Direction.SEND
            )

            transaction_fees_in_transaction = models.TransactionFeesInTransaction.objects.filter(
                transaction_reference_id=transaction_reference_id
            )
            serializer = serializers.TransactionFeesInTransactionSerializer(transaction_fees_in_transaction, many=True)
            
            return Response({"fees": serializer.data}, status=status.HTTP_200_OK)
        except sender.DoesNotExist:
            return Response(status=status.HTTP_403_FORBIDDEN)
        except Exception as e:
            return return_server_error(e)