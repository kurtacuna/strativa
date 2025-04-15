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
import 'package:strativa_frontend/src/qr/controllers/account_modal_notifier.dart';
import 'package:strativa_frontend/src/qr/widgets/generated_qr_details_widget.dart';

class GeneratedQrSubscreen extends StatelessWidget {
  const GeneratedQrSubscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AccountModalNotifier>(
      builder: (context, accountModalNotifier, child) {
        // TODO: change type once model is done
        dynamic account = accountModalNotifier.getAccount;

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
                // TODO: change data once backend is done
                GeneratedQrDetailsWidget(
                  type: account['type'],
                  accountNumber: account['account_number'],
                  amountRequested: accountModalNotifier.getAmountController.text,
                ),
        
                SizedBox(height: 70.h),
        
                AppButtonWidget(
                  onTap: () {
                    accountModalNotifier.getAmountController.clear();
                    accountModalNotifier.setAmountController = null;
                    Navigator.of(context).pop();
                  },
                  text: AppText.kGenerateNewQrCode,
                ),
        
                SizedBox(height: 5.h),
        
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