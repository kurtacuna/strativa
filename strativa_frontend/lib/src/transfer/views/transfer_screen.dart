import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/widgets/app_qr_card_widget.dart';
import 'package:strativa_frontend/common/widgets/app_icon_gradient_card_widget.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double spacing = 12.0.w;
    final styles = CustomTextStyles(context);

    final double cardWidth = (1.sw - 2 * 20.w - 2 * spacing) / 3;

    return Scaffold(
      backgroundColor: ColorsLight.kWhite,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40.h),
                Text(
                  AppText.kTransfer,
                  style: styles.biggerStyle.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  AppText.kTransferHelp,
                  style: styles.defaultStyle.copyWith(
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20.h),
                const AppQRCardWidget(onTap: _noop),
                SizedBox(height: 30.h),
                Text(
                  AppText.kFundTransfer,
                  style: styles.biggerStyle.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16.h),

                /// Fund Transfer Options
                Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: AppIconGradientCardWidget(
                        iconPath: 'assets/icons/another_account.png',
                        label: AppText.kToAnotherAccount,
                        onTap: () {
                          context.push(AppRoutes.kTransferToAccount);
                        },
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: AppIconGradientCardWidget(
                        iconPath: 'assets/icons/another_strativa_account.png',
                        label: AppText.kToAnotherStrativaAccount,
                        onTap: () {
                          context.push(AppRoutes.kTransferToStrativaAccount);
                        },
                      ),
                    ),
                    SizedBox(
                      width: cardWidth,
                      child: AppIconGradientCardWidget(
                        iconPath: 'assets/icons/another_bank_account.png',
                        label: AppText.kToAnotherBankAccount,
                        onTap: () {
                          context.push(AppRoutes.kTransferToBankAccount);
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30.h),

                /// Deposit Section
                Text(
                  AppText.kDeposit,
                  style: styles.biggerStyle.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 16.h),
                Wrap(
                  spacing: spacing,
                  runSpacing: spacing,
                  children: [
                    SizedBox(
                      width: cardWidth,
                      child: AppIconGradientCardWidget(
                        iconPath: 'assets/icons/deposit_check_icon.png',
                        label: AppText.kDepositCheck,
                        onTap: () {},
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

void _noop() {}
