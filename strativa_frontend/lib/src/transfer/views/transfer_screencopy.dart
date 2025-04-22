// placeholder file. galing kay zoren. yung transfer_screen.dart ang final

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class TransferScreen extends StatelessWidget {
  const TransferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To Account')),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppButtonWidget(
              text: 'To Own Account',
              onTap: () {
                context.push(AppRoutes.kTransferToAccount);
              },
            ),
            const SizedBox(height: 16),
            AppButtonWidget(
              text: 'To Strativa Account',
              onTap: () {
                context.push(AppRoutes.kTransferToStrativaAccount);
              },
            ),
            const SizedBox(height: 16),
            AppButtonWidget(
              text: 'To Bank Account',
              onTap: () {
                context.push(AppRoutes.kTransferToBankAccount);
              },
            ),
          ],
        ),
      ),
    );
  }
}
