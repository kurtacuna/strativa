import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/common/widgets/app_edit_button.dart';
import 'package:strativa_frontend/common/widgets/app_confirm_button.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_info_card.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/common/widgets/otp/widgets/app_otp_modal_bottom_sheet.dart';
import 'package:strativa_frontend/common/widgets/transfer_info_masked_card.dart';
import 'package:strativa_frontend/common/widgets/transfer_summary_with_fee.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/src/transfer/controllers/transfer_notifier.dart';
import 'package:strativa_frontend/src/transfer/models/check_if_account_exists_model.dart';
import 'package:strativa_frontend/src/transfer/models/transfer_model.dart';

class ReviewTransferStrativaaccSubscreen extends StatelessWidget {
  const ReviewTransferStrativaaccSubscreen({
    required this.fromAccount,
    required this.toAccount,
    required this.amount,
    this.note,
    super.key
  });

  final UserAccount fromAccount;
  final CheckedAccountModel toAccount;
  final String amount;
  final String? note;

  @override
  Widget build(BuildContext context) {


    if (context.watch<TransferNotifier>().getIsLoading) {
      return Center(
        child: AppCircularProgressIndicatorWidget()
      );
    }

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
      body: Consumer<TransferNotifier>(
        builder:(context, transferNotifier, child) {
          if (transferNotifier.getIsLoading) {
            return Center(
              child: AppCircularProgressIndicatorWidget()  
            );
          }
          
          return SingleChildScrollView(
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
                          AppText.kAreTheseDetailsCorrect,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            height: 1.6,
                          ),
                        ),
                      ),
                      EditButton(
                        onTap: () {
                          context.pop();
                        },
                      ),
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

                  // Transfer To (masked)
                  TransferInfoMaskedCard(
                    label: AppText.kTransferTo,
                    iconPath: "assets/icons/transfer_to_icon.svg",
                    accountType: toAccount.accountType.accountType,
                    accountNumber: toAccount.accountNumber,
                  ),

                  const SizedBox(height: 32),

                  // Summary with Fee
                  TransferSummaryWithFee(
                    transferAmount: amount,
                    transactionFees: [],
                    total: amount
                  ),

                  const SizedBox(height: 60),

                  // Confirm Button
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
          );
        },
      )
    );
  }
}
