import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/src/qr/controllers/generate_qr_account_modal_notifier.dart';
import 'package:strativa_frontend/src/qr/widgets/account_item_widget.dart';

Future<dynamic> showAccountsModalBottomSheet({
  required BuildContext context,
  required String type,
  String? fromTitle,
  String? toTitle,
  // TODO: edit type once model is done
  required List<dynamic> accounts,
}) {
  return showModalBottomSheet(
    context: context,
    builder: (context) => AccountsModalBottomSheet(
      type: type,
      fromTitle: fromTitle,
      toTitle: toTitle,
      accounts: accounts,
    )
  );
}

class AccountsModalBottomSheet extends StatefulWidget {
  const AccountsModalBottomSheet({
    required this.type,
    this.fromTitle,
    this.toTitle,
    required this.accounts,
    super.key
  });
  
  final String type;
  final String? fromTitle;
  final String? toTitle;
  // TODO: edit type once model is done
  final List<dynamic> accounts;

  @override
  State<AccountsModalBottomSheet> createState() => _AccountsModalBottomSheetState();
}

class _AccountsModalBottomSheetState extends State<AccountsModalBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: ScreenUtil().screenWidth,
        child: Padding(
          padding: AppConstants.kAppPadding,
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Builder(
                builder: (context) {
                  if (widget.type == AppTransferReceiveWidgetTypes.myaccounts.name) {
                    return Row(
                      spacing: 10,
                      children: [
                        AppIcons.kTransferFromIcon,
                        Text(
                          widget.fromTitle ?? AppText.kTransferFrom,
                          style: CustomTextStyles(context).bigStyle.copyWith(
                            fontWeight: FontWeight.w900
                          ),
                        )
                      ]
                    );
                  } else if (widget.type == AppTransferReceiveWidgetTypes.otheraccounts.name) {
                      return Row(
                        spacing: 10,
                        children: [
                          AppIcons.kTransferToIcon,
                          Text(
                            widget.toTitle ?? AppText.kTransferTo,
                            style: CustomTextStyles(context).bigStyle.copyWith(
                              fontWeight: FontWeight.w900
                            ),
                          )
                        ]
                    );
                  }

                  return Container();
                },
              ),

              SizedBox(height: 15.h),

              // Body
              Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(
                      color: ColorsCommon.kDarkGray,
                    ),
                    right: BorderSide(
                      color: ColorsCommon.kDarkGray,
                    ),
                    top: BorderSide(
                      color: ColorsCommon.kDarkGray,
                    )
                  ),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(AppConstants.kAppBorderRadius),
                    topLeft: Radius.circular(AppConstants.kAppBorderRadius),
                  )
                ),
                child: Column(
                  children: List.generate(widget.accounts.length, (index) {
                    return InkWell(
                      borderRadius: index == 0
                        ? BorderRadius.only(
                          topRight: Radius.circular(AppConstants.kAppBorderRadius),
                          topLeft: Radius.circular(AppConstants.kAppBorderRadius),
                        )
                        : null,
                      onTap: () {
                        context.read<GenerateQrAccountModalNotifier>().setAccount = widget.accounts[index];
                        Navigator.of(context).pop();
                      },
                      child: Ink (
                        child: AccountItemWidget(account: widget.accounts[index])
                      )
                    );
                  }),
                )
              )
            ],
          )
        )
      )
    );
  }
}