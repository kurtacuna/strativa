import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_edit_button.dart';
import 'package:strativa_frontend/common/widgets/app_confirm_button.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_info_card.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/common/widgets/otp/widgets/app_otp_modal_bottom_sheet.dart';
import 'package:strativa_frontend/common/widgets/transfer_summary_with_fee.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/src/transfer/controllers/transfer_notifier.dart';
import 'package:strativa_frontend/src/transfer/models/check_if_other_bank_account_exists_model.dart';
import 'package:strativa_frontend/src/transfer/models/transaction_fees_model.dart';
import 'package:strativa_frontend/src/transfer/models/transfer_model.dart';

class ReviewTransferBankSubscreen extends StatefulWidget {
  const ReviewTransferBankSubscreen({
    required this.fromAccount,
    required this.toAccount,
    required this.amount,
    this.note,
    super.key
  });

  final UserAccount fromAccount;
  final OtherBankAccountDetails toAccount;
  final String amount;
  final String? note;

  @override
  State<ReviewTransferBankSubscreen> createState() => _ReviewTransferBankSubscreenState();
}

class _ReviewTransferBankSubscreenState extends State<ReviewTransferBankSubscreen> {
  @override
  Widget build(BuildContext context) {
    final List<Fee> transactionFees = context.read<TransferNotifier>().getTransactionFees ?? [];
    double totalFee = 0 + double.parse(widget.amount);
    for (int i = 0; i < transactionFees.length; i++) {
      totalFee += double.parse(transactionFees[i].fee);
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),

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
                      // Handle edit
                    },
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Transfer From
              TransferInfoCard(
                label: AppText.kTransferFrom,
                iconPath: "assets/icons/transfer_from_icon.svg",
                accountType: widget.fromAccount.accountType.accountType,
                accountNumber: widget.fromAccount.accountNumber,
              ),

              const SizedBox(height: 20),

              TransferInfoCard(
                label: AppText.kTransferTo,
                iconPath: "assets/icons/transfer_to_icon.svg",
                accountType: widget.toAccount.bank,
                accountNumber: widget.toAccount.accountNumber,
                fullName: widget.toAccount.fullName,
              ),

              const SizedBox(height: 32),

              TransferSummaryWithFee(
                transferAmount: widget.amount,
                transactionFees: transactionFees,
                total: "$totalFee",
              ),

              const SizedBox(height: 60),

              Align(
                alignment: Alignment.center,
                child: ConfirmButton(
                  onTap: () async {
                    TransferModel model = TransferModel(
                      transactionDetails: TransactionDetails(
                        transactionType: TransactionTypes.transfers.name, 
                        amount: widget.amount, 
                        note: widget.note ?? "", 
                        sender: User(
                          accountNumber: widget.fromAccount.accountNumber,
                          bank: widget.fromAccount.bank.bankName
                        ), 
                        receiver: User(
                          accountNumber: widget.toAccount.accountNumber,
                          bank: widget.toAccount.bank
                        )
                      )
                    );
                    String data = transferModelToJson(model);

                    int? statusCode = await showAppOtpModalBottomSheet(
                      context: context,
                      initialValue: widget.fromAccount.accountNumber,
                      sendOtp: true,
                      transactionDetails: data,
                      enabled: false
                    );

                    if (statusCode == 200) {
                      if (context.mounted) {
                        context.push(
                          AppRoutes.kSuccessTransfer,
                          extra: {
                            "fromAccountType": widget.fromAccount.accountType.accountType,
                            "fromAccountNumber": widget.fromAccount.accountNumber,
                            "toAccountType": "${widget.toAccount.bank} - ${widget.toAccount.fullName}",
                            "toAccountNumber": widget.toAccount.accountNumber,
                            "amount": widget.amount,
                            "note": widget.note
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
}
