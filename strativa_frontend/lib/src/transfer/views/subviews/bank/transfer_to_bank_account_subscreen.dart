import 'package:flutter/material.dart';
import 'account_details.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';

class TransferToBankAccountSubscreen extends StatefulWidget {
  const TransferToBankAccountSubscreen({super.key});

  @override
  State<TransferToBankAccountSubscreen> createState() =>
      _TransferToAccountSubscreenState();
}

class Account {
  final String type;
  final String number;
  final String balance;

  Account({required this.type, required this.number, required this.balance});
}

class _TransferToAccountSubscreenState
    extends State<TransferToBankAccountSubscreen> {
  Account? selectedFromAccount;
  String? selectedBank;
  String? selectedAccountNumber;
  String? selectedAccountName;

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

  void _showAccountSelector(BuildContext context) {
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
                  const Row(
                    children: [
                      Icon(
                        Icons.account_balance_wallet_rounded,
                        color: Colors.orange,
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Transfer from',
                        style: TextStyle(
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
              const Divider(),
              ...accounts.map((account) {
                return _AccountTile(
                  title: account.type,
                  accountNumber: account.number,
                  balance: account.balance,
                  onTap: () {
                    setState(() {
                      selectedFromAccount = account;
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

  void _showBankSelector(BuildContext context) {
    final List<String> banks = [
      'BANCO DE ORO',
      'BANK OF THE PHILIPPINE ISLANDS',
      'BNP PARIBAS',
      'CHINA BANK',
      'CIMB BANK PH',
      'CITIBANK',
      'HSBC',
      'JPMORGAN',
      'LANDBANK',
      'METROBANK',
      'PHILIPPINE NATIONAL BANK',
      'RIZAL COMMERCIAL BANKING CORPORATION',
    ];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        TextEditingController searchController = TextEditingController();
        List<String> filteredBanks = List.from(banks);

        return StatefulBuilder(
          builder: (context, setModalState) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.account_balance, color: Colors.teal),
                      SizedBox(width: 8),
                      Text(
                        'Select Bank',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Spacer(),
                      CloseButton(),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: searchController,
                    onChanged: (query) {
                      setModalState(() {
                        filteredBanks =
                            banks
                                .where(
                                  (bank) => bank.toLowerCase().contains(
                                    query.toLowerCase(),
                                  ),
                                )
                                .toList();
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Search for a bank',
                      filled: true,
                      fillColor: Colors.grey[200],
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Flexible(
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemCount: filteredBanks.length,
                      separatorBuilder: (_, __) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(filteredBanks[index]),
                          onTap: () async {
                            Navigator.pop(context);
                            final result = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (_) => AccountDetails(
                                      bank: filteredBanks[index],
                                    ),
                              ),
                            );

                            if (result != null) {
                              setState(() {
                                selectedBank = result['bank'];
                                selectedAccountNumber = result['accountNumber'];
                                selectedAccountName = result['accountName'];
                              });
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.teal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transfer to another bank',
          style: TextStyle(fontSize: 16),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
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
              onTap: () => _showAccountSelector(context),
            ),
            const SizedBox(height: 12),
            _TransferTile(
              label: 'Transfer to',
              title:
                  selectedBank != null
                      ? '$selectedBank - $selectedAccountName'
                      : 'Select bank',
              subtitle:
                  selectedAccountNumber != null
                      ? 'Account #: $selectedAccountNumber'
                      : null,
              onTap: () => _showBankSelector(context),
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
            const SizedBox(height: 20),
            const Row(
              children: [
                Icon(Icons.info_outline, color: Colors.orange, size: 18),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'A PHP 25.00 transfer fee shall be deducted in your account.',
                    style: TextStyle(fontSize: 13, color: Colors.black87),
                  ),
                ),
              ],
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
                  if (selectedFromAccount == null) {
                    _showMessage(
                      context,
                      "Please select an account to transfer from.",
                    );
                    return;
                  }

                  if (selectedBank == null ||
                      selectedAccountNumber == null ||
                      selectedAccountName == null) {
                    _showMessage(
                      context,
                      "Please complete bank and account details.",
                    );
                    return;
                  }

                  _showMessage(
                    context,
                    "Transfer info saved:\nFrom: ${selectedFromAccount!.type}\n"
                    "To: $selectedAccountName ($selectedAccountNumber) at $selectedBank",
                  );
                  context.push(AppRoutes.kReviewTransferBankAccount);
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
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios_rounded, size: 16),
              ],
            ),
            if (subtitle != null) ...[
              const SizedBox(height: 4),
              Text(subtitle!, style: const TextStyle(fontSize: 14)),
            ],
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
