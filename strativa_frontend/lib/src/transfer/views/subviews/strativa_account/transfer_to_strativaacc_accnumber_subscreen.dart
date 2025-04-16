import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/widgets/app_confirm_button.dart';
import 'package:strativa_frontend/common/widgets/app_account_number_input_field.dart';

class TransferToStrativaaccAccnumberSubscreen extends StatefulWidget {
  const TransferToStrativaaccAccnumberSubscreen({super.key});

  @override
  State<TransferToStrativaaccAccnumberSubscreen> createState() =>
      _TransferToStrativaaccAccnumberSubscreenState();
}

class _TransferToStrativaaccAccnumberSubscreenState
    extends State<TransferToStrativaaccAccnumberSubscreen> {
  final TextEditingController _accountNumberController =
      TextEditingController();

  @override
  void dispose() {
    _accountNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: true,
        title: const Text(
          AppText.kTransferToAnotherStrativaAcc,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            AppAccountNumberInputField(controller: _accountNumberController),
            const Spacer(),
            ConfirmButton(
              onTap: () {
                debugPrint("Account Number: ${_accountNumberController.text}");
                // TODO: Add navigation or logic here
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
