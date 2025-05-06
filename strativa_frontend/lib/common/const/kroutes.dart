class AppRoutes {
  static const String kSplashScreen = '/';
  static const String kLandingScreen = '/landing';
  static const String kRegisterScreen = '/register';
  static const String kValidId = '/validID';
  static const String kRegName = '/userName_reg';
  static const String kEmailVerify = '/email_verify';
  static const String kMobileNumber = '/mobile_verify';
  static const String kBirthday = '/birthday';
  static const String kInitialComplete = '/inital_complete';
  static const String kOpenCamera = '/open_camera';
  static const String kFaceVerification = '/face_verification';
  static const String kFaceScanVerification = '/face_scan_verify';
  static const String kGenderMarital = '/gender_marital';
  static const String kAddressForm = '/address';
  static const String kReviewApplication = '/review_application';
  static const String kAccountNumber = '/account_number';
  static const String kCreatePassword = '/create_pass';
  static const String kDataPrivacy = '/data_privacy';
  static const String kLoginScreen = '/login';
  static const String kEntrypoint = '/entrypoint';
  static const String kMyAccounts = 'my_accounts';
  static const String kTransfer = '/transfer';
  static const String kTransferToAccount = '/transfer_to_account_subscreen';
  static const String kTransferToStrativaAccount =
      '/transfer_to_strativa_account_subscreen';
  static const String kTransferToBankAccount =
      '/transfer_to_bank_account_subscreen';
  static const String kAccountDetails = '/account_details';
  static const String kPayLoad = '/pay_load';
  static const String kInvest = '/invest';
  static const String kProfile = '/profile';
  static const String kTransactionHistoryScreen = '/transaction_history';
  static const String kQrScreen = '/qr';
  static const String kGeneratedQrSubscreen = '/generated_qr';
  static const String kReviewTransfer = '/review_transfer';
  static const String kReviewTransferStrativaAccount =
      '/review_transfer_strativaacc';
  static const String kReviewTransferBankAccount = '/review_transfer_bank';
  static const String kTransferToAnotherStrativaAccNumber =
      '/transfer_to_strativaacc_accnumber_subscreen';
  static const String kPayloadBillsReviewSubscreen =
      '/payload_bills_review_subscreen';
  static const String kScannedQrSubscreen = '/scanned_qr';
  static const String kSuccessTransfer = '/success_transfer';
  static const String kTransactionPageString = '/transaction/:index';
  static String kTransactionPage(int index) => '/transaction/$index';
}
