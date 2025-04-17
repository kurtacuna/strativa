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
import 'package:strativa_frontend/common/widgets/otp/models/username_model.dart';
import 'package:strativa_frontend/src/auth/widgets/user_id_field_widget.dart';

class OtpUserIdFieldWidget extends StatelessWidget {
  const OtpUserIdFieldWidget({
    required this.userIdController,
    this.userIdNode,
    required this.formKey,
    super.key
  });

  final TextEditingController userIdController;
  final FocusNode? userIdNode;
  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpNotifier>(
      builder:(context, otpNotifier, child) {
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
                  focusNode: userIdNode,
                  controller: userIdController,
                ),
              ),
  
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
                      if (formKey.currentState!.validate()) {
                        UsernameModel model = UsernameModel(
                          username: userIdController.text
                        );
                        String data = usernameModelToJson(model);

                        otpNotifier.sendOtp(
                          context: context,
                          data: data
                        );
                      }
                    }
                  )
            ],
          )
        );
      },
    );
  }
}