import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';

SnackBar appSnackBarWidget({
  required BuildContext context,
  required String text,
  Duration? duration,
  TextStyle? style,
  Widget? icon,
}) {
  return SnackBar(
    duration: duration ?? AppConstants.kSnackBarDuration,
    backgroundColor: Colors.transparent,
    padding: EdgeInsets.zero,
    elevation: 0,
    content: GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).removeCurrentSnackBar();
      },
      child: Stack(
        children: [
          Container(
            width: ScreenUtil().screenWidth,
            height: ScreenUtil().screenHeight,
            color: Colors.transparent,
          ),

          Positioned(
            bottom: 40,
            right: AppConstants.kAppPadding.left,
            left: AppConstants.kAppPadding.left,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppConstants.kSnackBarRadius),
                boxShadow: [
                  BoxShadow(
                    color: ColorsCommon.kDarkerGray,
                    blurRadius: 10,
                    offset: AppConstants.kCommonShadowOffset,
                  ),
                ]
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.kSnackBarRadius),
                child: Container(
                  padding: AppConstants.kAppPadding,
                  color:Theme.of(context).brightness == Brightness.light
                    ? ColorsCommon.kWhite
                    : ColorsCommon.kDark,
                  child: Column(
                    spacing: 5,
                    children: [
                      icon ?? AppIcons.kCheckIcon,
                  
                      Text(
                        text,
                        style: style ?? CustomTextStyles(context).bigStyle.copyWith(
                          fontWeight: FontWeight.w900,
                        ),
                        textAlign: TextAlign.center,
                      ),
                  
                      Text(
                        AppText.kTapAnywhereToContinue,
                        style: CustomTextStyles(context).smallStyle,
                      ),
                    ]
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}