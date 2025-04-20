import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({
    this.width,
    this.height,
    this.firstColor,
    this.secondColor,
    this.shadow,
    super.key
  });

  final double? width;
  final double? height;
  final Color? firstColor;
  final Color? secondColor;
  final bool? shadow;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppConstants.kAppPadding * 1.5,
      height: height ?? 180.h,
      width: width?.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.kCardRadius),
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            firstColor ?? ColorsCommon.kPrimaryL1,
            secondColor ?? ColorsCommon.kPrimaryL4
          ],
        ),
        boxShadow: shadow ?? false
        ? <BoxShadow>[
            BoxShadow(
              color: ColorsCommon.kPrimaryL4.withValues(alpha: 0.3),
              blurRadius: 20,
              offset: Offset(0, 10),
            ),
          ]
        : null,
      ),
      child: Align(
        alignment: Alignment.topRight,
        child: AppIcons.kMastercardIcon,
      ),
    );
  }
}