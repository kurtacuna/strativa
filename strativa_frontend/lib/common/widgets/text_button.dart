import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class AppTextButton extends StatelessWidget {
  const AppTextButton({
    required this.text,
    required this.onPressed,
    this.style,
    this.overlayColor,
    super.key,
  });

  final String text;
  final void Function() onPressed;
  final TextStyle? style;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        overlayColor: overlayColor ?? ColorsCommon.kPrimaryL4,
      ),
      child: Text(
        text,
        style: style ?? CustomTextStyles(context).textButtonStyle,
      ),
    );
  }
}