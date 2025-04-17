import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';

class AppButtonWidget extends StatelessWidget {
  const AppButtonWidget({
    required this.onTap,
    this.width,
    this.height,
    required this.text,
    this.radius,
    this.firstColor,
    this.secondColor,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.showBorder,
    this.borderColor,
    super.key,
  });

  final void Function()? onTap;
  final double? width;
  final double? height;
  final String text;
  final double? radius;
  final Color? firstColor;
  final Color? secondColor;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final bool? showBorder;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius ?? AppConstants.kSmallRadius),
        child: Ink(
          width: width ?? ScreenUtil().screenWidth,
          height: height ?? 50.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius ?? AppConstants.kSmallRadius),
            gradient: LinearGradient(
              colors: [
                firstColor ?? ColorsCommon.kPrimaryL3,
                secondColor ?? ColorsCommon.kPrimaryL3,
              ],
            ),
            border: Border.all(
              width: AppConstants.kAppBorderWidth,
              color: showBorder ?? false
                ? borderColor ?? ColorsCommon.kPrimaryL3
                : Colors.transparent,
            ),
          ),
          child: Center(
            child: Text(
              text,
              style: CustomTextStyles(context).appButtonTextStyle.copyWith(
                fontSize: fontSize,
                color: color,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ),
    );
  }
}