import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/services/storage.dart';
import 'package:strativa_frontend/common/utils/refresh/refresh_access_token.dart';
import 'package:strativa_frontend/src/my_accounts/models/user_data_model.dart';

class UserDataNotifier with ChangeNotifier {
  UserDataModel? _userData;
  bool _isLoading = false;
  int _statusCode = -1;
  String? _error;

  UserDataModel? get getUserData => _userData;
  get getIsLoading => _isLoading;
  get getStatusCode => _statusCode;
  get getError => _error;

  Future<void> fetchUserData() async {
    _isLoading = true;
    notifyListeners();

    try {
      String? accessToken = Storage().getString(StorageKeys.accessTokenKey);
      var url = Uri.parse(ApiUrls.userDataUrl);
      var response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $accessToken",
        }
      );

      if (response.statusCode == 200) {
        _userData = userDataModelFromJson(response.body);
        _statusCode = response.statusCode;
      } else if (response.statusCode == 401) {
        int refreshStatus = await refreshAccessToken();

        if (refreshStatus == -1) {
          // TODO: log out the user, clear access and refresh from local
          print("session expired");
          return;
        } else {
          await fetchUserData();
        }
      } else {
        // TODO: remove later
        print(response.statusCode);
        print(response.body);
        return;
      }

    } catch (e) {
      print(e);
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}