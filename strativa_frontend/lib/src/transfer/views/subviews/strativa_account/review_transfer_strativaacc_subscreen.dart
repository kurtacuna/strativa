import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/common/widgets/app_edit_button.dart';
import 'package:strativa_frontend/common/widgets/app_confirm_button.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_info_card.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/common/widgets/transfer_info_masked_card.dart';
import 'package:strativa_frontend/common/widgets/transfer_summary_with_fee.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/src/transfer/controllers/transfer_notifier.dart';
import 'package:strativa_frontend/src/transfer/models/transfer_fees_model.dart';

class ReviewTransferStrativaaccSubscreen extends StatefulWidget {
  const ReviewTransferStrativaaccSubscreen({
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
  State<ReviewTransferStrativaaccSubscreen> createState() => _ReviewTransferStrativaaccSubscreenState();
}

class _ReviewTransferStrativaaccSubscreenState extends State<ReviewTransferStrativaaccSubscreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransferNotifier>().fetchTransferFees(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final List<Fee> transferFees = context.read<TransferNotifier>().getTransferFees ?? [];
    double totalFee = 0 + double.parse(widget.amount);
    for (int i = 0; i < transferFees.length; i++) {
      totalFee += double.parse(transferFees[i].fee);
    }

    // TODO: HEEEEEEEEEEEEEEEEY
    // fix the bug where transfer fees are not being added on the first initialize of the page

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
                    accountType: widget.fromAccount.accountType.accountType,
                    accountNumber: widget.fromAccount.accountNumber,
                  ),

                  const SizedBox(height: 20),

                  // Transfer To (masked)
                  TransferInfoMaskedCard(
                    label: AppText.kTransferTo,
                    iconPath: "assets/icons/transfer_to_icon.svg",
                    accountType: widget.toAccount.accountType.accountType,
                    accountNumber: widget.toAccount.accountNumber,
                  ),

                  const SizedBox(height: 32),

                  // Summary with Fee
                  TransferSummaryWithFee(
                    transferAmount: widget.amount,
                    transferFees: transferFees,
                    total: "$totalFee"
                  ),

                  const SizedBox(height: 60),

                  // Confirm Button
                  Align(
                    alignment: Alignment.center,
                    child: ConfirmButton(
                      onTap: () {
                        context.push(AppRoutes.kSuccessTransfer);
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
