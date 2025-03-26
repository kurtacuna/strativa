import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/src/login/login_screen.dart';
import 'package:strativa_frontend/src/splashscreen/views/splashscreen.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const Splashscreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
  ],
);

GoRouter get router => _router;