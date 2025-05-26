import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/utils/amount.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/src/transfer/controllers/transfer_notifier.dart';
import 'package:strativa_frontend/src/transfer/models/check_if_other_bank_account_exists_model.dart';

class AccountDetails extends StatefulWidget {
  final String bank;
  final double totalFee;

  const AccountDetails({
    super.key, 
    required this.bank,
    this.totalFee = 0
  });

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  final TextEditingController accountNumberController = TextEditingController();
  final TextEditingController accountNameController = TextEditingController();

  late TransferNotifier transferNotifier;

  @override
  void initState() {
    transferNotifier = Provider.of<TransferNotifier>(
      context,
      listen: false
    );

    super.initState();
  }

  _handleContinue(BuildContext context) async {
    final accountNumber = accountNumberController.text.trim();
    final accountName = accountNameController.text.trim();

    if (accountNumber.isEmpty || accountName.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill in all fields."),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    CheckIfOtherBankAccountExistsModel model = CheckIfOtherBankAccountExistsModel(
      otherBankAccountDetails: OtherBankAccountDetails(
        bank: widget.bank, 
        accountNumber: accountNumber,
        fullName: accountName
      )
    );
    String data = checkIfOtherBankAccountExistsModelToJson(model);

    await transferNotifier.checkIfOtherBankAccountExists(
      context, 
      data
    );

    if (transferNotifier.getStatusCode == 200) {
      if (context.mounted) {
        Navigator.pop(context, {
          'bank': widget.bank,
          'accountNumber': accountNumber,
          'accountName': accountName,
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer to another bank', style: TextStyle(fontSize: 16)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: transferNotifier.getIsLoading
        ? Center(
            child: AppCircularProgressIndicatorWidget()
          )
        : SafeArea(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Fill in account details",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
          
                  Text("Bank", style: TextStyle(color: Colors.grey[600])),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF0F6F7),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(widget.bank, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
          
                  const SizedBox(height: 20),
                  TextField(
                    controller: accountNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Account Number',
                      filled: true,
                      fillColor: const Color(0xFFF0F6F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
          
                  const SizedBox(height: 20),
                  TextField(
                    controller: accountNameController,
                    decoration: InputDecoration(
                      labelText: 'Account Name',
                      filled: true,
                      fillColor: const Color(0xFFF0F6F7),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
          
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(Icons.info_outline, size: 18, color: Colors.orange),
                      SizedBox(width: 6),
                      widget.totalFee != 0
                        ? Expanded(
                            child: Text(
                              'A total of PHP ${addCommaToAmount(widget.totalFee)} transfer fee shall be deducted from your account.',
                              style: TextStyle(color: Colors.orange, fontSize: 12),
                            ),
                          )
                        : Container()
                    ],
                  ),
          
                  const Spacer(),
          
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _handleContinue(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF58D1CB),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Continue", style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
        ),
    );
  }
}
