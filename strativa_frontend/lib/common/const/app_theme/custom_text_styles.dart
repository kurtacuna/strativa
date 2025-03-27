import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class CustomTextStyles {
  final BuildContext context;
  const CustomTextStyles(this.context);

  TextStyle get appLogo => Theme.of(context).textTheme.displayLarge!.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );

  TextStyle get appButtonTextStyle => Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 16,
    color: ColorsCommon.kWhite,
    fontWeight: FontWeight.w900,
  );

  TextStyle get textButtonStyle => Theme.of(context).textTheme.titleSmall!.copyWith(
    fontSize: 14,
    color: ColorsCommon.kPrimaryL4,
    fontWeight: FontWeight.w700,
  );
}