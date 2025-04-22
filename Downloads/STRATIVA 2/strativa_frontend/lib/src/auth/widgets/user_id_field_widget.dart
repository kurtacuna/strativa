import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';

class UserIdFieldWidget extends StatelessWidget {
  const UserIdFieldWidget({
    this.hintText,
    this.prefixIcon,
    this.obscureText,
    this.onEditingComplete,
    required this.controller,
    super.key,
  });

  final String? hintText;
  final Widget? prefixIcon;
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
          return AppText.kUserIdFieldError;
        } else {
          return null;
        }
      },
      decoration: InputDecoration(
        // TODO: handle error messages
        // errorText: ,
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


        enabledBorder: AppConstants.kEnabledBorder,
        focusedBorder:AppConstants.kFocusedBorder,
        errorBorder: AppConstants.kErrorBorder,
        focusedErrorBorder: AppConstants.kFocusedErrorBorder,
      ),
    );
  }
}