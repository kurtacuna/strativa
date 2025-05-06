import 'package:flutter/material.dart';

class AppGlobalKeys {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> generateQrFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> scannedQrFormKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> transferToOwnAccountKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> transferToAnotherStrativaAccountKey = GlobalKey<FormState>();
  static final GlobalKey<FormState> transferToAnotherBankAccountKey = GlobalKey<FormState>();
}