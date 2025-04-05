import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/temp_model.dart';
import 'package:strativa_frontend/common/utils/amount.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/balance_notifier.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({
    this.length,
    super.key,
  });

  final int? length;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      children: [
        ...List.generate(transactions.sublist(0, length).length, (index) {
          return ListTile(
            onTap: () {
              // TODO: go to specific transaction details
            },
            leading: CircleAvatar(
              radius: 25.sp,
              backgroundColor: ColorsCommon.kGray,
              // TODO: change leading to store image
              child: ClipOval(
                child: Icon(
                  MaterialIcons.shop,
                  color: Colors.amber,
                  size: 40,
                ),
              ),
            ),
            title: Text(
              transactions[index]['store'],
              style: CustomTextStyles(context).defaultStyle,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "- ${transactions[index]['amount']}",
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
                    ? "${AppText.kCurrencySign} ${addCommaToAmount(double.parse(transactions[index]['resulting_balance']))}"
                    : "${AppText.kCurrencySign} •••••",
                  style: CustomTextStyles(context).numberStyle.copyWith(
                    fontSize: CustomTextStyles(context).defaultStyle.fontSize,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  DateFormat('MMM d, y H:m').format(DateTime.parse(transactions[index]['datetime'])),
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
}