import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/services/storage.dart';
import 'package:strativa_frontend/common/utils/common_json_model.dart';
import 'package:strativa_frontend/common/utils/refresh/refresh_access_token.dart';
import 'package:strativa_frontend/common/widgets/app_error_snack_bar_widget.dart';
import 'package:strativa_frontend/common/widgets/app_transfer_receive/models/account_modal_model.dart';
import 'package:http/http.dart' as http;

class AppTransferReceiveWidgetNotifier with ChangeNotifier {
  UserAccount? _account;
  List<UserAccount>? _accounts;
  bool _widgetIsBeingDisposed = false;
  bool _isLoading = false;

  get getAccount => _account;
  get getAccountsList => _accounts;
  get getIsLoading => _isLoading;
  
  set setWidgetIsBeingDisposed(bool state) {
    _widgetIsBeingDisposed = state;
  }

  set setAccount(UserAccount? account) {
    _account = account;
    if (!_widgetIsBeingDisposed) {
      notifyListeners();
    } else {
      _widgetIsBeingDisposed = false;
    }
  }

  Future<void> fetchUserAccounts(BuildContext context) async {
    _isLoading = true;
    _accounts = null;
    notifyListeners();

    try {
      String? accessToken = Storage().getString('accessToken');
      var url = Uri.parse(ApiUrls.userAccountsUrl);
      var response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessToken'
        }
      );

      if (response.statusCode == 200) {
        AccountModalModel model = accountModalModelFromJson(response.body);
        _accounts = model.userAccounts;
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          await refetch(
            fetch: () => fetchUserAccounts(context)
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
      print("AppTransferReceiveWidgetNotifier:");
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}