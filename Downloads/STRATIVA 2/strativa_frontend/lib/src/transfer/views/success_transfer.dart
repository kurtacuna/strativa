import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/widgets/success_message.dart';
import 'package:strativa_frontend/common/widgets/transfer_details.dart';
import 'package:strativa_frontend/common/widgets/transfer_button.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class SuccessTransferScreen extends StatelessWidget {
  const SuccessTransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCommon.kWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            SuccessMessage(),
            TransferDetails(),
            TransferButtons(),
          ],
        ),
      ),
    );
  }
}