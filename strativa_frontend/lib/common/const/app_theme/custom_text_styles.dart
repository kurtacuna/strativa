import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class CustomTextStyles {
  final BuildContext context;
  const CustomTextStyles(this.context);

  TextStyle get appLogo => Theme.of(context).textTheme.displayLarge!.copyWith(
    fontSize: 30.sp,
    fontWeight: FontWeight.w900,
  );

  TextStyle get appButtonTextStyle => Theme.of(context).textTheme.titleMedium!.copyWith(
    fontSize: 16.sp,
    color: ColorsCommon.kWhite,
    fontWeight: FontWeight.w900,
  );

  TextStyle get textButtonStyle => Theme.of(context).textTheme.titleSmall!.copyWith(
    fontSize: 14.sp,
    color: ColorsCommon.kPrimaryL4,
    fontWeight: FontWeight.w700,
  );

  TextStyle get screenHeaderStyle => Theme.of(context).textTheme.labelMedium!.copyWith(
    fontSize: 14.sp,
    fontWeight: FontWeight.w900,
  );

  TextStyle get bigStyle => Theme.of(context).textTheme.labelLarge!.copyWith(
    fontSize: 18.sp,
  );

  TextStyle get defaultStyle => Theme.of(context).textTheme.labelLarge!.copyWith(
    fontSize: 16.sp,
  );

  TextStyle get smallStyle => Theme.of(context).textTheme.labelMedium!.copyWith(
    fontSize: 14.sp,
  );

  TextStyle get smallerStyle => Theme.of(context).textTheme.labelSmall!.copyWith(
    fontSize: 12.sp,
  );

  TextStyle get smallestStyle => Theme.of(context).textTheme.labelSmall!.copyWith(
    fontSize: 10.sp,
  );
  
  TextStyle get currencyStyle => Theme.of(context).textTheme.labelSmall!.copyWith(
    fontFamily: GoogleFonts.notoSans().fontFamily,
  );
}