import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/amount.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/controllers/app_transfer_receive_widget_notifier.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/widgets/accounts_modal_bottom_sheet_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/widgets/app_transfer_receive_bottom_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/widgets/app_transfer_receive_widget.dart';

class ScannedQrDetailsWidget extends StatefulWidget {
  const ScannedQrDetailsWidget({
    required this.fullName,
    required this.type,
    required this.accountNumber,
    this.amountRequested,
    super.key
  });

  final String fullName;
  final String type;
  final String accountNumber;
  final String? amountRequested;

  @override
  State<ScannedQrDetailsWidget> createState() => _ScannedQrDetailsWidgetState();
}

class _ScannedQrDetailsWidgetState extends State<ScannedQrDetailsWidget> {
  AppTransferReceiveWidgetNotifier? notifier;

  @override
  void initState() {
    notifier = Provider.of<AppTransferReceiveWidgetNotifier>(
      context,
      listen: false
    );

    super.initState();
  }

  @override
  void dispose() {
    notifier!.setWidgetIsBeingDisposed = true;
    notifier!.setFromAccount = null;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTransferReceiveWidgetNotifier>(
      builder: (context, appTransferReceiveWidgetNotifier, child) {
        UserAccount? account = appTransferReceiveWidgetNotifier.getFromAccount;

        return Container(
          width: ScreenUtil().screenWidth,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
              ? ColorsCommon.kWhiter
              : ColorsCommon.kLightDark,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(AppConstants.kAppBorderRadius),
              bottomRight: Radius.circular(AppConstants.kAppBorderRadius),
            ),
            boxShadow: Theme.of(context).brightness == Brightness.light
              ? AppConstants.kCommonBoxShadowLight
              : AppConstants.kCommonBoxShadowDark,
          ),
          child: Padding(
            padding: AppConstants.kAppPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppTransferReceiveWidget(
                  onTap: () {
                    showAccountsModalBottomSheet(
                      context: context,
                      type: AppTransferReceiveWidgetTypes.myaccounts.name,
                    );
                  },
                  title: AppText.kTransferFrom,
                  bottomWidget: account != null
                    ? AppTransferReceiveBottomWidget(
                      account: account
                    )
                    : null
                ),
                
                SizedBox(height: 40.h),
        
                Text(
                  AppText.kTransferTo,
                  style: CustomTextStyles(context).biggestStyle.copyWith(
                    fontWeight: FontWeight.w900
                  ),
                ),
        
                SizedBox(height: 20.h),
        
                Text(
                  widget.fullName.toUpperCase(),
                  style: CustomTextStyles(context).biggerStyle.copyWith(
                    color: ColorsCommon.kPrimaryL1,
                    fontWeight: FontWeight.w900
                  )
                ),
        
                SizedBox(height: 5.h),
        
                Text(
                  widget.type,
                  style: CustomTextStyles(context).bigStyle.copyWith(
                    fontWeight: FontWeight.w900,
                  )
                ),
        
                SizedBox(height: 10.h),
        
                Text(
                  widget.accountNumber,
                  style: CustomTextStyles(context).bigStyle.copyWith(
                    color: ColorsCommon.kDarkGray
                  )
                ),
        
                widget.amountRequested != ""
                  ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40.h),
        
                      Text(
                        AppText.kAmountRequested,
                        style: CustomTextStyles(context).defaultStyle.copyWith(
                          color: ColorsCommon.kDarkGray,
                        ),
                      ),
          
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          AppAmountWidget(
                            amount: removeCommaFromAmount(widget.amountRequested!),
                          ),
                        ]
                      ),
                    ]
                  )
                  : Container()
              ]
            )
          )
        );
      }
    );
  }
}