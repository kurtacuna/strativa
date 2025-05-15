import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/amount.dart';
import 'package:strativa_frontend/common/widgets/app_error_snack_bar_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';

int checkTransferDetails({
  required BuildContext context,
  required UserAccount? fromAccount,
  required dynamic toAccount,
  required String amount,
  required GlobalKey<FormState> formKey,
  double totalFee = 0,
  String? note
}) {
  // -1 means fail
  int statusCode = -1;

  // Check if the accounts are selected
  if (fromAccount == null || toAccount == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      appErrorSnackBarWidget(
        context: context, 
        text: AppText.kPleaseSelectAnAccountToTransferFromAndTo
      )
    );

    return statusCode;
  }

  // Check if from and to accounts are the same
  if (fromAccount == toAccount) {
    ScaffoldMessenger.of(context).showSnackBar(
      appErrorSnackBarWidget(
        context: context, 
        text: AppText.kCantTransferToTheSameAccount
      )
    );

    return statusCode;
  }

  // Check if amount is empty
  if (!formKey.currentState!.validate()) {
    return statusCode;
  }

  // Check if there's enough balance
  if (
    double.parse(fromAccount.balance) < 
    double.parse(removeCommaFromAmount(amount)) + totalFee
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      appErrorSnackBarWidget(
        context: context, 
        text: "The account to transfer from doesn't have enough balance"
      )
    );

    return statusCode;
  }

  // 0 means pass
  return 0;
}