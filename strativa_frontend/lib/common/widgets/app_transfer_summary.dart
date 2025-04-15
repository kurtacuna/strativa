import 'package:flutter/material.dart';

class TransferSummary extends StatelessWidget {
  final String transferAmount;
  final String total;

  const TransferSummary({
    super.key,
    required this.transferAmount,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Summary", style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        _buildRow("Transfer amount", transferAmount),
        _buildRow("Total", total),
      ],
    );
  }

  Widget _buildRow(String label, String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(
            "₱ $amount",
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}
