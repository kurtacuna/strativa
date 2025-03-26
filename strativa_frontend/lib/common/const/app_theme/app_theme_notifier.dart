import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/app_theme/app_theme.dart';

class AppThemeNotifier with ChangeNotifier {
  // TODO: change to get theme from storage
  ThemeData _themeData = lightMode;
  get getThemeData => _themeData;
  set setThemeData(ThemeData data) {
    _themeData = data;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeData == lightMode) {
      setThemeData = darkMode;
    } else {
      setThemeData = lightMode;
    }
  }
}