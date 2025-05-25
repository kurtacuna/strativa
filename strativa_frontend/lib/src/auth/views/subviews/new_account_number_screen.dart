import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/const/kicons.dart';

class NewAccountNumberScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const NewAccountNumberScreen({super.key, required this.userData});

  @override
  State<NewAccountNumberScreen> createState() => _NewAccountNumberScreenState();
}

class _NewAccountNumberScreenState extends State<NewAccountNumberScreen> {
  late final String _accountNumber;

  @override
  void initState() {
    super.initState();

    // 11‑digit number that starts with “30”
    final rnd = Random();
    final buffer = StringBuffer('30');
    for (int i = 0; i < 9; i++) buffer.write(rnd.nextInt(10));
    _accountNumber = buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 16),
            AppIcons.kSuccessfulIcon,
            const SizedBox(height: 32),
            const Text(
              'Fund your new account now!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'You have successfully opened an account in PHP. Your account number is:',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 14, color: Colors.black54),
            ),
            const SizedBox(height: 24),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text('Account number',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2)),
                ],
              ),
              child: SelectableText(_accountNumber,
                  style: const TextStyle(fontSize: 16)),
            ),
            const Spacer(),
            AppButtonWidget(
              text: 'Next',
              onTap: () {
                // merge previous data + account number without mutating original
                final mergedData = {
                  ...widget.userData,
                  'account_number': _accountNumber,
                };

                context.push(
                  AppRoutes.kCreatePassword,
                  extra: mergedData,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
