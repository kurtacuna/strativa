import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';

class PayloadScreen extends StatelessWidget {
  const PayloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push(AppRoutes.kPayloadBillsReviewSubscreen);
              },
              child: const Text("Go to Bills Review"),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
