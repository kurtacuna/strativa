import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/src/transaction_history/widgets/tab_widget.dart';

class TransactionTabBarWidget extends StatelessWidget {
  const TransactionTabBarWidget({
    required this.tabController,
    super.key
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: tabController,
      isScrollable: true,
      labelPadding: EdgeInsets.symmetric(
        horizontal: 5,
      ),
      indicator: BoxDecoration(
        color: ColorsCommon.kPrimaryL3,
        borderRadius: BorderRadius.circular(
          AppConstants.kAppBorderRadius * 2,
        ),
      ),
      dividerColor: Colors.transparent,
      labelColor: ColorsCommon.kWhite,
      unselectedLabelColor: ColorsCommon.kPrimaryL3,
      tabAlignment: TabAlignment.start,
      overlayColor: WidgetStatePropertyAll(
        Colors.transparent
      ),
      tabs: List.generate(transactionTabs.length, (index) {
        return Tab(
          height: 30.sp,
          child: TabWidget(
            text: transactionTabs[index],
          ),
        );
      }),
    );
  }
}