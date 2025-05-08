import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:http/http.dart' as http;
import 'package:strativa_frontend/common/services/storage.dart';
import 'package:strativa_frontend/common/utils/common_json_model.dart';
import 'package:strativa_frontend/common/utils/refresh/refresh_access_token.dart';
import 'package:strativa_frontend/common/widgets/app_error_snack_bar_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:strativa_frontend/src/transfer/models/check_if_account_exists_model.dart';
import 'package:strativa_frontend/src/transfer/models/transfer_fees_model.dart';

class TransferNotifier with ChangeNotifier {
  bool _isLoading = false;
  int _statusCode = -1;
  UserAccount? _checkedAccount;
  bool _widgetIsBeingDisposed = false;
  List<Fee>? _transferFees;

  bool get getIsLoading => _isLoading;
  int get getStatusCode => _statusCode;
  UserAccount? get getCheckedAccount => _checkedAccount;
  List<Fee>? get getTransferFees => _transferFees;

  set setCheckedAccount(UserAccount? account) {
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
        UserAccount account = userAccountFromJson(response.body);
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

  Future<void> fetchTransferFees(
    BuildContext context
  ) async {
    _isLoading = true;
    notifyListeners();
    
    try {
      String? accessToken = Storage().getString(StorageKeys.accessTokenKey);
      var url = Uri.parse(ApiUrls.transferFeesUrl);
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        }
      );

      if (response.statusCode == 200) {
        TransferFeesModel model = transferFeesModelFromJson(response.body);
        _transferFees = model.fees;

        print(transferFeesModelToJson(model));
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          await refetch(
            fetch: () => fetchTransferFees(context)
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
}