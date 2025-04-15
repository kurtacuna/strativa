import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';

class AccountItemWidget extends StatelessWidget {
  const AccountItemWidget({
    required this.account,
    super.key
  });

  // TODO: change type once model is done
  final dynamic account;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: ColorsCommon.kDarkGray,
          )
        )
      ),
      child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // TODO: change data once backend is done
          children: [
            Text(
              account['type'].toUpperCase(),
              style: CustomTextStyles(context).defaultStyle.copyWith(
                fontWeight: FontWeight.w900
              )
            ),

            SizedBox(height: 5),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [  
                Text(
                  account['account_number'],
                ),

                AppAmountWidget(
                  amount: account['balance'],
                )
              ],
            ),
          ],
        )
      )
    );
  }
}