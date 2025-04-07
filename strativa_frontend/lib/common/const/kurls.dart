import 'package:strativa_frontend/common/utils/environment.dart';

class ApiUrls {
  static String jwtCreateUrl = "${Environment.appBaseUrl}/auth/jwt/create";
  static String jwtRefreshUrl = "${Environment.appBaseUrl}/auth/jwt/refresh";
  static String userDataUrl =  "${Environment.appBaseUrl}/api/my_accounts/me";
}