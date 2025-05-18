import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:http/http.dart' as http;
import 'package:strativa_frontend/common/services/storage.dart';
import 'package:strativa_frontend/common/utils/common_json_model.dart';
import 'package:strativa_frontend/common/utils/refresh/refresh_access_token.dart';
import 'package:strativa_frontend/common/widgets/app_error_snack_bar_widget.dart';
import 'package:strativa_frontend/src/transfer/models/check_if_account_exists_model.dart';
import 'package:strativa_frontend/src/transfer/models/other_banks_model.dart';
import 'package:strativa_frontend/src/transfer/models/transaction_fees_model.dart';

class TransferNotifier with ChangeNotifier {
  bool _isLoading = false;
  int _statusCode = -1;
  CheckedAccountModel? _checkedAccount;
  bool _widgetIsBeingDisposed = false;
  List<Fee>? _transactionFees;
  List<OtherBanksModel>? _otherBanks;

  bool get getIsLoading => _isLoading;
  int get getStatusCode => _statusCode;
  CheckedAccountModel? get getCheckedAccount => _checkedAccount;
  List<Fee>? get getTransactionFees => _transactionFees;
  List<OtherBanksModel>? get getOtherBanks => _otherBanks;

  set setCheckedAccount(CheckedAccountModel? account) {
    _checkedAccount = account;
    if (!_widgetIsBeingDisposed) {
      notifyListeners();
    } else {
      _widgetIsBeingDisposed = false;
    }
  }

  set setWidgetIsBeingDisposed(bool state) {
    _widgetIsBeingDisposed = state;
  }

  Future<void> checkIfAccountExists(
    BuildContext context,
    String data,
  ) async {
    _statusCode = -1;
    _isLoading = true;
    notifyListeners();
    
    try {
      CheckIfAccountExists model = CheckIfAccountExists(accountNumber: data);

      String? accessToken = Storage().getString(StorageKeys.accessTokenKey);
      var url = Uri.parse(ApiUrls.checkIfAccountExistsUrl);
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: checkIfAccountExistsToJson(model)
      );

      if (response.statusCode == 200) {
        print(response.body);
        CheckedAccountModel account = checkedAccountModelFromJson(response.body);
        _checkedAccount = account;
        _statusCode = response.statusCode;
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          await refetch(
            fetch: () => checkIfAccountExists(context, data)
          );
        }
      } else {
        if (context.mounted) {
          CommonJsonModel model = commonJsonModelFromJson(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            appErrorSnackBarWidget(context: context, text: model.detail)
          );
        }
      }

    } catch (e) {
      print("TransferNotifier:");
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTransactionFees(
    BuildContext context
  ) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      String? accessToken = Storage().getString(StorageKeys.accessTokenKey);
      var url = Uri.parse(ApiUrls.transactionFeesUrl);
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        }
      );

      if (response.statusCode == 200) {
        TransactionFeesModel model = transactionFeesModelFromJson(response.body);
        _transactionFees = model.fees;
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          await refetch(
            fetch: () => fetchTransactionFees(context)
          );
        }
      } else {
        if (context.mounted) {
          CommonJsonModel model = commonJsonModelFromJson(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            appErrorSnackBarWidget(context: context, text: model.detail)
          );
        }
      }

    } catch (e) {
      print("TransferNotifier:");
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchOtherBanks(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      String? accessToken = Storage().getString(StorageKeys.accessTokenKey);
      var url = Uri.parse(ApiUrls.otherBanksUrl);
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        }
      );

      if (response.statusCode == 200) {
        List<OtherBanksModel> otherBanks = otherBanksModelFromJson(response.body);
        _otherBanks = otherBanks;
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          await refetch(
            fetch: () => fetchOtherBanks(context)
          );
        }
      } else {
        if (context.mounted) {
          CommonJsonModel model = commonJsonModelFromJson(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            appErrorSnackBarWidget(
              context: context, 
              text: model.detail
            )
          );
        }
      }

    } catch (e) {
      print("TransferNotifier:");
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> checkIfOtherBankAccountExists(
    BuildContext context,
    String data,
  ) async {
    _statusCode = -1;
    _isLoading = true;
    notifyListeners();

    try {
      String? accessToken = Storage().getString(StorageKeys.accessTokenKey);
      var url = Uri.parse(ApiUrls.checkIfOtherBankAccountExistsUrl);
      var response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        },
        body: data
      );

      if (response.statusCode == 200) {
        _statusCode = response.statusCode;
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          await refetch(
            fetch: () => checkIfOtherBankAccountExists(context, data)
          );
        }
      } else {
        if (context.mounted) {
          CommonJsonModel model = commonJsonModelFromJson(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            appErrorSnackBarWidget(
              context: context, 
              text: model.detail
            )
          );
        }
      }

    } catch (e) {
      print("TransferNotifier:");
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}