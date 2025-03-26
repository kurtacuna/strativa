import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    this.onTap,
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

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        width: width ?? ScreenUtil().screenWidth / 1.1,
        height: height ?? 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 10),
          gradient: LinearGradient(
            colors: [
              firstColor ?? ColorsCommon.kPrimaryL1,
              secondColor ?? ColorsCommon.kPrimaryL4,
            ],
          ),
          border: Border.all(
            width: 2.h,
            // color: KcolorsCommon.kPrimaryL4,
            color: showBorder ?? false
            ? ColorsCommon.kPrimaryL4
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
    );
  }
}