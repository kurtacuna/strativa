import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/services/storage.dart';
import 'package:strativa_frontend/common/utils/common_json_model.dart';
import 'package:strativa_frontend/common/utils/refresh/refresh_access_token.dart';
import 'package:strativa_frontend/common/widgets/app_snack_bar_widget.dart';
import 'package:strativa_frontend/src/my_accounts/models/user_data_model.dart';

class UserDataNotifier with ChangeNotifier {
  UserDataModel? _userData;
  bool _isLoading = false;

  UserDataModel? get getUserData => _userData;
  get getIsLoading => _isLoading;

  Future<void> fetchUserData(BuildContext context) async {
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
      } else if (response.statusCode == 401) {
        if (context.mounted) {
          await refetch(
            fetch: () => fetchUserData(context)
          );
        }
      } else {
        if (context.mounted) {
          // TODO: log out the user
          CommonJsonModel model  = commonJsonModelFromJson(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackBarWidget(
              context: context,
              text: model.detail,
              icon: AppIcons.kErrorIcon
            )
          );
        } 
      }

    } catch (e) {
      print("UserDataNotifier");
      print(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}