import 'package:strativa_frontend/common/utils/environment.dart';

class ApiUrls {
  static String jwtCreateUrl = "${Environment.appBaseUrl}/auth/jwt/create";
  static String jwtRefreshUrl = "${Environment.appBaseUrl}/auth/jwt/refresh";
  static String userDataUrl =  "${Environment.appBaseUrl}/api/my_accounts/me";
  static String userTransactionsUrl({required String query}) {
    return "${Environment.appBaseUrl}/api/transaction/me/?type=$query";
  }
  static String imageFromNetworkUrl({required String imageUrl}) {
    return Environment.appBaseUrl + imageUrl;
  }
}