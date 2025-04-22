import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_logo_widget.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    _navigator();
    super.initState(); 
  }

  _navigator() async {
    await Future.delayed(const Duration(seconds: 3), () {
      GoRouter.of(context).go(AppRoutes.kLandingScreen);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsCommon.kAccentL2,
      body: Align(
        alignment: Alignment.center,
        child: AppLogoWidget(color: ColorsCommon.kWhite),
      ),
    );
  }
}