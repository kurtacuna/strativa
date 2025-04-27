import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_edit_button.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_info_card.dart';
import 'package:strativa_frontend/common/widgets/app_confirm_button.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';

class ReviewTransferSubscreen extends StatelessWidget {
  const ReviewTransferSubscreen({super.key});

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
                  EditButton(onTap: () {}),
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

              // Transfer To
              const TransferInfoCard(
                label: AppText.kTransferTo,
                iconPath: "assets/icons/transfer_to_icon.svg",
                accountType: AppText.kTimeDepositAccount,
                accountNumber: "083654926",
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
                    _buildAmountRow(AppText.kTransferAmount, "1,000.00"),
                    const Divider(
                      color: ColorsCommon.kGray, // pulled from kcolors.dart
                      thickness: 1,
                      height: 24,
                    ),
                    _buildAmountRow(AppText.kTotal, "1,000.00"),
                  ],
                ),
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
