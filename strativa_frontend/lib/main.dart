import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/utils/app_routes.dart';
import 'package:strativa_frontend/common/const/app_theme/app_theme_notifier.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';
import 'package:strativa_frontend/common/utils/environment.dart';
import 'package:strativa_frontend/common/widgets/otp/controllers/otp_notifier.dart';
import 'package:strativa_frontend/src/auth/controllers/jwt_notifier.dart';
import 'package:strativa_frontend/src/auth/controllers/password_notifier.dart';
import 'package:strativa_frontend/src/entrypoint/controllers/bottom_nav_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/balance_notifier.dart';
import 'package:strativa_frontend/src/my_accounts/controllers/user_data_notifier.dart';
import 'package:strativa_frontend/src/qr/controllers/account_modal_notifier.dart';
import 'package:strativa_frontend/src/qr/controllers/qr_tab_notifier.dart';
import 'package:strativa_frontend/src/splashscreen/views/splashscreen.dart';
import 'package:strativa_frontend/src/transaction_history/controllers/transaction_tab_notifier.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
      ChangeNotifierProvider(create: (_) => OtpNotifier()),
      ChangeNotifierProvider(create: (_) => AccountModalNotifier()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Offset position = Offset(350, 750);

  Widget _buildDraggableButton(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Draggable(
        feedback: FloatingActionButton(
          onPressed: () {
            context.read<AppThemeNotifier>().toggleTheme();
          },
          backgroundColor: Theme.of(context).brightness == Brightness.light
            ? ColorsCommon.kDark
            : ColorsCommon.kWhite,
          child: const Icon(Icons.switch_left_rounded),
        ),
        childWhenDragging: Container(),
        onDragEnd:(details) {
          setState(() {
            position = Offset(
              details.offset.dx,
              details.offset.dy,
            );
          });
        },
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
    );
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return ScreenUtilInit(
      designSize: screenSize,
      minTextAdapt: true,
      splitScreenMode: false,
      useInheritedMediaQuery: true,
      builder: (_, child) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: AppText.kAppName,
          theme: context.watch<AppThemeNotifier>().getThemeData,
          routerConfig: router,
          builder: (context, child) {
            return Overlay(
              initialEntries: [
                OverlayEntry(
                  builder:(context) {
                    return Scaffold(
                      body: Stack(
                        children: [
                          child!,
                          // TODO: remove when change theme in settings is implemented
                          _buildDraggableButton(context)
                        ]
                      ),
                    );
                  },
                )
              ],
            );
          }
        );
      },
      child: const Splashscreen(),
    );
  }
}
