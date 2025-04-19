import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/controllers/app_transfer_receive_widget_notifier.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/user_data_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/models/user_data_model.dart';
import 'package:strativa_frontend/src/qr/controllers/generate_qr_notifier.dart';
import 'package:strativa_frontend/src/qr/widgets/generated_qr_details_widget.dart';

class GeneratedQrSubscreen extends StatelessWidget {
  const GeneratedQrSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    UserDataModel userAccount = context.read<UserDataNotifier>().getUserData!;

    return Consumer<GenerateQrNotifier>(
      builder: (context, accountModalNotifier, child) {
        UserAccount account = context.read<AppTransferReceiveWidgetNotifier>().getAccount;

        return Scaffold(
          appBar: AppBar(
            title: Text(
              AppText.kScanQrCodeHeader,
              style: CustomTextStyles(context).screenHeaderStyle.copyWith(
                color: ColorsCommon.kWhite,
              ),
            ),
            centerTitle: true,
            backgroundColor: ColorsCommon.kPrimaryL3,
            iconTheme: IconThemeData(
              color: ColorsCommon.kWhite,
            ),
          ),
        
          body: Padding(
            padding: EdgeInsets.only(
              top: 0,
              left: AppConstants.kAppPadding.left,
              right: AppConstants.kAppPadding.right,
            ),
            child: Column(
              children: [
                GeneratedQrDetailsWidget(
                  type: account.accountType.accountType,
                  accountNumber: account.accountNumber,
                  amountRequested: accountModalNotifier.getAmountController.text,
                  fullName: userAccount.fullName,
                ),
        
                SizedBox(height: 70.h),
        
                // Generate New QR Code Button
                AppButtonWidget(
                  onTap: () {
                    accountModalNotifier.getAmountController.clear();
                    Navigator.of(context).pop();
                  },
                  text: AppText.kGenerateNewQrCode,
                ),
        
                SizedBox(height: 5.h),

                // Go To Home Button
                AppButtonWidget(
                  onTap: () {
                    context.go(AppRoutes.kEntrypoint);
                  },
                  text: AppText.kGoToHome,
                  showBorder: true,
                  firstColor: Colors.transparent,
                  secondColor: Colors.transparent,
                  color: ColorsCommon.kPrimaryL3,
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}