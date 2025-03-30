import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class AppIcons {
  static SvgPicture kBottomNavBarMyAccountsIcon({ColorFilter? colorFilter}) => SvgPicture.asset(
    "assets/icons/my_accounts_icon.svg",
    height: 20.sp,
    width: 20.sp,
    colorFilter: colorFilter,
  );
  static SvgPicture kBottomNavBarTransferIcon({ColorFilter? colorFilter}) => SvgPicture.asset(
    "assets/icons/transfer_icon.svg",
    height: 20.sp,
    width: 20.sp,
    colorFilter: colorFilter
  );
  static SvgPicture kBottomNavBarPayLoadIcon({ColorFilter? colorFilter}) => SvgPicture.asset(
    "assets/icons/pay_load_icon.svg",
    height: 20.sp,
    width: 20.sp,
    colorFilter: colorFilter
  );
  static SvgPicture kBottomNavBarInvestIcon({ColorFilter? colorFilter}) => SvgPicture.asset(
    "assets/icons/invest_icon.svg",
    height: 20.sp,
    width: 20.sp,
    colorFilter: colorFilter
  );
  static SvgPicture kBottomNavBarProfileIcon({ColorFilter? colorFilter}) => SvgPicture.asset(
    "assets/icons/profile_icon.svg",
    height: 20.sp,
    width: 20.sp,
    colorFilter: colorFilter
  );
  // static const Icon kUserIdFieldIcon = Icon(
  //   Ionicons.mail_outline,
  // );
  static SvgPicture kUserIdFieldIcon({ColorFilter? colorFilter}) => SvgPicture.asset(
    'assets/icons/close_mail_icon.svg',
    height: 20.sp,
    width: 20.sp,
    colorFilter: colorFilter,
  );
  // static const Icon kPasswordFieldIcon = Icon(
  //   Ionicons.lock_open,
  // );
  static SvgPicture kPasswordFieldIcon({ColorFilter? colorFilter}) => SvgPicture.asset(
    'assets/icons/open_lock_icon.svg',
    height: 25.sp,
    width: 25.sp,
    colorFilter: colorFilter,
    fit: BoxFit.contain,
  );
  static const Icon kEyeOpenIcon = Icon(
    Feather.eye,
  );
  static const Icon kEyeCloseIcon = Icon(
    Feather.eye_off,
  );
  static Image get kQrIcon => Image.asset(
    'assets/icons/qr_icon.png',
    height: 25.sp,
  );
  static Image get kMastercardIcon => Image.asset(
    'assets/icons/mastercard_icon.png',
    height: 20.sp,
  );
  static Image get kExpandIcon => Image.asset(
    'assets/icons/expand_icon.png',
    height: 20.sp,
  );
  static Image get kSimIcon => Image.asset(
    'assets/icons/sim_icon.png',
    height: 20.sp,
  );
  static Image get kFreeIcon => Image.asset(
    'assets/icons/free_icon.png',
    height: 60.sp,
  );
}