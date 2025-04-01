import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';

class TabWidget extends StatelessWidget {
  const TabWidget({
    required this.text,
    super.key
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.sp,
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: ColorsCommon.kPrimaryL3,
          width: AppConstants.kAppBorderWidth,
        ),
        borderRadius: BorderRadius.circular(
          AppConstants.kAppBorderRadius * 2,
        ),
      ),
      child: Center(
        child: Text(
          text,
        ),
      ),
    );
  }
}