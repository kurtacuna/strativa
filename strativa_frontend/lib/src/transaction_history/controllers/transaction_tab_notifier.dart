import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strativa_frontend/common/const/kenums.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/services/storage.dart';
import 'package:strativa_frontend/common/utils/common_json_model.dart';
import 'package:strativa_frontend/common/utils/refresh/refresh_access_token.dart';
import 'package:strativa_frontend/common/widgets/app_error_snack_bar_widget.dart';
import 'package:strativa_frontend/src/transaction_history/models/transaction_history_model.dart';

class TransactionTabNotifier with ChangeNotifier {
  int _currentTabIndex = 0;
  TransactionTypes _currentTab = TransactionTypes.values[0];

  get getCurrentTabIndex => _currentTabIndex;
  TransactionTypes get getCurrentTab => _currentTab;

  set setCurrentTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }

  set setCurrentTab(TransactionTypes tab) {
    _currentTab = tab;
    notifyListeners();
  }

  TransactionHistoryModel? _userTransactions;
  bool _isLoading = false;

  TransactionHistoryModel? get getUserTransactions => _userTransactions;
  get getIsLoading => _isLoading;

  Future<void> fetchUserTransactions(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    try {
      String query = _currentTab.name; 
      String? accessToken = Storage().getString(StorageKeys.accessTokenKey);
      var url = Uri.parse(ApiUrls.userTransactionsUrl(query: query));
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken"
        }
      );

      if (response.statusCode == 200) {
        print(response.body);
        _userTransactions = transactionHistoryModelFromJson(response.body);
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          await refetch(
            fetch: () => fetchUserTransactions(context)
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
      print("TransactionTabNotifier:");
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}