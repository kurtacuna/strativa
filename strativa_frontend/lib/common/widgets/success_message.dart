import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';

class SuccessMessage extends StatelessWidget {
  const SuccessMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final styles = CustomTextStyles(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 0.h),
        Center(
          child: Image.asset(
            'assets/icons/success_transfer.gif',
            height: 300.h, 
          ),
        ),
        SizedBox(height: 0.h),
        Padding(
          padding: EdgeInsets.only(left: 24.w),
          child: Text(
            AppText.kTransferSuccessful,
            style: styles.bigStyle.copyWith(
              fontWeight: FontWeight.w700,
              color: ColorsCommon.kDark,
              fontSize: 20.sp,
              letterSpacing: 0.5,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        SizedBox(height: 4.h),
      ],
    );
  }
}
