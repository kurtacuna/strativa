import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart'; // Import your routes

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.kReviewTransfer);
              },
              child: const Text("Go to Review Transfer"),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.kReviewTransferStrativaAccount);
              },
              child: const Text("Go to Strativa Account Review"),
            ),
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.kReviewTransferBankAccount);
              },
              child: const Text("Go to Tranfer Bank Account Review"),
            ),
          ],
        ),
      ),
    );
  }
}
