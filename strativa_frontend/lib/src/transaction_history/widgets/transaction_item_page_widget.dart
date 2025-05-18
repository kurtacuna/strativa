import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/common/widgets/app_divider_widget.dart';
import 'package:strativa_frontend/src/transaction_history/controllers/transaction_tab_notifier.dart';
import 'package:strativa_frontend/src/transaction_history/models/transaction_history_model.dart';
import 'package:strativa_frontend/src/transfer/models/transaction_fees_model.dart';

class TransactionItemPageWidget extends StatefulWidget {
  const TransactionItemPageWidget({
    required this.index,
    super.key
  });

  final String index;

  @override
  State<TransactionItemPageWidget> createState() => _TransactionItemPageWidgetState();
}

class _TransactionItemPageWidgetState extends State<TransactionItemPageWidget> {
  TransactionTabNotifier? transactionTabNotifier;

  List<TransactionElement>? transactions;
  dynamic transaction;
  
  @override
  void initState() {
    transactionTabNotifier = Provider.of<TransactionTabNotifier>(
      context,
      listen: false
    );

    transactions = transactionTabNotifier!
      .getUserTransactions!.transactions;
    transaction = transactions![int.parse(widget.index)];

    if (transaction.transaction.transactionFeesApplied && transaction.direction == "send") {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        transactionTabNotifier!.fetchTransactionFeesInTransaction(
          context, 
          transaction.transaction.referenceId
        );
      });
    }

    super.initState();
  }

  @override
  void dispose() {
    transactionTabNotifier!.setTransactionFeesInTransactionToNull();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Fee>? transactionFeesInTransaction = context.read<TransactionTabNotifier>().getTransactionFeesInTransaction;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppText.kTransactionHeader,
          style: CustomTextStyles(context).screenHeaderStyle
        ),
        centerTitle: true,
      ),
      body: context.watch<TransactionTabNotifier>().getIsLoading
        ? Center(
            child: AppCircularProgressIndicatorWidget() 
          )
        : Padding(
            padding: AppConstants.kAppPadding,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Transaction Details
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness == Brightness.light
                        ? ColorsCommon.kWhiter
                        : ColorsCommon.kLightDark,
                      borderRadius: BorderRadius.all(Radius.circular(AppConstants.kAppBorderRadius)),
                      boxShadow: Theme.of(context).brightness == Brightness.light 
                        ? AppConstants.kCommonBoxShadowLight
                        : AppConstants.kCommonBoxShadowDark
                    ),
                    child: Padding(
                      padding: AppConstants.kAppPadding,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transaction.direction == "send"
                              ? AppText.kSentTo
                              : AppText.kReceivedFrom,
                            style: CustomTextStyles(context).biggerStyle.copyWith(
                              fontWeight: FontWeight.w900
                            )
                          ),
                  
                          SizedBox(height: 5.h),
                  
                          ListTile(
                            title: Text(
                              transaction.direction == "send"
                                ? transaction.transaction.receiver.fullName
                                : transaction.transaction.sender.fullName,
                              style: CustomTextStyles(context).biggerStyle,
                            ),
                            subtitle: Text(
                              transaction.direction == "send"
                                ? transaction.transaction.receiverAccountNumber
                                : transaction.transaction.senderAccountNumber,
                              style: CustomTextStyles(context).smallStyle.copyWith(
                                color: ColorsCommon.kDarkGray
                              ),
                            ),
                            trailing: ClipOval(
                              child: Image.network(
                                transaction.direction == "send"
                                ? ApiUrls.imageFromNetworkUrl(
                                  imageUrl: transaction.transaction.sender.profilePicture
                                )
                                : ApiUrls.imageFromNetworkUrl(
                                  imageUrl: transaction.transaction.receiver.profilePicture
                                )
                              )
                            ),
                            contentPadding: EdgeInsets.all(0),
                          ),
                  
                          AppDividerWidget(),
                  
                          SizedBox(height: 10.h),
                  
                          Text(
                            AppText.kAnAmountOf,
                            style: CustomTextStyles(context).biggerStyle.copyWith(
                              fontWeight: FontWeight.w900
                            )
                          ),
                  
                          SizedBox(height: 5.h),
                          
                          Center(
                            child: Text(
                              "${
                                transaction.direction == "send"
                                  ? "- "
                                  : ""
                              } ${AppText.kCurrencySign} ${transaction.transaction.amount}",
                              style: CustomTextStyles(context).numberStyle.copyWith(
                                fontSize: 30.sp,
                                color: transaction.direction == "send"
                                  ? ColorsCommon.kAccentL3
                                  : ColorsCommon.kPrimaryL3
                              )
                            )
                          ),

                          transactionFeesInTransaction != null
                            ? Column(
                                children: [
                                  SizedBox(height: 10),
                                  ... List.generate(
                                    transactionFeesInTransaction.length,
                                    (index) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            transactionFeesInTransaction[index].type,
                                            style: CustomTextStyles(context).defaultStyle.copyWith(
                                              fontWeight: FontWeight.w900
                                            )
                                          ),
                                          Text(
                                            transactionFeesInTransaction[index].fee,
                                            style: CustomTextStyles(context).amountStyle.copyWith(
                                              fontSize: CustomTextStyles(context).defaultStyle.fontSize
                                            )
                                          )
                                        ]
                                      );
                                    }
                                  )
                                ]
                              )
                            : Container(),

                          transaction.transaction.note != ""
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 10.h),
                                  AppDividerWidget(),
                                  SizedBox(height: 10.h),

                                  Text.rich(
                                    TextSpan(
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: "Note: ",
                                          style: CustomTextStyles(context).defaultStyle.copyWith(
                                            fontWeight: FontWeight.w900
                                          )
                                        ),
                                        TextSpan(
                                          text: transaction.transaction.note,
                                          style: CustomTextStyles(context).defaultStyle
                                        )
                                      ]
                                    )
                                  ),
                                  
                                  SizedBox(height: 10.h),
                                  AppDividerWidget(),
                                  SizedBox(height: 10.h),
                                ],  
                              )
                            : Container(),
                  
                          SizedBox(height: 20.h),
                  
                          Text(
                            "Reference ID:\n${transaction.transaction.referenceId}",
                            style: CustomTextStyles(context).smallStyle.copyWith(
                              color: ColorsCommon.kDarkGray
                            )
                          ),
                        ]
                      ),
                    )
                  ),

                  SizedBox(height: 30.h),

                  AppButtonWidget(
                    onTap: () {
                      Navigator.of(context).pop();
                    }, 
                    text: AppText.kClose,
                    color: ColorsCommon.kPrimaryL3,
                    firstColor: Colors.transparent,
                    secondColor: Colors.transparent,
                    showBorder: true,
                    borderColor: ColorsCommon.kPrimaryL3,
                  )
                ],
              )
            ),
          )
    );
  }
}