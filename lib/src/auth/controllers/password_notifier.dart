import 'package:flutter/material.dart';

class PasswordNotifier with ChangeNotifier {
  bool _obscurePassword = true;
  get getObscurePassword => _obscurePassword;
  void toggleObscurePassword() {
    _obscurePassword =! _obscurePassword;
    notifyListeners();
  }
}