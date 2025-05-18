import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_amount_widget.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/src/transfer/models/transaction_fees_model.dart';

class TransferSummaryWithFee extends StatelessWidget {
  final String transferAmount;
  final String total;
  final List<Fee> transactionFees;

  const TransferSummaryWithFee({
    super.key,
    required this.transferAmount,
    required this.total,
    required this.transactionFees
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.zero,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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
          _buildAmountRow(AppText.kTransferAmount, transferAmount),
          transactionFees.isEmpty
            ? Container()
            : Column(
                children: List.generate(transactionFees.length, (index) {
                  return _buildAmountRow(transactionFees[index].type, transactionFees[index].fee);
                })    
              ),
          const Divider(color: ColorsCommon.kGray, thickness: 1, height: 24),
          _buildAmountRow(AppText.kTotal, total),
        ],
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
