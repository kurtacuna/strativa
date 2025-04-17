import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/amount.dart';

class AppAmountWidget extends StatelessWidget {
  const AppAmountWidget({
    required this.amount,
    this.amountStyle,
    this.currencyStyle,
    super.key
  });

  final String amount;
  final TextStyle? amountStyle;
  final TextStyle? currencyStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 5,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          AppText.kCurrencyText,
          style: currencyStyle ?? CustomTextStyles(context).defaultStyle
        ),

        Text(
          addCommaToAmount(double.parse(amount)),
          style: amountStyle ?? CustomTextStyles(context).amountStyle
        )
      ],
    );
  }
}