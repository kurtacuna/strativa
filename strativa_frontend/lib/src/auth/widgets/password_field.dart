import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/src/auth/controllers/password_notifier.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    this.focusedBorderColor,
    this.width,
    this.radius,
    required this.controller,
    this.onEditingComplete,
    required this.focusNode,
    super.key,
  });


  final Color? focusedBorderColor;
  final double? width;
  final double? radius;
  final Function()? onEditingComplete;
  final TextEditingController controller;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return Consumer<PasswordNotifier>(
      builder: (context, passwordNotifier, child) {
        return TextFormField(
          obscureText: passwordNotifier.getObscurePassword,
          textInputAction: TextInputAction.done,
          onEditingComplete: onEditingComplete,
          focusNode: focusNode,
          controller: controller,
          validator: (value) {
            if (value!.isEmpty) {
              return "Please enter your password.";
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            hintText: AppText.kHintPassword,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: AppIcons.kPasswordFieldIcon()
              ),
            suffixIcon: GestureDetector(
              onTap: () {
                passwordNotifier.toggleObscurePassword();
              },
              child: passwordNotifier.getObscurePassword
              ? AppIcons.kEyeCloseIcon
              : AppIcons.kEyeOpenIcon,
            ),
            prefixIconConstraints: BoxConstraints(
              maxHeight: 40.sp,
              maxWidth: 40.sp,
            ),

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
    );
  }
}