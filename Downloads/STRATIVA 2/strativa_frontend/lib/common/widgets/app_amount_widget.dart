import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/amount.dart';

class AppAmountWidget extends StatelessWidget {
  const AppAmountWidget({
    required this.amount,
    super.key
  });

  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppText.kCurrencyText,
          style: CustomTextStyles(context).smallStyle
        ),

        Text(
          addCommaToAmount(double.parse(amount)),
          style: CustomTextStyles(context).amountStyle.copyWith(
            fontSize: 16.sp,
          ),
        )
      ],
    );
  }
}