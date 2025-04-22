import 'package:flutter/material.dart';

class QrTabNotifier with ChangeNotifier {
  int _currentTabIndex = 0;
  get getCurrentTabIndex => _currentTabIndex;
  set setCurrentTabIndex(int index) {
    _currentTabIndex = index;
    notifyListeners();
  }
}