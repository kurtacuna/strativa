import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_error_snack_bar_widget.dart';
import 'package:strativa_frontend/common/widgets/app_text_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/controllers/app_transfer_receive_widget_notifier.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/widgets/app_transfer_receive_bottom_widget.dart';
import 'package:strativa_frontend/src/qr/controllers/generate_qr_notifier.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/widgets/accounts_modal_bottom_sheet_widget.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_labeled_amount_note_field_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/widgets/app_transfer_receive_widget.dart';

class GenerateQrSubscreen extends StatefulWidget {
  const GenerateQrSubscreen({super.key});

  @override
  State<GenerateQrSubscreen> createState() => _GenerateQrSubscreenState();
}

class _GenerateQrSubscreenState extends State<GenerateQrSubscreen> {
  late final TextEditingController _amountController = TextEditingController();
  final _formKey = AppGlobalKeys.generateQrFormKey;
  AppTransferReceiveWidgetNotifier? appTransferReceiveWidgetNotifier;
  GenerateQrNotifier? generateQrNotifier;


  @override
  void initState() {
    appTransferReceiveWidgetNotifier = Provider.of<AppTransferReceiveWidgetNotifier>(context, listen: false);
    generateQrNotifier = Provider.of<GenerateQrNotifier>(context, listen: false);
    generateQrNotifier!.setAmountController = _amountController;

    super.initState();
  }

  @override
  void dispose() {
    appTransferReceiveWidgetNotifier!.setWidgetIsBeingDisposed = true;
    appTransferReceiveWidgetNotifier!.setAccount = null;
    generateQrNotifier!.setAmountController = null;
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateQrNotifier>(
      builder: (context, generateQrNotifier, child) {
        return Consumer<AppTransferReceiveWidgetNotifier>(
          builder: (context, appTransferReceiveWidgetNotifier, child) {
            UserAccount? account = appTransferReceiveWidgetNotifier.getAccount;

            return Padding(
              padding: AppConstants.kAppPadding,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    AppTransferReceiveWidget(
                      onTap: () {
                        showAccountsModalBottomSheet(
                          context: context,
                          type: AppTransferReceiveWidgetTypes.otheraccounts.name,
                          toTitle: AppText.kDepositTo,
                        );
                      },
                      title: AppText.kDepositTo,
                      bottomWidget: account != null
                        ? AppTransferReceiveBottomWidget(account: account)
                        : null
                    ),
                        
                    SizedBox(height: 20.h),
                    
                    // Specify Amount
                    generateQrNotifier.getSpecifyAmount == false
                      ? AppTextButtonWidget(
                        onPressed: () {
                          generateQrNotifier.setSpecifyAmount = true;
                        },
                        text: AppText.kSpecifyAmountPlus,
                        overlayColor: ColorsCommon.kAccentL4,
                        style: CustomTextStyles(context).defaultStyle.copyWith(
                          color: ColorsCommon.kAccentL3
                        ),
                      )
                      : AppTextButtonWidget(
                        onPressed: () {
                          generateQrNotifier.setSpecifyAmount = false;
                          generateQrNotifier.getAmountController.clear();
                        },
                        text: AppText.kSpecifyAmountMinus,
                        overlayColor: ColorsCommon.kAccentL4,
                        style: CustomTextStyles(context).defaultStyle.copyWith(
                          color: ColorsCommon.kAccentL3
                        )
                      ),
                    
                    SizedBox(
                      child: Form(
                        key: _formKey,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              generateQrNotifier.getSpecifyAmount == false
                                ? Container()
                                : AppLabeledAmountNoteFieldWidget(
                                  text: AppText.kRequestTheAmountOf,
                                  amountController: _amountController,
                                  addNote: false,
                                ),
                              
                                  
                              SizedBox(height: 40.h),
                              
                              // Generate QR Code Button
                              AppButtonWidget(
                                onTap: () {
                                  if (account != null) {
                                    if (_formKey.currentState!.validate()) {
                                      context.push(AppRoutes.kGeneratedQrSubscreen);
                                    }
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      appErrorSnackBarWidget(
                                        context: context, 
                                        text: AppText.kPleaseSelectAnAccountToDepositTo,
                                      )
                                    );
                                  }
                                },
                                text: AppText.kGenerateQrCode,
                              )
                            ]
                          ),
                        ),
                      ),
                    )
                  ]
                ),
              ),
            );
          }
        );
      }
    );
  }
}