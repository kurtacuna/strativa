import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/check_transfer_details.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/widgets/app_labeled_amount_note_field_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/controllers/app_transfer_receive_widget_notifier.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/src/transfer/controllers/transfer_notifier.dart';

class TransferToStrativaAccountSubscreen extends StatefulWidget {
  const TransferToStrativaAccountSubscreen({super.key});

  @override
  State<TransferToStrativaAccountSubscreen> createState() =>
      _TransferToAccountSubscreenState();
}

class _TransferToAccountSubscreenState
    extends State<TransferToStrativaAccountSubscreen> {
  UserAccount? selectedFromAccount;
  UserAccount? selectedToAccount;

  late final GlobalKey<FormState> _formKey = AppGlobalKeys.transferToAnotherStrativaAccountKey;
  late final TextEditingController _amountController = TextEditingController();
  late final TextEditingController _noteController = TextEditingController();

  late final AppTransferReceiveWidgetNotifier appTransferReceiveWidgetNotifier;
  late final TransferNotifier transferNotifier;

  @override
  void initState() {
    appTransferReceiveWidgetNotifier = Provider.of<AppTransferReceiveWidgetNotifier>(
      context,
      listen: false
    );

    transferNotifier = Provider.of<TransferNotifier>(
      context,
      listen: false
    );

    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();

    // Clear from and to accounts in AppTransferReceiveWidgetNotifier
    appTransferReceiveWidgetNotifier.setWidgetIsBeingDisposed = true;
    appTransferReceiveWidgetNotifier.setFromAccount = null;
    appTransferReceiveWidgetNotifier.setWidgetIsBeingDisposed = true;
    appTransferReceiveWidgetNotifier.setToAccount = null;

    // Clear checked account in TansferNotifier
    transferNotifier.setWidgetIsBeingDisposed = true;
    transferNotifier.setCheckedAccount = null;

    super.dispose();
  }

  void _showAccountSelector(BuildContext context, bool isFrom) {
    List<UserAccount> accounts = context.read<AppTransferReceiveWidgetNotifier>().getAccountsList;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        isFrom
                            ? Icons.account_balance_wallet_rounded
                            : Icons.swap_horiz_rounded,
                        color: Colors.orange,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        isFrom ? 'Transfer from' : 'Transfer to',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Divider(),
              ...accounts.map((account) {
                return _AccountTile(
                  title: account.accountType.accountType,
                  accountNumber: account.accountNumber,
                  balance: account.balance,
                  onTap: () {
                    setState(() {
                      if (isFrom) {
                        selectedFromAccount = account;
                        context.read<AppTransferReceiveWidgetNotifier>().setFromAccount = account;
                      }
                    });
                    Navigator.pop(context);
                  },
                );
              })
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    selectedToAccount = context.watch<TransferNotifier>().getCheckedAccount;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Transfer to strativa account',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _TransferTile(
              label: 'Transfer from',
              title: selectedFromAccount?.accountType.accountType ?? 'Select account',
              subtitle:
                  selectedFromAccount != null
                      ? '•••${selectedFromAccount!.accountNumber.substring(selectedFromAccount!.accountNumber.length - 4)} • PHP ${selectedFromAccount!.balance}'
                      : null,
              onTap: () => _showAccountSelector(context, true),
            ),
            const SizedBox(height: 12),
            _TransferTile(
              label: 'Transfer to',
              title: selectedToAccount?.accountType.accountType ?? 'Select account',
              subtitle:
                  selectedToAccount != null
                      ? '•••${selectedToAccount!.accountNumber.substring(selectedToAccount!.accountNumber.length - 4)} • PHP ${selectedToAccount!.balance}'
                      : null,
              onTap: () {
                context.push(AppRoutes.kTransferToAnotherStrativaAccNumber);
              },
            ),
            const SizedBox(height: 24),
            Form(
              key: _formKey,
              child: AppLabeledAmountNoteFieldWidget(
                text: AppText.kTransferAmount, 
                amountController: _amountController,
                addNote: true,
                addNoteController: _noteController,
              ),
            ),
            const Spacer(),
            AppButtonWidget(
              onTap: () {
                int statusCode = checkTransferDetails(
                  context: context, 
                  fromAccount: selectedFromAccount, 
                  toAccount: selectedToAccount, 
                  amount: _amountController.text, 
                  formKey: _formKey
                );
                // Fail
                if (statusCode == -1) {
                  return;
                }

                context.push(
                  AppRoutes.kReviewTransferStrativaAccount,
                  extra: {
                    "fromAccount": selectedFromAccount,
                    "toAccount": selectedToAccount,
                    "amount": _amountController.text,
                    "note": _noteController.text
                  }
                );
              }, 
              text: 'Continue'
            )
          ],
        ),
      ),
    );
  }
}

class _TransferTile extends StatelessWidget {
  final String label;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _TransferTile({
    required this.label,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    if (subtitle != null)
                      Text(subtitle!, style: const TextStyle(fontSize: 14)),
                  ],
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AccountTile extends StatelessWidget {
  final String title;
  final String accountNumber;
  final String balance;
  final VoidCallback onTap;

  const _AccountTile({
    required this.title,
    required this.accountNumber,
    required this.balance,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
      subtitle: Text(accountNumber),
      trailing: Text('PHP $balance'),
      onTap: onTap,
    );
  }
}