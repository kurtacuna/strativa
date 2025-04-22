import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';

class TransferDetails extends StatelessWidget {
  const TransferDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = CustomTextStyles(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
      color: ColorsCommon.kWhite,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppText.kTransferFrom,
            style: styles.smallStyle.copyWith(
              color: ColorsCommon.kDarkGray,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppText.kSavingsAccount.toUpperCase(),
            style: styles.bigStyle.copyWith(
              color: ColorsCommon.kDark,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '0637892064',
            style: styles.defaultStyle.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 32.h),
          Text(
            AppText.kTransferTo,
            style: styles.smallStyle.copyWith(
              color: ColorsCommon.kDarkGray,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            AppText.kTimeDepositAccount.toUpperCase(),
            style: styles.bigStyle.copyWith(
              color: ColorsCommon.kDark,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            '0637892064',
            style: styles.defaultStyle.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 32.h),
          Text(
            AppText.kTransferAmount,
            style: styles.smallStyle.copyWith(
              color: ColorsCommon.kDarkGray,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                "PHP ",
                style: styles.defaultStyle.copyWith(
                  color: ColorsCommon.kDark,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                "1,000.00",
                style: styles.amountStyle.copyWith(
                  fontWeight: FontWeight.w600,
                  color: ColorsCommon.kDark,
                  fontSize: 20.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}