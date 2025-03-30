import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_button.dart';
import 'package:strativa_frontend/common/widgets/app_logo_widget.dart';
import 'package:strativa_frontend/src/auth/widgets/user_id_field.dart';
import 'package:strativa_frontend/src/auth/widgets/password_field.dart';
import 'package:strativa_frontend/common/widgets/text_button.dart';
import 'package:strativa_frontend/src/auth/widgets/peek_balance_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController _userIdController = TextEditingController();
  late final TextEditingController _passwordController = TextEditingController();
  final FocusNode _passwordNode = FocusNode();
  final _formKey = GlobalKeys.loginFormKey;

  @override
  void dispose() {
    _userIdController.dispose();
    _passwordController.dispose();
    _passwordNode.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: AppConstants.kAppPadding,
        child: Form(
          key: _formKey,
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
        
              UserIdField(
                hintText: AppText.kHintUserId,
                prefixIcon: AppIcons.kUserIdFieldIcon,
                controller: _userIdController,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordNode);
                },
              ),
              
              PasswordField(
                controller: _passwordController,
                focusNode: _passwordNode,
              ),

              AppButton(
                text: AppText.kLoginButtonText,
                onTap: () {
                  // if (_formKey.currentState!.validate()) {
                  //   print(_userIdController.text);
                  //   print(_passwordController.text);
                  //   // TODO: handle login
                  //   context.go(AppRoutes.kEntrypoint);
                  // }
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