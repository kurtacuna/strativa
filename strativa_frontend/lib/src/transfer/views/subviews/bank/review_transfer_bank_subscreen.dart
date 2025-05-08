import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_edit_button.dart';
import 'package:strativa_frontend/common/widgets/app_confirm_button.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_info_card.dart';
import 'package:strativa_frontend/common/widgets/transfer_summary_with_fee.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';

class ReviewTransferBankSubscreen extends StatelessWidget {
  const ReviewTransferBankSubscreen({super.key});

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
              const TransferInfoCard(
                label: AppText.kTransferFrom,
                iconPath: "assets/icons/transfer_from_icon.svg",
                accountType: AppText.kSavingsAccount,
                accountNumber: "0637892064",
              ),

              const SizedBox(height: 20),

              const TransferInfoCard(
                label: AppText.kTransferTo,
                iconPath: "assets/icons/transfer_to_icon.svg",
                accountType: "Chinabank",
                accountNumber: "083654926",
              ),

              const SizedBox(height: 32),

              const TransferSummaryWithFee(
                transferAmount: "1,000.00",
                // TODO: change
                transferFees: [],
                total: "1,025.00",
              ),

              const SizedBox(height: 60),

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
      ),
    );
  }
}
