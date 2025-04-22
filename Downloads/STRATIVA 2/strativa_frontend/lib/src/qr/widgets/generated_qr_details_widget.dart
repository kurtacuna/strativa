import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/temp_model.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';
import 'package:strativa_frontend/common/widgets/app_divider_widget.dart';
import 'package:strativa_frontend/common/widgets/app_text_button_widget.dart';

class GeneratedQrDetailsWidget extends StatelessWidget {
  const GeneratedQrDetailsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
          ? ColorsCommon.kWhiter
          : ColorsCommon.kLigherDark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.kAppBorderRadius),
          bottomRight: Radius.circular(AppConstants.kAppBorderRadius)
        ),
        boxShadow: Theme.of(context).brightness == Brightness.light
          ? AppConstants.kCommonBoxShadowLight
          : AppConstants.kCommonBoxShadowDark,
      ),
      child: Column(
        children: [
          Padding(
            padding: AppConstants.kAppPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
          
                // TODO: replace with the generated qr code
                Center(
                  child: Container(
                    color: ColorsCommon.kGray,
                    width: 200,
                    height: 200,
                  ),
                ),
          
                SizedBox(height: 40.h),
          
                Text(
                  AppText.kDepositTo,
                  style: CustomTextStyles(context).biggerStyle.copyWith(
                    color: ColorsCommon.kDarkerGray,
                  ),
                ),
                
                SizedBox(height: 20.h),
                
                // TODO: pass id to this file for data
                Text(
                  otherAccounts[0]['type'].toUpperCase(),
                  style: CustomTextStyles(context).bigStyle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),

                SizedBox(height: 10.h),

                Text(
                  otherAccounts[0]['number'],
                  style: CustomTextStyles(context).bigStyle.copyWith(
                    color: ColorsCommon.kDarkerGray,
                  ),
                ),

                SizedBox(height: 40.h),

                Text(
                  AppText.kAmountRequested,
                  style: CustomTextStyles(context).defaultStyle.copyWith(
                    color: ColorsCommon.kDarkerGray,
                  ),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    // TODO: pass amount entered from previous screen
                    AppAmountWidget(
                      amount: "1000.00",
                    ),
                  ]
                ),
              ]
            ),
          ),
          
          SizedBox(height: 10.h),

          AppDividerWidget(),

          Padding(
            padding: AppConstants.kAppPadding / 2,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double parentWidth = constraints.maxWidth;
                return Row(
                  children: [
                    SizedBox(
                      width: parentWidth / 2,
                      child: AppTextButtonWidget(
                        onPressed: () {
                          context.pop();
                        },
                        prefixIcon: AppIcons.kEditIcon,
                        text: AppText.kEdit.toUpperCase(),
                        color: ColorsCommon.kDarkerGray,
                        spacing: 10,
                        overlayColor: ColorsCommon.kAccentL2,
                      ),
                    ),

                    SizedBox(
                      width: parentWidth / 2,
                      child: AppTextButtonWidget(
                        onPressed: () {
                          // TODO: handle share
                        },
                        prefixIcon: AppIcons.kShareIcon,
                        text: AppText.kShare.toUpperCase(),
                        spacing: 10,
                        overlayColor: ColorsCommon.kAccentL3,
                      ),
                    ),
                  ],
                );
              }
            ),
          ),
        ],
      ),
    );
  }
}