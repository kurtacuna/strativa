import 'package:strativa_frontend/common/const/kurls.dart';
import 'package:strativa_frontend/common/services/storage.dart';
import 'package:http/http.dart' as http;
import 'package:strativa_frontend/common/utils/refresh/model/access_token_model.dart';
import 'package:strativa_frontend/common/utils/refresh/model/refresh_access_token_model.dart';

Future<int> refreshAccessToken() async {
  int statusCode = -1;

  try {
    String? refreshToken = Storage().getString('refreshToken');

    if (refreshToken == null) {
      return statusCode;
    }

    RefreshAccessTokenModel model = RefreshAccessTokenModel(
      refresh: refreshToken,
    );

    var url = Uri.parse(ApiUrls.jwtRefreshUrl);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
      },
      body: refreshAccessTokenModelToJson(model),

    );

    if (response.statusCode == 200) {
      AccessTokenModel model = accessTokenModelFromJson(response.body);
      Storage().setString(StorageKeys.accessTokenKey, model.access);
      statusCode = response.statusCode;
    }

  } catch (e) {
    print(e);
  }

  return statusCode;
}