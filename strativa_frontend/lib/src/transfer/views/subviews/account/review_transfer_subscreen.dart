import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_edit_button.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_info_card.dart';
import 'package:strativa_frontend/common/widgets/app_confirm_button.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/common/widgets/otp/widgets/app_otp_modal_bottom_sheet.dart';
import 'package:strativa_frontend/src/transfer/models/transfer_model.dart';

class ReviewTransferSubscreen extends StatelessWidget {
  const ReviewTransferSubscreen({
    required this.fromAccount,
    required this.toAccount,
    required this.amount,
    this.note,
    super.key
  });

  final UserAccount fromAccount;
  final UserAccount toAccount;
  final String amount;
  final String? note;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          AppText.kReviewTitle,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Are these details\ncorrect?',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        height: 1.6,
                      ),
                    ),
                  ),
                  EditButton(onTap: () {
                    context.pop();
                  }),
                ],
              ),
              const SizedBox(height: 40),

              // Transfer From
              TransferInfoCard(
                label: AppText.kTransferFrom,
                iconPath: "assets/icons/transfer_from_icon.svg",
                accountType: fromAccount.accountType.accountType,
                accountNumber: fromAccount.accountNumber,
              ),
              const SizedBox(height: 20),

              // Transfer To
              TransferInfoCard(
                label: AppText.kTransferTo,
                iconPath: "assets/icons/transfer_to_icon.svg",
                accountType: toAccount.accountType.accountType,
                accountNumber: toAccount.accountNumber,
                note: note,
              ),
              const SizedBox(height: 32),

              // Summary full-width
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(
                  horizontal: 0,
                ), // override padding
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      BorderRadius.zero, // removes any visible corners
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 24,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      AppText.kSummary,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildAmountRow(AppText.kTransferAmount, amount),
                    const Divider(
                      color: ColorsCommon.kGray, // pulled from kcolors.dart
                      thickness: 1,
                      height: 24,
                    ),
                    _buildAmountRow(AppText.kTotal, amount),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              Align(
                alignment: Alignment.center,
                child: ConfirmButton(
                  onTap: () async {
                    TransferModel model = TransferModel(
                      transactionDetails: TransactionDetails(
                        transactionType: TransactionTypes.transfers.name, 
                        amount: amount, 
                        note: note ?? "", 
                        sender: User(
                          accountNumber: fromAccount.accountNumber,
                          bank: fromAccount.bank.bankName
                        ), 
                        receiver: User(
                          accountNumber: toAccount.accountNumber,
                          bank: toAccount.bank.bankName
                        )
                      )
                    );
                    String data = transferModelToJson(model);

                    int? statusCode = await showAppOtpModalBottomSheet(
                      context: context,
                      initialValue: fromAccount.accountNumber,
                      sendOtp: true,
                      transactionDetails: data,
                      enabled: false
                    );

                    if (statusCode == 200) {
                      if (context.mounted) {
                        context.push(
                          AppRoutes.kSuccessTransfer,
                          extra: {
                            "fromAccountType": fromAccount.accountType.accountType,
                            "fromAccountNumber": fromAccount.accountNumber,
                            "toAccountType": toAccount.accountType.accountType,
                            "toAccountNumber": toAccount.accountNumber,
                            "amount": amount,
                            "note": note
                          }
                        );
                      }
                    }
                  },
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAmountRow(String label, String amountStr) {
    final cleanedAmountStr = amountStr.replaceAll(',', '');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(fontSize: 14, height: 1.5)),
        AppAmountWidget(amount: cleanedAmountStr),
      ],
    );
  }
}
