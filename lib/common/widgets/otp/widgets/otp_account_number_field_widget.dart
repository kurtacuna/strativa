import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/common/widgets/app_text_button_widget.dart';
import 'package:strativa_frontend/common/widgets/otp/controllers/otp_notifier.dart';
import 'package:strativa_frontend/common/widgets/otp/models/account_number_model.dart';
import 'package:strativa_frontend/src/auth/widgets/user_id_field_widget.dart';

class OtpAccountNumberFieldWidget extends StatefulWidget {
  const OtpAccountNumberFieldWidget({
    required this.accountNumberController,
    this.accountNumberNode,
    required this.formKey,
    this.initialValue,
    this.sendOtp = false,
    super.key
  });

  final TextEditingController accountNumberController;
  final FocusNode? accountNumberNode;
  final GlobalKey<FormState> formKey;
  final String? initialValue;
  final bool? sendOtp;

  @override
  State<OtpAccountNumberFieldWidget> createState() => _OtpAccountNumberFieldWidgetState();
}

class _OtpAccountNumberFieldWidgetState extends State<OtpAccountNumberFieldWidget> {
  void _sendOtp(BuildContext context, OtpNotifier otpNotifier) {
    if (widget.formKey.currentState!.validate()) {
      AccountNumber model = AccountNumber(
        accountNumber: widget.accountNumberController.text
      );
      String data = accountNumberToJson(model);

      otpNotifier.sendOtp(
        context: context,
        data: data
      );
    }
  }

  bool hasSentOtp = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpNotifier>(
      builder: (context, otpNotifier, child) {
        if (widget.sendOtp == true && !hasSentOtp) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _sendOtp(context, otpNotifier);
            
            setState(() {
              hasSentOtp = true;
            });
          });
        }

        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
              ? ColorsCommon.kWhite
              : ColorsCommon.kDark,
            borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius)
          ),
          child: Row(
            spacing: 5,
            children: [
              SizedBox(
                width: 270.w,
                child: UserIdFieldWidget(
                  focusNode: widget.accountNumberNode,
                  controller: widget.accountNumberController,
                  showPrefixIcon: false,
                  hintText: AppText.kAccountNumber,
                  initialValue: widget.initialValue,
                  validatorText: AppText.kPleaseEnterAValidAccountNumber,
                ),
              ),
  
              // Send OTP Button
              otpNotifier.getIsLoading
                ? SizedBox(
                  width: 90.w,
                  height: 40.sp,
                  child: Center(child: AppCircularProgressIndicatorWidget())
                )
                : otpNotifier.getIsDisabled
                  ? SizedBox(
                    width: 90.w,
                    child: AppTextButtonWidget(
                      text: "Resend ${otpNotifier.getDuration}s",
                      style: CustomTextStyles(context).textButtonStyle.copyWith(
                        color: ColorsCommon.kAccentL3,
                        fontSize: 12.sp,
                      ),
                      onPressed: null,
                    ),
                  )
                  : AppTextButtonWidget(
                    text: AppText.kSendOtp,
                    style: CustomTextStyles(context).textButtonStyle.copyWith(
                      color: ColorsCommon.kPrimaryL4,
                      fontSize: 14.sp,
                    ),
                    onPressed: () {
                      _sendOtp(context, otpNotifier);
                    }
                  )
            ],
          )
        );
      },
    );
  }
}