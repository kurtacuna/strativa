import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/src/auth/views/landing_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/address_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/birthday_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/create_password_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/data_privacy_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/email_verify_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/face_scan_camera_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/face_verification.dart';
import 'package:strativa_frontend/src/auth/views/subviews/gender_marital_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/id_camera_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/initial_screen_complete.dart';
import 'package:strativa_frontend/src/auth/views/subviews/login_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/mobile_verification.dart';
import 'package:strativa_frontend/src/auth/views/subviews/new_account_number_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/register_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/review_application_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/select_id_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/username_screen.dart';
import 'package:strativa_frontend/src/entrypoint/views/entrypoint.dart';
import 'package:strativa_frontend/src/qr/views/qr_screen.dart';
import 'package:strativa_frontend/src/qr/views/subviews/generated_qr_subscreen.dart';
import 'package:strativa_frontend/src/qr/views/subviews/scanned_qr_subscreen.dart';
import 'package:strativa_frontend/src/transaction_history/views/transaction_history_screen.dart';
import 'package:strativa_frontend/src/splashscreen/views/splashscreen.dart';
import 'package:strativa_frontend/src/transfer/views/subviews/account/transfer_to_account_subscreen.dart';
import 'package:strativa_frontend/src/transfer/views/subviews/strativa_account/transfer_to_strativa_account_subscreen.dart';
import 'package:strativa_frontend/src/transfer/views/subviews/bank/transfer_to_bank_account_subscreen.dart';
import 'package:strativa_frontend/src/transfer/views/subviews/bank/account_details.dart';
import 'package:strativa_frontend/src/transfer/views/subviews/account/review_transfer_subscreen.dart';
import 'package:strativa_frontend/src/transfer/views/subviews/strativa_account/review_transfer_strativaacc_subscreen.dart';
import 'package:strativa_frontend/src/transfer/views/subviews/bank/review_transfer_bank_subscreen.dart';
import 'package:strativa_frontend/src/transfer/views/subviews/strativa_account/transfer_to_strativaacc_accnumber_subscreen.dart';
import 'package:strativa_frontend/src/payload/views/subviews/bills/payload_bills_review_subscreen.dart';
import 'package:strativa_frontend/src/transfer/views/success_transfer.dart';
import 'package:strativa_frontend/src/transaction_history/widgets/transaction_item_page_widget.dart';

final GoRouter _router = GoRouter(
  navigatorKey: AppGlobalKeys.navigatorKey,
  initialLocation: AppRoutes.kSplashScreen,
  routes: [
    GoRoute(
      path: AppRoutes.kSplashScreen,
      builder: (context, state) => const Splashscreen(),
    ),
    GoRoute(
      path: AppRoutes.kLandingScreen,
      builder: (context, state) => const LandingScreen(),
    ),
    GoRoute(
      path: AppRoutes.kLoginScreen,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: AppRoutes.kEntrypoint,
      builder: (context, state) => const Entrypoint(),
    ),
    GoRoute(
      path: AppRoutes.kTransactionHistoryScreen,
      builder: (context, state) => const TransactionHistoryScreen(),
    ),
    GoRoute(
      path: AppRoutes.kQrScreen,
      builder: (context, state) => const QrScreen(),
    ),
    GoRoute(
      path: AppRoutes.kGeneratedQrSubscreen,
      builder: (context, state) => const GeneratedQrSubscreen(),
    ),
    GoRoute(
      path: AppRoutes.kReviewTransfer,
      builder: (context, state) {
        Map<String, dynamic> obj = state.extra as Map<String, dynamic>;
        return ReviewTransferSubscreen(
          toAccount: obj["toAccount"],
          fromAccount: obj["fromAccount"],
          amount: obj["amount"],
          note: obj["note"]
        );
      },
    ),
    GoRoute(
      path: AppRoutes.kReviewTransferStrativaAccount,
      builder: (context, state) {
        Map<String, dynamic> obj = state.extra as Map<String, dynamic>;
        return ReviewTransferStrativaaccSubscreen(
          fromAccount: obj["fromAccount"],
          toAccount: obj["toAccount"],
          amount: obj["amount"],
          note: obj["note"]
        );
      },
    ),
    GoRoute(
      path: AppRoutes.kReviewTransferBankAccount,
      builder: (context, state) {
        Map<String, dynamic> obj = state.extra as Map<String, dynamic>;
        return ReviewTransferBankSubscreen(
          fromAccount: obj["fromAccount"],
          toAccount: obj["toAccount"],
          amount: obj["amount"],
          note: obj["note"]
        );
      },
    ),
    GoRoute(
      path: AppRoutes.kTransferToAnotherStrativaAccNumber,
      builder: (context, state) => const TransferToStrativaaccAccnumberSubscreen(),
    ),
    GoRoute(
      path: AppRoutes.kPayloadBillsReviewSubscreen,
      builder: (context, state) => const PayloadBillsReviewSubscreen(),
    ),
    GoRoute(
      path: AppRoutes.kScannedQrSubscreen,
      builder: (context, state) => const ScannedQrSubscreen(),
    ),
    GoRoute(
      path: AppRoutes.kTransferToAccount,
      builder: (context, state) => const TransferToAccountSubscreen(),
    ),
    GoRoute(
      path: AppRoutes.kTransferToStrativaAccount,
      builder: (context, state) => const TransferToStrativaAccountSubscreen(),
    ),
    GoRoute(
      path: AppRoutes.kTransferToBankAccount,
      builder: (context, state) => const TransferToBankAccountSubscreen(),
    ),
    GoRoute(
      path: AppRoutes.kAccountDetails,
      builder: (context, state) => const AccountDetails(bank: ''),
    ),
    GoRoute(
      path: AppRoutes.kSuccessTransfer,
      builder: (context, state) {
        Map<String, dynamic> obj = state.extra as Map<String, dynamic>;
        return SuccessTransferScreen(
          fromAccountType: obj["fromAccountType"],
          fromAccountNumber: obj["fromAccountNumber"],
          toAccountType: obj["toAccountType"],
          toAccountNumber: obj["toAccountNumber"],
          amount: obj["amount"],
          note: obj["note"]
        );
      },
    ),
    GoRoute(
      path: AppRoutes.kTransactionPageString,
      builder: (context, GoRouterState state) {
        final String? transactionIndex = state.pathParameters['index'];
        return TransactionItemPageWidget(index: transactionIndex!);
      }
    ),
    GoRoute(
      path: AppRoutes.kRegisterScreen,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.kValidId,
      builder: (context, state) => const ValidID(),
    ),
    GoRoute(
      path: AppRoutes.kDataPrivacy,
      builder: (context, state) => const DataPrivacyScreen(),
    ),
    GoRoute(
      path: AppRoutes.kRegName,
      builder: (context, state) => const NameScreen(),
    ),
    GoRoute(
      path: AppRoutes.kEmailVerify,
      builder: (context, state) {
        final nameData = state.extra as Map<String, dynamic>;
        return EmailVerification(nameData: nameData);
      },
    ),
    GoRoute(
      path: AppRoutes.kMobileNumber,
      builder: (context, state) {
        final userData = state.extra as Map<String, dynamic>;
        return MobileVerification(userData: userData);
      },
    ),
    GoRoute(
      path: AppRoutes.kBirthday,
      builder: (context, state) {
        final userData = state.extra as Map<String, dynamic>;
        return BirthdayScreen(userData: userData);
      },
    ),
    GoRoute(
      path: AppRoutes.kInitialComplete,
      builder: (context, state) {
        final userData = state.extra as Map<String, dynamic>;
        return InitialScreenComplete(userData: userData);
      },
    ),

    GoRoute(
      path: AppRoutes.kOpenCamera,
      builder: (context, state) {
        final userData = state.extra as Map<String, dynamic>;
        return CameraOpeningScreen(userData: userData);
      },
    ),

    GoRoute(
      path: AppRoutes.kFaceVerification,
      builder: (context, state) {
        final userData = state.extra as Map<String, dynamic>;
        return FaceVerification(userData: userData);
      },
    ),
    GoRoute(
      path: AppRoutes.kGenderMarital,
      builder: (context, state) {
        final userData = state.extra as Map<String, dynamic>;
        return GenderMaritalScreen(userData: userData);
      },
    ),
    GoRoute(
      path: AppRoutes.kAddressForm,
      builder:
          (context, state) =>
              AddressForm(previousData: state.extra as Map<String, dynamic>?),
    ),
    GoRoute(
      path: AppRoutes.kReviewApplication,
      builder: (context, state) {
        final formData = state.extra as Map<String, dynamic>;
        return ReviewApplicationScreen(userData: formData);
      },
    ),
    GoRoute(
      path: AppRoutes.kAccountNumber,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>? ?? {};
        return NewAccountNumberScreen(userData: data);
      },
    ),
    GoRoute(
      path: AppRoutes.kCreatePassword,
      builder: (context, state) {
        final data = state.extra as Map<String, dynamic>? ?? {};
        return CreatePasswordScreen(mergedData: data);
      },
    ),
    GoRoute(
      path: AppRoutes.kFaceScanVerification,
      builder: (context, state) {
        final userData = state.extra as Map<String, dynamic>;
        return FaceScanCameraScreen(userData: userData);
      },
    ),
  ],
);

GoRouter get router => _router;
