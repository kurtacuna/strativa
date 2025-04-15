import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/common/widgets/app_logo_widget.dart';
import 'package:strativa_frontend/src/auth/controllers/jwt_notifier.dart';
import 'package:strativa_frontend/src/auth/models/login_model.dart';
import 'package:strativa_frontend/src/auth/widgets/user_id_field_widget.dart';
import 'package:strativa_frontend/src/auth/widgets/password_field_widget.dart';
import 'package:strativa_frontend/common/widgets/app_text_button_widget.dart';
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
  final _formKey = AppGlobalKeys.loginFormKey;

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
          child:  SingleChildScrollView(
            child: Column(
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
                    
                UserIdFieldWidget(
                    controller: _userIdController,
                    onEditingComplete: () {
                      FocusScope.of(context).requestFocus(_passwordNode);
                    },
                ),
                
                PasswordFieldWidget(
                  controller: _passwordController,
                  focusNode: _passwordNode,
                ),
            
                context.watch<JwtNotifier>().getIsLoading
                  ? AppCircularProgressIndicatorWidget()
                  : AppButtonWidget(
                    text: AppText.kLoginButtonText,
                    onTap: () async {
                      FocusScope.of(context).unfocus();
                      if (_formKey.currentState!.validate()) {
                        LoginModel model = LoginModel(
                          password: _passwordController.text,
                          username: _userIdController.text,
                        );
                        String data = loginModelToJson(model);
            
                        int statusCode = await context.read<JwtNotifier>().login(
                          context: context,
                          data: data,
                        );
            
                        if (context.mounted) {
                          if (statusCode != -1) {
                            context.go(AppRoutes.kEntrypoint);
                          }
                        }
                      }
                    },
                    firstColor: ColorsCommon.kPrimaryL1,
                    secondColor: ColorsCommon.kPrimaryL4,
                    radius: AppConstants.kAppBorderRadius,
                  ),
                    
                AppTextButtonWidget(
                  text: AppText.kForgotMyUserIdOrPassword,
                  style: CustomTextStyles(context).textButtonStyle.copyWith(
                    fontWeight: FontWeight.w900,
                    color: ColorsCommon.kPrimaryL4,
                  ),
                  onPressed: () {
                    // TODO: handle forgot password
                  }
                ),
            
                SizedBox(
                  height: 40,
                ),
            
                PeekBalanceWidget(),
            
                // TODO: add fingerprint login?
              ]
            ),
          ),
        ),
      ),
    );
  }
}