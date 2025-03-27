import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    this.hintText,
    this.prefixIcon,
    this.focusedBorderColor,
    this.width,
    this.suffixIcon,
    this.radius,
    this.obscureText,
    super.key,
  });

  final String? hintText;
  final Icon? prefixIcon;
  final Color? focusedBorderColor;
  final double? width;
  final Icon? suffixIcon;
  final double? radius;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: (width ?? AppConstants.kAppBorderWidth) - 1,
            color: focusedBorderColor ?? ColorsCommon.kGray,
          ),
          borderRadius: BorderRadius.circular(radius ?? AppConstants.kAppBorderRadius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: width ?? AppConstants.kAppBorderWidth,
            color: focusedBorderColor ?? ColorsCommon.kPrimaryL4,
          ),
          borderRadius: BorderRadius.circular(radius ?? AppConstants.kAppBorderRadius),
        ),
      ),
    );
  }
}