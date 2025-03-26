import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kresources.dart';

class AppLogoWidget extends StatelessWidget {
  const AppLogoWidget({
    this.logoHeight,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.spacing,
    super.key,
  });

  final double? logoHeight;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final double? spacing;

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
            right: -50 + (spacing ?? 0),
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