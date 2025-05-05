import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';

class TransferToStrativaAccountSubscreen extends StatefulWidget {
  const TransferToStrativaAccountSubscreen({super.key});

  @override
  State<TransferToStrativaAccountSubscreen> createState() =>
      _TransferToAccountSubscreenState();
}

class Account {
  final String type;
  final String number;
  final String balance;

  Account({required this.type, required this.number, required this.balance});
}

class _TransferToAccountSubscreenState
    extends State<TransferToStrativaAccountSubscreen> {
  Account? selectedFromAccount;
  Account? selectedToAccount;

  final List<Account> accounts = [
    Account(type: 'SAVINGS ACCOUNT', number: '0637892064', balance: '2,678.00'),
    Account(
      type: 'CHECKING ACCOUNT',
      number: '0928374258',
      balance: '70,200.00',
    ),
    Account(
      type: 'TIME DEPOSIT ACCOUNT',
      number: '083654926',
      balance: '6,758.00',
    ),
  ];

  void _showAccountSelector(BuildContext context, bool isFrom) {
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
                  title: account.type,
                  accountNumber: account.number,
                  balance: account.balance,
                  onTap: () {
                    setState(() {
                      if (isFrom) {
                        selectedFromAccount = account;
                      } else {
                        selectedToAccount = account;
                      }
                    });
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
              title: selectedFromAccount?.type ?? 'Select account',
              subtitle:
                  selectedFromAccount != null
                      ? '•••${selectedFromAccount!.number.substring(selectedFromAccount!.number.length - 4)} • PHP ${selectedFromAccount!.balance}'
                      : null,
              onTap: () => _showAccountSelector(context, true),
            ),
            const SizedBox(height: 12),
            _TransferTile(
              label: 'Transfer to',
              title: selectedToAccount?.type ?? 'Select account',
              subtitle:
                  selectedToAccount != null
                      ? '•••${selectedToAccount!.number.substring(selectedToAccount!.number.length - 4)} • PHP ${selectedToAccount!.balance}'
                      : null,
              onTap: () => _showAccountSelector(context, false),
            ),
            const SizedBox(height: 24),
            const Text(
              'Transfer amount',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: const [
                  Text('PHP', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: '0.00',
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200],
                hintText: 'Add Note (optional)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal[300],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  context.push(AppRoutes.kReviewTransferStrativaAccount);
                },
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
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
