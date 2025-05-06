import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/src/entrypoint/controllers/bottom_nav_notifier.dart';

class TransferButtons extends StatelessWidget {
  const TransferButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavNotifier>(
      builder: (context, bottomNavNotifier, child) {
        return Container(
          decoration: BoxDecoration(
            color: ColorsCommon.kWhiter,
            borderRadius: BorderRadius.circular(12.r),
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(28, 28, 30, 0.2),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorsCommon.kPrimaryL3,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    elevation: 0,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  onPressed: () {
                    bottomNavNotifier.setIndex = 1;
                    context.go(AppRoutes.kEntrypoint);
                  },
                  child: Text(
                    AppText.kNewTransfer,
                    style: TextStyle(
                      color: ColorsCommon.kWhiter,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    bottomNavNotifier.setIndex = 0;
                    context.go(AppRoutes.kEntrypoint);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: ColorsCommon.kAccentL3,
                    side: BorderSide(color: ColorsCommon.kAccentL3, width: 1.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                  ),
                  child: Text(
                    AppText.kGoToMyAccounts,
                    style: TextStyle(
                      color: ColorsCommon.kAccentL3,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
