import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/app_theme/custom_text_styles.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kconstants.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/temp_model.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';
import 'package:strativa_frontend/common/widgets/app_snack_bar_widget.dart';
import 'package:strativa_frontend/common/widgets/app_text_button_widget.dart';
import 'package:strativa_frontend/src/qr/controllers/generate_qr_account_modal_notifier.dart';
import 'package:strativa_frontend/src/qr/widgets/accounts_modal_bottom_sheet_widget.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_labeled_amount_note_field_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive_widget.dart';

class GenerateQrSubscreen extends StatefulWidget {
  const GenerateQrSubscreen({super.key});

  @override
  State<GenerateQrSubscreen> createState() => _GenerateQrSubscreenState();
}

class _GenerateQrSubscreenState extends State<GenerateQrSubscreen> {
  late final TextEditingController _amountController = TextEditingController();
  final _formKey = AppGlobalKeys.generateQrFormKey;
  GenerateQrAccountModalNotifier? notifier;


  @override
  void initState() {
    notifier = Provider.of<GenerateQrAccountModalNotifier>(context, listen: false);
    notifier!.setAmountController = _amountController;

    super.initState();
  }

  @override
  void dispose() {
    notifier!.setWidgetIsBeingDisposed = true;
    notifier!.setAccount = null;
    notifier!.setAmountController = null;
    _amountController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GenerateQrAccountModalNotifier>(
      builder: (context, accountModalNotifier, child) {
        // TODO: change type once model is done
        dynamic account = accountModalNotifier.getAccount;

        return Padding(
          padding: AppConstants.kAppPadding,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // TODO: pass model to this widget
                AppTransferReceiveWidget(
                  onTap: () {
                    showAccountsModalBottomSheet(
                      context: context,
                      type: AppTransferReceiveWidgetTypes.otheraccounts.name,
                      toTitle: AppText.kDepositTo,
                      // TODO: change once model is done
                      accounts: myAccounts
                    );
                  },
                  title: AppText.kDepositTo,
                  bottomWidget: account != null
                    ? SizedBox(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            account['type'].toUpperCase(),
                            style: CustomTextStyles(context).bigStyle.copyWith(
                              fontWeight: FontWeight.w900,
                            ),
                          ),
            
                          SizedBox(height: 5),
            
                          Text(
                            account['account_number'],
                          ),
            
                          AppAmountWidget(
                            amount: account['balance'],
                          ),
                        ],
                      )
                    )
                    : null
                ),
                    
                SizedBox(height: 20.h),
                
                accountModalNotifier.getSpecifyAmount == false
                  ? AppTextButtonWidget(
                    onPressed: () {
                      accountModalNotifier.setSpecifyAmount = true;
                    },
                    text: AppText.kSpecifyAmountPlus,
                    overlayColor: ColorsCommon.kAccentL4,
                    style: CustomTextStyles(context).defaultStyle.copyWith(
                      color: ColorsCommon.kAccentL3
                    ),
                  )
                  : AppTextButtonWidget(
                    onPressed: () {
                      accountModalNotifier.setSpecifyAmount = false;
                      accountModalNotifier.getAmountController.clear();
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
                          accountModalNotifier.getSpecifyAmount == false
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
                                  appSnackBarWidget(
                                    context: context, 
                                    text: AppText.kPleaseSelectAnAccountToDepositTo,
                                    icon: AppIcons.kErrorIcon,
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
}