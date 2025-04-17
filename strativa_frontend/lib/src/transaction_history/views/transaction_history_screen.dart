import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/common/widgets/temp_empty_widget.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/detailed_card_widget.dart';
import 'package:strativa_frontend/src/transaction_history/controllers/transaction_tab_notifier.dart';
import 'package:strativa_frontend/src/transaction_history/widgets/transaction_history_widget.dart';
import 'package:strativa_frontend/src/transaction_history/widgets/transaction_tab_bar_widget.dart';

class TransactionHistoryScreen extends StatefulWidget {
  const TransactionHistoryScreen({super.key});

  @override
  State<TransactionHistoryScreen> createState() => _TransactionHistoryScreenState();
}

class _TransactionHistoryScreenState extends State<TransactionHistoryScreen> with TickerProviderStateMixin{
  late final TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: TransactionTypes.values.length,
      vsync: this,
    );

    _tabController.addListener(_handleSelection);
    
    super.initState();
  }

  void _handleSelection() {
    final notifier = Provider.of<TransactionTabNotifier>(
      context,
      listen: false,
    );

    if (_tabController.indexIsChanging) {
      notifier.setCurrentTabIndex = _tabController.index; 
      notifier.setCurrentTab = TransactionTypes.values[notifier.getCurrentTabIndex];
      notifier.fetchUserTransactions(context);
    }
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleSelection);
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppText.kTransactionHeader,
          style: CustomTextStyles(context).screenHeaderStyle,
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: AppConstants.kAppPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DetailedCardWidget(),
            
            SizedBox(height: 30.h),

            Text(
              AppText.kTransactionHistoryHeader,
              style: CustomTextStyles(context).biggerStyle.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),

            SizedBox(height: 20.h),

            TransactionTabBarWidget(
              tabController: _tabController,
            ),

            SizedBox(height: 20.h),

            Expanded(
              child: Consumer<TransactionTabNotifier>(
                builder: (context, transactionTabNotifier, child) {
                  if (transactionTabNotifier.getUserTransactions == null || transactionTabNotifier.getIsLoading) {
                    return Center(
                      child: AppCircularProgressIndicatorWidget()
                    );
                  }

                  if (transactionTabNotifier.getUserTransactions!.transactions.isEmpty) {
                    return Center(
                      child: AppEmptyWidget()
                    );
                  }

                  return SingleChildScrollView(
                    child: TransactionHistoryWidget(),
                  );
                } ,
              )
            ),
          ],
        ),
      ),
    );
  }
}