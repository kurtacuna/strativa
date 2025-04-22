import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/amount.dart';
import 'package:strativa_frontend/common/utils/date.dart';
import 'package:strativa_frontend/common/utils/input_formatters.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/controllers/app_transfer_receive_widget_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/balance_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/user_data_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/widgets/card_widget.dart';

class DetailedCardWidget extends StatelessWidget {
  const DetailedCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BalanceNotifier> (
      builder: (context, balanceNotifier, child) {
        var userCardDetails = context.read<UserDataNotifier>().getUserData!.userCardDetails;

        return Stack(
          children: [
            const CardWidget(shadow: true),
            Padding(
              padding: AppConstants.kCardPadding,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppText.kCardBalance,
                    style: CustomTextStyles(context).defaultStyle.copyWith(
                      color: ColorsCommon.kWhite,
                      fontWeight: FontWeight.w900,
                    )
                  ),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        balanceNotifier.getShowBalance
                          ? "${AppText.kCurrencySign} ${addCommaToAmount(
                            double.parse(context.read<AppTransferReceiveWidgetNotifier>()
                              .getAccountsList
                              .where((account) => account.accountType.accountType == "Card/Wallet")
                              .first
                              .balance)
                          )}"
                          : "${AppText.kCurrencySign} •••••",
                          style: CustomTextStyles(context).numberStyle.copyWith(
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
                      ? formatCardNumber(userCardDetails.strativaCardNumber)
                      : "•••• •••• •••• ••••",
                      style: CustomTextStyles(context).defaultStyle.copyWith(
                        wordSpacing: 5,
                        color: ColorsCommon.kWhite,
                        fontWeight: FontWeight.w900,
                      ),
                  ),
        
                  Text(
                    balanceNotifier.getShowBalance
                      ? getCardExpiry(userCardDetails.strativaCardExpiry)
                      : "••••",
                      style: CustomTextStyles(context).defaultStyle.copyWith(
                        color: ColorsCommon.kWhite,
                      ),
                  ),
                ],
              ),
            ),
          ],
        );
      }
    );
  }
}