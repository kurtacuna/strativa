import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class AppConstants {
  static double get kAppBorderRadius => 10;
  static double get kSnackBarRadius => 20;
  static double get kCardRadius => 20;
  static double get kSmallRadius => 5;
  static double get kAppBorderWidth => 2;
  static EdgeInsets get kAppPadding => EdgeInsets.all(20);
  static EdgeInsets get kSmallPadding => EdgeInsets.all(5);
  static Offset get kCommonShadowOffset => Offset(0, 5);
  static EdgeInsets get kCardPadding => kAppPadding * 1.5;
  static Duration get kPageChangeDuration => Duration(milliseconds: 300);
  static Curve get kPageChangeCurve => Curves.decelerate;
  static List<BoxShadow> get kCommonBoxShadowLight => [
    BoxShadow(
      color: ColorsCommon.kGray,
      blurRadius: 5,
      offset: kCommonShadowOffset,
    )
  ];
  static List<BoxShadow> get kCommonBoxShadowDark => [
    BoxShadow(
      color: ColorsCommon.kDarkGray,
      blurRadius: 5,
      offset: kCommonShadowOffset,
    )
  ];
  static Duration get kSnackBarDuration => Duration(seconds: 2);
  static OutlineInputBorder get kEnabledBorder => OutlineInputBorder(
    borderSide: BorderSide(
      width: (AppConstants.kAppBorderWidth) - 1,
      color: ColorsCommon.kGray,
    ),
    borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
  );
  static OutlineInputBorder get kFocusedBorder => OutlineInputBorder(
    borderSide: BorderSide(
      width: AppConstants.kAppBorderWidth,
      color: ColorsCommon.kPrimaryL4,
    ),
    borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
  );
  static OutlineInputBorder get kErrorBorder =>  OutlineInputBorder(
    borderSide: BorderSide(
      width: AppConstants.kAppBorderWidth,
      color: ColorsCommon.kRed,
    ),
    borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
  );
  static OutlineInputBorder get kFocusedErrorBorder => OutlineInputBorder(
    borderSide: BorderSide(
      width: AppConstants.kAppBorderWidth,
      color: ColorsCommon.kRed,
    ),
    borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
  );
}