import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/src/auth/controllers/password_notifier.dart';

class PasswordFieldWidget extends StatelessWidget {
  const PasswordFieldWidget({
    required this.controller,
    this.onEditingComplete,
    required this.focusNode,
    super.key,
  });

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
              return AppText.kPasswordFieldError;
            } else {
              return null;
            }
          },
          decoration: InputDecoration(
            // TODO: handle error messages
            // errorText: ,
            hintText: AppText.kHintPassword,
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 10,
              ),
              child: Theme.of(context).brightness == Brightness.dark
              ? AppIcons.kPasswordFieldIcon(
                colorFilter: ColorFilter.mode(
                  ColorsCommon.kWhite,
                  BlendMode.srcIn,
                ),
              )
              : AppIcons.kPasswordFieldIcon(),
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

            enabledBorder: AppConstants.kEnabledBorder,
            focusedBorder: AppConstants.kFocusedBorder,
            errorBorder: AppConstants.kErrorBorder,
            focusedErrorBorder: AppConstants.kFocusedErrorBorder,
          ),
        );
      }
    );
  }
}