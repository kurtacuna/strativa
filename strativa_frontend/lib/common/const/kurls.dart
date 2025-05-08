import 'package:strativa_frontend/common/utils/environment.dart';

class ApiUrls {
  static final String _appBaseUrl = Environment.appBaseUrl;

  // URLs with trailing slashes are those that require bodies in the request
  static String jwtCreateUrl = "$_appBaseUrl/auth/jwt/create";
  static String jwtRefreshUrl = "$_appBaseUrl/auth/jwt/refresh";
  static String userDataUrl =  "$_appBaseUrl/api/my_accounts/me";
  static String userTransactionsUrl({required String query}) {
    return "$_appBaseUrl/api/transaction/me/?type=$query";
  }
  static String imageFromNetworkUrl({required String imageUrl}) {
    return Environment.appBaseUrl + imageUrl;
  }
  static String createOtpUrl = "$_appBaseUrl/otp/create/";
  static String verifyOtpUrl({required String query}) {
    return "$_appBaseUrl/otp/verify/?type=$query";
  }
  static String userAccountsUrl = "$_appBaseUrl/api/my_accounts/me/accounts";
  static String checkIfAccountExistsUrl = "$_appBaseUrl/api/my_accounts/check_account/";
  static String transferFeesUrl = "$_appBaseUrl/api/transfer/transfer_fees";
}