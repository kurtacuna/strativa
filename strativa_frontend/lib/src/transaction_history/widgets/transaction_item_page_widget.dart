import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_divider_widget.dart';
import 'package:strativa_frontend/src/transaction_history/controllers/transaction_tab_notifier.dart';
import 'package:strativa_frontend/src/transaction_history/models/transaction_history_model.dart';

class TransactionItemPageWidget extends StatelessWidget {
  const TransactionItemPageWidget({
    required this.index,
    super.key
  });

  final String index;

  @override
  Widget build(BuildContext context) {
    List<TransactionElement> transactions = context.read<TransactionTabNotifier>()
      .getUserTransactions!.transactions;
    TransactionElement transaction = transactions[int.parse(index)];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          AppText.kTransactionHeader,
          style: CustomTextStyles(context).screenHeaderStyle
        ),
        centerTitle: true,
      ),
      body: Padding(
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