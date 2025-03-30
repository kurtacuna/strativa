import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/temp_model.dart';
import 'package:strativa_frontend/common/utils/currency.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/balance_notifier.dart';

class TransactionHistoryWidget extends StatelessWidget {
  const TransactionHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5.h,
      children: [
        ...List.generate(userData['transactions'].sublist(0, 3).length, (index) {
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
              userData['transactions'][index]['store'],
              style: CustomTextStyles(context).smallStyle,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              "- ${userData['transactions'][index]['amount']}",
              style: CustomTextStyles(context).smallerStyle.copyWith(
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
                  ? "₱ ${addCommaToPrice(double.parse(userData['transactions'][index]['resulting_balance']))}"
                  : "₱ •••••",
                  style: CustomTextStyles(context).currencyStyle.copyWith(
                    fontSize: CustomTextStyles(context).smallStyle.fontSize,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                Text(
                  DateFormat('MMM d, y H:m').format(DateTime.parse(userData['transactions'][index]['datetime'])),
                  style: CustomTextStyles(context).smallerStyle.copyWith(
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