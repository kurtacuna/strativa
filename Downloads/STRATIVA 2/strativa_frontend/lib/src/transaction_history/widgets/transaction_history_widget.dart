import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/utils/amount.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/balance_notifier.dart';
import 'package:strativa_frontend/src/transaction_history/controllers/transaction_tab_notifier.dart';
import 'package:strativa_frontend/src/transaction_history/models/transaction_history_model.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({
    this.length,
    super.key,
  });

  final int? length;

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionTabNotifier>(
      builder: (context, transactionTabNotifier, child) {
        List<TransactionElement> transactions = transactionTabNotifier.getUserTransactions!.transactions;

        return Column(
          spacing: 5.h,
          children: [
            ...List.generate(
              length ?? transactions.length, (index) {
              TransactionElement transaction = transactions[index];

              return ListTile(
                onTap: () {
                  // TODO: go to specific transaction details
                },
                leading: CircleAvatar(
                  radius: 25.sp,
                  backgroundColor: ColorsCommon.kGray,
                  child: ClipOval(
                    child: Image.network(
                      transaction.direction == "send"
                        ? ApiUrls.imageFromNetworkUrl(imageUrl: transaction.transaction.receiver.profilePicture)
                        : ApiUrls.imageFromNetworkUrl(imageUrl: transaction.transaction.sender.profilePicture)
                    )
                  ),
                ),
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction.direction == "send"
                        ? transaction.transaction.receiver.fullName
                        : transaction.transaction.sender.fullName,     
                      style: CustomTextStyles(context).defaultStyle,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      transaction.direction == "send"
                        ? "Send"
                        : "Receive",
                      style: CustomTextStyles(context).smallerStyle.copyWith(
                        color: ColorsCommon.kDarkerGray,
                      ),
                    )
                  ]
                ),
                subtitle: Text(
                  "${transaction.direction == "send" ? "-" : "+"} ${addCommaToAmount(
                    double.parse(transaction.transaction.amount)
                  )}",
                  style: CustomTextStyles(context).smallStyle.copyWith(
                    color: ColorsCommon.kDarkerGray,
                  ),
                ),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 2,
                  children: [
                    Text(
                      context.watch<BalanceNotifier>().getShowBalance
                        ? "${AppText.kCurrencySign} ${addCommaToAmount(
                          double.parse(transaction.resultingBalance)
                        )}"
                        : "${AppText.kCurrencySign} •••••",
                      style: CustomTextStyles(context).numberStyle.copyWith(
                        fontSize: CustomTextStyles(context).defaultStyle.fontSize,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    Text(
                      DateFormat('MMM d, y H:m').format(DateTime.parse(transaction.transaction.datetime.toString())),
                      style: CustomTextStyles(context).smallStyle.copyWith(
                        color: ColorsCommon.kDarkerGray,
                      ),
                    ),
                  ]
                ),
              );
            }),
          ]
        );
      }
    );
  }
}