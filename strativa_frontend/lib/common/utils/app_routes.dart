import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/global_keys.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/src/auth/views/landing_screen.dart';
import 'package:strativa_frontend/src/auth/views/login_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/birthday_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/data_privacy_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/email_verify_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/id_camera_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/initial_screen_complete.dart';
import 'package:strativa_frontend/src/auth/views/subviews/mobile_verification.dart';
import 'package:strativa_frontend/src/auth/views/subviews/register_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/select_id_screen.dart';
import 'package:strativa_frontend/src/auth/views/subviews/username_screen.dart';
import 'package:strativa_frontend/src/entrypoint/views/entrypoint.dart';
import 'package:strativa_frontend/src/transaction_history/views/transaction_history_screen.dart';
import 'package:strativa_frontend/src/splashscreen/views/splashscreen.dart';

final GoRouter _router = GoRouter(
  navigatorKey: GlobalKeys.navigatorKey,
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
      path: AppRoutes.kRegisterScreen,
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: AppRoutes.kValidId,
      builder: (context, state) => const ValidID(),
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
      path: AppRoutes.kDataPrivacy,
      builder: (context, state) => const DataPrivacyScreen(),
    ),
    GoRoute(
      path: AppRoutes.kRegName,
      builder: (context, state) => const NameScreen(),
    ),
    GoRoute(
      path: AppRoutes.kEmailVerify,
      builder: (context, state) => const EmailVerification(),
    ),
    GoRoute(
      path: AppRoutes.kMobileNumber,
      builder: (context, state) => const MobileVerification(),
    ),
    GoRoute(
      path: AppRoutes.kBirthday,
      builder: (context, state) => const BirthdayScreen(),
    ),
    GoRoute(
      path: AppRoutes.kInitialComplete,
      builder: (context, state) => const InitialScreenComplete(),
    ),
    GoRoute(
      path: AppRoutes.kOpenCamera,
      builder: (context, state) => const CameraOpeningScreen(),
    ),
  ],
);

GoRouter get router => _router;