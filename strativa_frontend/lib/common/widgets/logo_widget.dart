import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/resources.dart';

class LogoWidget extends StatelessWidget {
  const LogoWidget({
    this.logoHeight,
    this.fontSize,
    this.fontWeight,
    this.color,
    super.key,
  });

  final double? logoHeight;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Image.asset(
            R.ASSETS_IMAGES_LOGO_PNG,
            height: logoHeight ?? 200,
            width: logoHeight ?? 200,
          ),
          Positioned(
            top: ((logoHeight ?? 200) / 2) - ((fontSize ?? 30) / 2),
            right: -50,
            child: Text(
              AppText.kAppName,
              style: CustomTextStyles(context).appLogo.copyWith(
                fontSize: fontSize,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}