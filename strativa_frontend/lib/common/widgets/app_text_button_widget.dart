import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';

class AppTextButtonWidget extends StatelessWidget {
  const AppTextButtonWidget({
    required this.text,
    required this.onPressed,
    this.style,
    this.overlayColor,
    this.prefixIcon,
    this.spacing,
    this.color,
    super.key,
  });

  final String text;
  final void Function()? onPressed;
  final TextStyle? style;
  final Color? overlayColor;
  final Color? color;
  final Icon? prefixIcon;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        overlayColor: overlayColor ?? ColorsCommon.kPrimaryL4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius)
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: spacing ?? 0,
        children: [
          SizedBox(
            child: prefixIcon,
          ),
          Text(
            text,
            style: style ?? CustomTextStyles(context).textButtonStyle.copyWith(
              color: color,
            ),
          ),
        ]
      ),
    );
  }
}