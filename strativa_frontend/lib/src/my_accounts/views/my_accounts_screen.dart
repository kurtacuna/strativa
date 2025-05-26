import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/date.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/controllers/app_transfer_receive_widget_notifier.dart';
import 'package:strativa_frontend/common/widgets/temp_empty_widget.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/user_data_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/detailed_card_widget.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/top_bar_widget.dart';
import 'package:strativa_frontend/src/transaction_history/controllers/transaction_tab_notifier.dart';
import 'package:strativa_frontend/src/transaction_history/widgets/transaction_history_widget.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/wallet_cards_widget.dart';

class MyAccountsScreen extends StatelessWidget {
  const MyAccountsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserDataNotifier>().fetchUserData(context);
      context.read<TransactionTabNotifier>().fetchUserTransactions(context);
      context.read<AppTransferReceiveWidgetNotifier>().fetchUserAccounts(context);
    });

    return Consumer<UserDataNotifier>(
      builder: (context, userDataNotifier, child) {
        TransactionTabNotifier transactionTabNotifier = Provider.of<TransactionTabNotifier>(
          context,
          listen: true
        );
        AppTransferReceiveWidgetNotifier appTransferReceiveWidgetNotifier = Provider.of<AppTransferReceiveWidgetNotifier>(
          context,
          listen: false
        );
        
        if (
          userDataNotifier.getUserData == null || 
          userDataNotifier.getIsLoading || 
          transactionTabNotifier.getUserTransactions == null || 
          transactionTabNotifier.getIsLoading ||
          appTransferReceiveWidgetNotifier.getAccountsList == [] ||
          appTransferReceiveWidgetNotifier.getIsLoading
        ) {
          return Scaffold(
            body: Center(
              child: AppCircularProgressIndicatorWidget()
            )
          );
        }
        
        return Padding(
          padding: AppConstants.kAppPadding,
          child: Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10.h),
                          
                    TopBarWidget(),
                          
                    SizedBox(height: 10.h),
                        
                    DetailedCardWidget(),
                    
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
                              style: CustomTextStyles(context).defaultStyle.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          
                            SizedBox(height: 5.h),
                          
                            Text(
                              transactionTabNotifier.getUserTransactions!.transactions.isEmpty
                                ? AppText.kNoTransactionsYet
                                : daysPastSinceDate(transactionTabNotifier.getUserTransactions!.transactions[0].transaction.datetime),
                              style: CustomTextStyles(context).defaultStyle.copyWith(
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ]
                        ),
                          
                        InkWell(
                          onTap: () {
                            context.push(AppRoutes.kTransactionHistoryScreen);
                          },
                          borderRadius: BorderRadius.circular(AppConstants.kAppBorderRadius),
                          child: Ink(
                            padding: AppConstants.kSmallPadding,
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
                          
                    Consumer<TransactionTabNotifier>(
                      builder: (context, transactionTabNotifier, child) {
                        if (transactionTabNotifier.getUserTransactions!.transactions.isNotEmpty) {
                          return TransactionHistoryWidget(
                            length: transactionTabNotifier.getUserTransactions!.transactions.length < 3
                              ? transactionTabNotifier.getUserTransactions!.transactions.length
                              : 3
                          );
                        } else {
                          return Expanded(
                            child: Column(
                              children: [
                                SizedBox(height: 100.h),
                                AppEmptyWidget(),
                              ],
                            ),
                          );
                        }
                      }
                    ),

                    SizedBox(height: 50)
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}