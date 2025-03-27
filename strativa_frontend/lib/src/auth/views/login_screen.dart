import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_button.dart';
import 'package:strativa_frontend/common/widgets/app_logo_widget.dart';
import 'package:strativa_frontend/common/widgets/custom_text_form_field.dart';
import 'package:strativa_frontend/common/widgets/text_button.dart';
import 'package:strativa_frontend/src/auth/widgets/peek_balance_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppConstants.kAppPadding,
        child: Form(
          child:  Column(
            spacing: 20,
            children: [
              Align(
                alignment: Alignment(-0.9, 0),
                child: AppLogoWidget(
                  logoHeight: 230,
                  fontSize: 35,
                  spacing: -10,
                ),
              ),
        
              CustomTextFormField(
                hintText: AppText.kHintUserId,
                prefixIcon: AppIcons.kUserIdFieldIcon,
              ),
              
              CustomTextFormField(
                hintText: AppText.kHintPassword,
                prefixIcon: AppIcons.kPasswordFieldIcon,
                suffixIcon: AppIcons.kPasswordFieldEyeOpenIcon,
                obscureText: true,
              ),

              AppButton(
                text: AppText.kLoginButtonText,
                onTap: () {
                  // TODO: handle login
                  context.go(AppRoutes.kEntrypoint);
                },
              ),
        
              AppTextButton(
                text: AppText.kForgotMyUserIdOrPassword,
                onPressed: () {
                  // TODO: handle forgot password
                }
              ),

              SizedBox(
                height: 40,
              ),

              PeekBalanceWidget(),
            ]
          ),
        ),
      ),
    );
  }
}