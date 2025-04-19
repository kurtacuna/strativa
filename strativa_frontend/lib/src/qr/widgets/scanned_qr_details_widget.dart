import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/amount.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';

class ScannedQrDetailsWidget extends StatelessWidget {
  const ScannedQrDetailsWidget({
    required this.fullName,
    required this.type,
    required this.accountNumber,
    this.amountRequested,
    super.key
  });

  final String fullName;
  final String type;
  final String accountNumber;
  final String? amountRequested;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().screenWidth,
      decoration: BoxDecoration(
        color: Theme.of(context).brightness == Brightness.light
          ? ColorsCommon.kWhiter
          : ColorsCommon.kLightDark,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(AppConstants.kAppBorderRadius),
          bottomRight: Radius.circular(AppConstants.kAppBorderRadius),
        ),
        boxShadow: Theme.of(context).brightness == Brightness.light
          ? AppConstants.kCommonBoxShadowLight
          : AppConstants.kCommonBoxShadowDark,
      ),
      child: Padding(
        padding: AppConstants.kAppPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppText.kTransferTo,
              style: CustomTextStyles(context).biggestStyle.copyWith(
                fontWeight: FontWeight.w900
              ),
            ),

            SizedBox(height: 25.h),

            Text(
              fullName.toUpperCase(),
              style: CustomTextStyles(context).biggerStyle.copyWith(
                color: ColorsCommon.kPrimaryL1,
                fontWeight: FontWeight.w900
              )
            ),

            SizedBox(height: 5.h),

            Text(
              type,
              style: CustomTextStyles(context).bigStyle.copyWith(
                fontWeight: FontWeight.w900,
              )
            ),

            SizedBox(height: 10.h),

            Text(
              accountNumber,
              style: CustomTextStyles(context).bigStyle.copyWith(
                color: ColorsCommon.kDarkGray
              )
            ),

            amountRequested != ""
              ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                      AppAmountWidget(
                        amount: removeCommaFromAmount(amountRequested!),
                      ),
                    ]
                  ),
                ]
              )
              : Container()
          ]
        )
      )
    );
  }
}