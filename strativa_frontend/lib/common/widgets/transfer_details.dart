import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';

class TransferDetails extends StatelessWidget {
  final String fromLabel;
  final String fromAccountName;
  final String fromAccountNumber;
  final String toLabel;
  final String toAccountName;
  final String toAccountNumber;
  final String currency;
  final String amount;

  const TransferDetails({
    super.key,
    required this.fromLabel,
    required this.fromAccountName,
    required this.fromAccountNumber,
    required this.toLabel,
    required this.toAccountName,
    required this.toAccountNumber,
    required this.currency,
    required this.amount,
  });

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
            fromLabel,
            style: styles.smallStyle.copyWith(
              color: ColorsCommon.kDarkGray,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            fromAccountName.toUpperCase(),
            style: styles.bigStyle.copyWith(
              color: ColorsCommon.kDark,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            fromAccountNumber,
            style: styles.defaultStyle.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 32.h),
          Text(
            toLabel,
            style: styles.smallStyle.copyWith(
              color: ColorsCommon.kDarkGray,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            toAccountName.toUpperCase(),
            style: styles.bigStyle.copyWith(
              color: ColorsCommon.kDark,
              fontWeight: FontWeight.w700,
              fontSize: 20.sp,
              letterSpacing: 0.5,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            toAccountNumber,
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
                "$currency ",
                style: styles.defaultStyle.copyWith(
                  color: ColorsCommon.kDark,
                  fontSize: 16.sp,
                ),
              ),
              Text(
                amount,
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
