import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/temp_model.dart';
import 'package:strativa_frontend/common/utils/currency.dart';
import 'package:strativa_frontend/common/utils/date.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/balance_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/card_widget.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/top_bar_widget.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/transaction_history_widget.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/wallet_cards_widget.dart';

class MyAccountsScreen extends StatelessWidget {
  const MyAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppConstants.kAppPadding,
      child: Consumer<BalanceNotifier> (
        builder: (context, balanceNotifier, child) {
          return Scaffold(
            body: Column(
              children: [
                SizedBox(height: 10.h),
          
                TopBarWidget(),
          
                SizedBox(height: 10.h),
          
                Stack(
                  children: [
                    const CardWidget(shadow: true),
                    Padding(
                      padding: AppConstants.kCardPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // TODO: change data once backend is done
                        children: [
                          Text(
                            AppText.kCardBalance,
                            style: CustomTextStyles(context).smallStyle.copyWith(
                              color: ColorsCommon.kWhite,
                              fontWeight: FontWeight.w900,
                            )
                          ),
                          
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                balanceNotifier.getShowBalance
                                ? "₱ ${addCommaToPrice(double.parse(userData['balance']))}"
                                : "₱ •••••",
                                style: CustomTextStyles(context).currencyStyle.copyWith(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 35.sp,
                                  color: ColorsCommon.kWhite,
                                ),
                              ),
                              
                              GestureDetector(
                                onTap: () {
                                  balanceNotifier.toggleShowBalance();
                                },
                                child: balanceNotifier.getShowBalance
                                ? Icon(
                                  AppIcons.kEyeOpenIcon.icon,
                                  color: ColorsCommon.kWhite,
                                  size: 30.sp,
                                )
                                : Icon(
                                  AppIcons.kEyeCloseIcon.icon,
                                  color: ColorsCommon.kWhite,
                                  size: 30.sp,
                                ),
                              ),
                            ]
                          ),
          
                          SizedBox(height: 20.h),
          
                          Text(
                            balanceNotifier.getShowBalance
                            ? userData['strativa_card_number']
                            : "•••• •••• •••• ••••",
                            style: CustomTextStyles(context).smallStyle.copyWith(
                              wordSpacing: 5,
                              color: ColorsCommon.kWhite,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
          
                          Text(
                            balanceNotifier.getShowBalance
                            ? userData['strativa_card_expiry']
                            : "••••",
                            style: CustomTextStyles(context).smallerStyle.copyWith(
                              color: ColorsCommon.kWhite,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
          
                SizedBox(height: 30.h),
                
                WalletCardsWidget(),
          
                SizedBox(height: 20.h),
          
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppText.kTransactionHeader,
                          style: CustomTextStyles(context).smallStyle.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
          
                        SizedBox(height: 5.h),
          
                        Text(
                          daysPastSinceDate(DateTime.parse(userData['recent_transaction_date'])),
                          style: CustomTextStyles(context).smallerStyle.copyWith(
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ]
                    ),
          
                    InkWell(
                      onTap: () {
                        // TODO: go to transaction history
                      },
                      borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
                      child: Ink(
                        padding: AppConstants.kIconPadding,
                        child: Theme.of(context).brightness == Brightness.dark
                        ? Image(
                          image: AppIcons.kExpandIcon.image,
                          height: AppIcons.kExpandIcon.height,
                          color: ColorsCommon.kWhite,
                        )
                        : AppIcons.kExpandIcon,
                      ),
                    ),
                  ]
                ),
          
                SizedBox(height: 10.h),
          
                TransactionHistoryWidget(),
              ],
            ),
          );
        }
      ),
    );
  }
}