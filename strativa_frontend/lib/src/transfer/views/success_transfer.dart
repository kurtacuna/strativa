import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/widgets/success_message.dart';
import 'package:strativa_frontend/common/widgets/transfer_details.dart';
import 'package:strativa_frontend/common/widgets/transfer_button.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';

class SuccessTransferScreen extends StatelessWidget {
  const SuccessTransferScreen({
    required this.fromAccountType,
    required this.fromAccountNumber,
    required this.toAccountType,
    required this.toAccountNumber,
    required this.amount,
    this.note,
    super.key
  });

  final String fromAccountType;
  final String fromAccountNumber;
  final String toAccountType;
  final String toAccountNumber;
  final String amount;
  final String? note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCommon.kWhite,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SuccessMessage(),
              TransferDetails(
                fromLabel: AppText.kTransferFrom,
                fromAccountName: fromAccountType,
                fromAccountNumber: fromAccountNumber,
                toLabel: AppText.kTransferTo,
                toAccountName: toAccountType,
                toAccountNumber: toAccountNumber,
                currency: 'PHP',
                amount: amount,
                note: note
              ),
              TransferButtons(),
            ],
          ),
        ),
      ),
    );
  }
}
