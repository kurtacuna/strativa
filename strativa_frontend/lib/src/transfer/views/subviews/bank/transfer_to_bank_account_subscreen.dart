import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/check_transfer_details.dart';
import 'package:strativa_frontend/common/widgets/app_circular_progress_indicator_widget.dart';
import 'package:strativa_frontend/common/widgets/app_labeled_amount_note_field_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/controllers/app_transfer_receive_widget_notifier.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/src/transfer/controllers/transfer_notifier.dart';
import 'package:strativa_frontend/src/transfer/models/check_if_other_bank_account_exists_model.dart';
import 'package:strativa_frontend/src/transfer/models/other_banks_model.dart';
import 'package:strativa_frontend/src/transfer/models/transfer_fees_model.dart';
import 'account_details.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';

class TransferToBankAccountSubscreen extends StatefulWidget {
  const TransferToBankAccountSubscreen({super.key});

  @override
  State<TransferToBankAccountSubscreen> createState() =>
      _TransferToAccountSubscreenState();
}

class _TransferToAccountSubscreenState
    extends State<TransferToBankAccountSubscreen> {
  UserAccount? selectedFromAccount;
  OtherBankAccountDetails? toOtherBankAccount;
  
  late final GlobalKey<FormState> _formKey = AppGlobalKeys.transferToAnotherBankAccountKey;
  late final TextEditingController _amountController = TextEditingController();
  late final TextEditingController _noteController = TextEditingController();

  late final AppTransferReceiveWidgetNotifier appTransferReceiveWidgetNotifier;

  Fee? transferFee;

  @override
  void initState() {
    appTransferReceiveWidgetNotifier = Provider.of<AppTransferReceiveWidgetNotifier>(
      context,
      listen: false
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TransferNotifier>().fetchOtherBanks(context);
      context.read<TransferNotifier>().fetchTransferFees(context);
    });

    super.initState();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _noteController.dispose();

    appTransferReceiveWidgetNotifier.setWidgetIsBeingDisposed = true;
    appTransferReceiveWidgetNotifier.setFromAccount = null;

    super.dispose();
  }


  void _showAccountSelector(BuildContext context) {
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
                  title: account.accountType.accountType,
                  accountNumber: account.accountNumber,
                  balance: account.balance,
                  onTap: () {
                    setState(() {
                      selectedFromAccount = account;
                      context.read<AppTransferReceiveWidgetNotifier>().setFromAccount = account;
                    });
                    Navigator.pop(context);
                  },
                );
              }),
            ],
          ),
        );
      },
    );
  }

  void _showBankSelector(BuildContext context) {
    List<OtherBanksModel> banks = context.read<TransferNotifier>().getOtherBanks ?? [];

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        TextEditingController searchController = TextEditingController();
        List<OtherBanksModel> filteredBanks = List.from(banks);

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
                                  (bank) => bank.bankName.toLowerCase().contains(
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
                    child: context.watch<TransferNotifier>().getIsLoading
                      ? Center(
                          child: AppCircularProgressIndicatorWidget()  
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          itemCount: filteredBanks.length,
                          separatorBuilder: (_, __) => const Divider(height: 1),
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Text(filteredBanks[index].bankName),
                              onTap: () async {
                                Navigator.pop(context);
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (_) => AccountDetails(
                                          bank: filteredBanks[index].bankName,
                                          transferFee: transferFee,
                                        ),
                                  ),
                                );

                                if (result != null) {
                                  setState(() {
                                    toOtherBankAccount = OtherBankAccountDetails(
                                      bank: result['bank'], 
                                      accountNumber: result['accountNumber'], 
                                      fullName: result['accountName']
                                    );
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
    List<Fee> transferFees = context.read<TransferNotifier>().getTransferFees ?? [];
    for (Fee fee in transferFees) {
      if (fee.type == "Transfer Fee") {
        transferFee = fee;
      }
    }
    
    if (context.watch<TransferNotifier>().getIsLoading) {
      return Center(
        child: AppCircularProgressIndicatorWidget()
      );
    }

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _TransferTile(
                      label: 'Transfer from',
                      title: selectedFromAccount?.accountType.accountType ?? 'Select account',
                      subtitle:
                          selectedFromAccount != null
                              ? '•••${selectedFromAccount!.accountNumber.substring(selectedFromAccount!.accountNumber.length - 4)} • PHP ${selectedFromAccount!.balance}'
                              : null,
                      onTap: () => _showAccountSelector(context),
                    ),
                    const SizedBox(height: 12),
                    _TransferTile(
                      label: 'Transfer to',
                      title:
                          toOtherBankAccount?.bank != null
                              ? '${toOtherBankAccount?.bank} - ${toOtherBankAccount?.fullName}'
                              : 'Select bank',
                      subtitle:
                          toOtherBankAccount?.accountNumber != null
                              ? 'Account #: ${toOtherBankAccount?.accountNumber}'
                              : null,
                      onTap: () => _showBankSelector(context),
                    ),
                    const SizedBox(height: 24),
                    Form(
                      key: _formKey,
                      child: AppLabeledAmountNoteFieldWidget(
                        text: AppText.kTransferAmount, 
                        amountController: _amountController,
                        addNote: true,
                        addNoteController: _noteController,
                      )
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Icon(Icons.info_outline, color: Colors.orange, size: 18),
                        SizedBox(width: 8),
                        transferFee != null
                          ? Expanded(
                              child: Text(
                                'A PHP ${transferFee?.fee} ${transferFee?.type.toLowerCase()} shall be deducted in your account.',
                                style: TextStyle(fontSize: 13, color: Colors.black87),
                              ),
                            )
                          : Container()
                      ],
                    ),
                  ]
                ),
              ),
            ),
            
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
      
                  if (toOtherBankAccount?.bank == null ||
                      toOtherBankAccount?.accountNumber == null ||
                      toOtherBankAccount?.fullName == null) {
                    _showMessage(
                      context,
                      "Please complete bank and account details.",
                    );
                    return;
                  }
      
                  int statusCode = checkTransferDetails(
                    context: context, 
                    fromAccount: selectedFromAccount, 
                    toAccount: toOtherBankAccount, 
                    amount: _amountController.text, 
                    formKey: _formKey,
                    totalFee: double.parse(transferFee?.fee ?? "0")
                  );
                  if (statusCode == -1) {
                    return;
                  }

                  _showMessage(
                    context,
                    "Transfer info saved:\nFrom: ${selectedFromAccount!.accountType.accountType}\n"
                    "To: ${toOtherBankAccount?.fullName} (${toOtherBankAccount?.accountNumber}) at ${toOtherBankAccount?.bank}",
                  );
                  
                  context.push(
                    AppRoutes.kReviewTransferBankAccount,
                    extra: {
                      "fromAccount": selectedFromAccount,
                      "toAccount": toOtherBankAccount,
                      "amount": _amountController.text,
                      "note": _noteController.text
                    }
                  );
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
