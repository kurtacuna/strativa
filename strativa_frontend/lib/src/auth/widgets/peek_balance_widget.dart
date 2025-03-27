import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/text_button.dart';

class PeekBalanceWidget extends StatelessWidget {
  const PeekBalanceWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AppTextButton(
          onPressed: () {
            //TODO: handle peek
          },
          prefixIcon: Icon(
            AppIcons.kPasswordFieldEyeOpenIcon.icon,
            size: 35,
            color: ColorsCommon.kPrimaryL4,
          ),
          spacing: 10,
          text: AppText.kTouchToPeekBalance.toUpperCase(),
          style: CustomTextStyles(context).textButtonStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ]
    );
  }
}