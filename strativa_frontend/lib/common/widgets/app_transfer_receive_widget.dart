import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/temp_model.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';
import 'package:strativa_frontend/common/widgets/app_divider_widget.dart';

class AppTransferReceiveWidget extends StatelessWidget {
  const AppTransferReceiveWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
        color: Theme.of(context).brightness == Brightness.light
          ? ColorsCommon.kWhiter
          : ColorsCommon.kLightDark,
        boxShadow: Theme.of(context).brightness == Brightness.light
          ? AppConstants.kCommonBoxShadowLight
          : AppConstants.kCommonBoxShadowDark,
      ),
      padding: AppConstants.kAppPadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
              onTap: () {
                // TODO: show bottom modal of accounts
              },
              child: Ink(
                padding: AppConstants.kSmallPadding,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppText.kDepositTo,
                      style: CustomTextStyles(context).biggerStyle.copyWith(
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                
                    AppIcons.kRightArrowIcon,
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: 5.h),

          AppDividerWidget(),

          SizedBox(height: 15.h),

          // TODO: create model and change data
          // must come from the caller
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  otherAccounts[0]['type'].toUpperCase(),
                  style: CustomTextStyles(context).bigStyle.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
                ),
            
                AppAmountWidget(
                  amount: otherAccounts[0]['balance'],
                ),
              ],
            ),
          ),
        ]
      ),
    );
  }
}