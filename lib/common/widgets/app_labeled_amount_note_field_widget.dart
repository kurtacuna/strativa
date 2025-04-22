import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/input_formatters.dart';
class AppLabeledAmountNoteFieldWidget extends StatelessWidget {
  const AppLabeledAmountNoteFieldWidget({
    required this.text,
    required this.amountController,
    this.onEditingComplete,
    this.addNote,
    this.addNoteController,
    super.key
  });

  final String text;
  final TextEditingController amountController;
  final TextEditingController? addNoteController;
  final Function()? onEditingComplete;
  final bool? addNote;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          text,
          style: CustomTextStyles(context).biggerStyle.copyWith(
            fontWeight: FontWeight.w900,
          ),
        ),

        SizedBox(height: 20.h),

        Column(
          children: [
            // Amount Field
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
                      FilteringTextInputFormatter.allow(allowNumbersAndDot()),
                      TextInputFormatter.withFunction((oldValue, newValue) {
                        return formatDecimalInput(oldValue, newValue);
                      })
                    ],
                    controller: amountController,
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

            // Note Field
            (addNote ?? true) == false
              ? Container()
              : Column(
                children: [
                  SizedBox(height: 15.h),

                  TextField(
                    controller: addNoteController,
                    decoration: InputDecoration(
                      hintText: AppText.kAddNoteOptional,
                      hintStyle: CustomTextStyles(context).biggerStyle.copyWith(
                        color: ColorsCommon.kDarkerGray,
                      ),
                      filled: true,
                      fillColor: Theme.of(context).brightness == Brightness.light
                        ? ColorsCommon.kBlueGray
                        : ColorsCommon.kDarkGray,
                  
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(AppConstants.kSmallRadius),
                        borderSide: BorderSide.none
                      ),
                      focusedBorder: AppConstants.kFocusedBorder
                    )
                  ),
                ],
              )
          ],
        ),
      ]
    );
  }
}