import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_button.dart';
import 'package:strativa_frontend/common/widgets/app_logo_widget.dart';
import 'package:strativa_frontend/common/widgets/text_button.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: AppConstants.kAppPadding,
        child: Column(
          spacing: 20,
          children: [
            SizedBox(
              height: ScreenUtil().screenHeight * 0.15,
            ),
        
            Align(
              alignment: Alignment(-0.8, 0),
              child: AppLogoWidget(
                logoHeight: 230,
                fontSize: 35,
                spacing: -10,
              ),
            ),
        
            AppButton(
              text: AppText.kOpenAccountButtonText,
              onTap: () {
                // TODO: push to registration
              },
            ),
        
            AppButton(
              text: AppText.kLoginButtonText,
              onTap: () {
                context.push(AppRoutes.kLoginScreen);
              },
              color: ColorsCommon.kPrimaryL4,
              fontWeight: FontWeight.w900,
              firstColor: Colors.transparent,
              secondColor: Colors.transparent,
              showBorder: true,
            ),
        
            AppTextButton(
              text: AppText.kSignUpWithExistingAccount,
              onPressed: () {
                // TODO: push to login?
              }
            )
          ]
        ),
      ),
    );
  }
}