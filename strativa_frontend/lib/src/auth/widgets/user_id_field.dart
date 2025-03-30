import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';

class UserIdField extends StatelessWidget {
  const UserIdField({
    this.hintText,
    this.prefixIcon,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.width,
    this.radius,
    this.obscureText,
    this.onEditingComplete,
    required this.controller,
    super.key,
  });

  final String? hintText;
  final Widget? prefixIcon;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final double? width;
  final double? radius;
  final bool? obscureText;
  final Function()? onEditingComplete;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      onEditingComplete: onEditingComplete,
      controller: controller,
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your user id.";
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          child: prefixIcon
          ),
        prefixIconConstraints: BoxConstraints(
            maxHeight: 40.sp,
            maxWidth: 40.sp,
          ),


        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: (width ?? AppConstants.kAppBorderWidth) - 1,
            color: enabledBorderColor ?? ColorsCommon.kGray,
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
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: width ?? AppConstants.kAppBorderWidth,
            color: ColorsCommon.kRed,
          ),
          borderRadius: BorderRadius.circular(radius ?? AppConstants.kAppBorderRadius),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: width ?? AppConstants.kAppBorderWidth,
            color: ColorsCommon.kRed,
          ),
          borderRadius: BorderRadius.circular(radius ?? AppConstants.kAppBorderRadius),
        ),
      ),
    );
  }
}