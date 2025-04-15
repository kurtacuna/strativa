import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:strativa_frontend/common/utils/common_json_model.dart';
import 'package:strativa_frontend/common/widgets/app_snack_bar_widget.dart';
import 'package:strativa_frontend/src/auth/models/jwt_model.dart';

class JwtNotifier with ChangeNotifier {
  bool _isLoading = false;
  get getIsLoading => _isLoading;
  void toggleLoading() {
    _isLoading =! _isLoading;
    notifyListeners();
  }

  Future<int> login({
    required BuildContext context,
    required String data
  }) async {
    toggleLoading();
    int statusCode = -1;

    // TODO: encrypt data
    try {
      var url = Uri.parse(ApiUrls.jwtCreateUrl);
      var response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: data
      );

      if (response.statusCode == 200) {
        JwtModel model = jwtModelFromJson(response.body);
        String accessToken = model.access;
        String refreshToken = model.refresh;

        Storage().setString(StorageKeys.accessTokenKey, accessToken);
        Storage().setString(StorageKeys.refreshTokenKey, refreshToken);
        statusCode = response.statusCode;
      } else {
        if (context.mounted) {
          // TODO: check if final
          CommonJsonModel error = commonJsonModelFromJson(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            appSnackBarWidget(
              context: context,
              text: error.detail,
              icon: AppIcons.kErrorIcon,
            ),
          );
        }
      }

    } catch (e) {
      print("JwtNotifier");
      print(e);
    } finally {
      toggleLoading();
    }

    return statusCode;
  }
  // TODO: create register function
}