import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/input_formatters.dart';
class AppLabeledAmountFieldWidget extends StatelessWidget {
  const AppLabeledAmountFieldWidget({
    required this.text,
    required this.controller,
    this.onEditingComplete,
    super.key
  });

  final String text;
  final TextEditingController controller;
  final Function()? onEditingComplete;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: CustomTextStyles(context).biggerStyle.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),

        SizedBox(height: 20.h),

        Row(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 60,
              width: 70,
              decoration: BoxDecoration(
                color: Theme.of(context).brightness == Brightness.light
                  ? ColorsCommon.kBlueGray
                  : ColorsCommon.kDarkGray,
                borderRadius: BorderRadius.circular(AppConstants.kSmallRadius)
              ),
              child: Center(
                child: Text(
                  AppText.kCurrencyText,
                  style: CustomTextStyles(context).biggerStyle.copyWith(
                    color: ColorsCommon.kDarkerGray,
                  ),
                ),
              ),
            ),

            Expanded(
              child: TextFormField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9.]')),
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return formatDecimalInput(oldValue, newValue);
                  })
                ],
                controller: controller,
                textInputAction: TextInputAction.next,
                onEditingComplete: onEditingComplete,
                style: CustomTextStyles(context).amountStyle,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.end,
                validator: (value) {
                  if (value!.isEmpty) {
                    return AppText.kLabeledAmountFieldError;
                  } else {
                    return null;
                  }
                },
                decoration: InputDecoration(
                  fillColor: Theme.of(context).brightness == Brightness.light
                    ? ColorsCommon.kBlueGray
                    : ColorsCommon.kDarkGray,
                  filled: true,
                  hintText: AppText.kAmountHintText,
                  hintStyle: CustomTextStyles(context).amountStyle.copyWith(
                    color: ColorsCommon.kDarkerGray,
                  ),

                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppConstants.kSmallRadius),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: AppConstants.kFocusedBorder,
                  errorBorder: AppConstants.kErrorBorder,
                  focusedErrorBorder: AppConstants.kFocusedErrorBorder,
                ),
              ),
            ),
          ]
        ),
      ]
    );
  }
}