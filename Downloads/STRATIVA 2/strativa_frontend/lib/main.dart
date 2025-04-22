import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/app_theme/app_theme_notifier.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/environment.dart';
import 'package:strativa_frontend/src/auth/controllers/jwt_notifier.dart';
import 'package:strativa_frontend/src/auth/controllers/password_notifier.dart';
import 'package:strativa_frontend/src/entrypoint/controllers/bottom_nav_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/balance_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/user_data_notifier.dart';
import 'package:strativa_frontend/src/qr/controllers/qr_tab_notifier.dart';
import 'package:strativa_frontend/src/transaction_history/controllers/transaction_tab_notifier.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:strativa_frontend/src/deposit_check/views/front_check_capture_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: Environment.filename);
  await GetStorage.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AppThemeNotifier()),
      ChangeNotifierProvider(create: (_) => BottomNavNotifier()),
      ChangeNotifierProvider(create: (_) => PasswordNotifier()),
      ChangeNotifierProvider(create: (_) => BalanceNotifier()),
      ChangeNotifierProvider(create: (_) => TransactionTabNotifier()),
      ChangeNotifierProvider(create: (_) => QrTabNotifier()),
      ChangeNotifierProvider(create: (_) => JwtNotifier()),
      ChangeNotifierProvider(create: (_) => UserDataNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppText.kAppName,
          theme: context.watch<AppThemeNotifier>().getThemeData,
          home: Scaffold(
            body: Stack(
              children: [
                const FrontCheckCaptureScreen(),
                Align(
                  alignment: const Alignment(0.95, 0.80),
                  child: FloatingActionButton(
                    onPressed: () {
                      context.read<AppThemeNotifier>().toggleTheme();
                    },
                    backgroundColor: Theme.of(context).brightness == Brightness.light
                        ? ColorsCommon.kDark
                        : ColorsCommon.kWhite,
                    child: const Icon(Icons.switch_left_rounded),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
