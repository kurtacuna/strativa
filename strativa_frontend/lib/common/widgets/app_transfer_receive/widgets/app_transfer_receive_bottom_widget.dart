import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';

class AppTransferReceiveBottomWidget extends StatelessWidget {
  const AppTransferReceiveBottomWidget({
    required this.account,
    super.key
  });

  final UserAccount account;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            account.accountType.accountType.toUpperCase(),
            style: CustomTextStyles(context).bigStyle.copyWith(
              fontWeight: FontWeight.w900,
            ),
          ),

          SizedBox(height: 5),

          Text(
            account.accountNumber,
          ),

          AppAmountWidget(
            amount: account.balance,
          ),
        ],
      )
    );
  }
}