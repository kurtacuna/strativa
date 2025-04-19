import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/widgets/otp/controllers/otp_notifier.dart';
import 'package:strativa_frontend/common/widgets/otp/models/otp_model.dart';

class OtpPinputWidget extends StatelessWidget {
  const OtpPinputWidget({
    required this.otpNode,
    required this.userIdController,
    super.key
  });

  final FocusNode otpNode;
  final TextEditingController userIdController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      padding: EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
          ? ColorsCommon.kWhite
          : ColorsCommon.kDark,
        borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius)
      ),
      child: Pinput(
        enabled: context.watch<OtpNotifier>().getIsPinputEnabled,
        obscureText: true,
        focusNode: otpNode,
        cursor: Text(
          AppConstants.kPinputCursor,
          style: CustomTextStyles(context).biggestStyle.copyWith(
            color: ColorsCommon.kPrimaryL4
          )
        ),
        onCompleted: (value) {
          OtpModel model = OtpModel(
            username: userIdController.text,
            otp: value
          );
          String data = otpModelToJson(model);

          context.read<OtpNotifier>().validateOtp(
            context: context,
            data: data,
            query: VerifyOtpTypes.peekbalance.name
          );
        },

        defaultPinTheme: PinTheme(
          width: 50.sp,
          height: 70.sp,
          margin: EdgeInsets.symmetric(horizontal: 10),
          textStyle: CustomTextStyles(context).biggestStyle,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
              ? ColorsCommon.kGray
              : ColorsCommon.kDarkGray,
            borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius)
          ),
        ),

        focusedPinTheme: PinTheme(
          width: 50.sp,
          height: 70.sp,
          margin: EdgeInsets.symmetric(horizontal: 10),
          textStyle: CustomTextStyles(context).biggestStyle,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
              ? ColorsCommon.kGray
              : ColorsCommon.kDarkGray,
            borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
            border: Border.all(
              color: ColorsCommon.kPrimaryL4
            )
          ),
        ),

        disabledPinTheme: PinTheme(
          width: 50.sp,
          height: 70.sp,
          margin: EdgeInsets.symmetric(horizontal: 10),
          textStyle: CustomTextStyles(context).biggestStyle,
          decoration: BoxDecoration(
            color:ColorsCommon.kAccentL4,
            borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius)
          ),
        ),
      )
    );
  }
}