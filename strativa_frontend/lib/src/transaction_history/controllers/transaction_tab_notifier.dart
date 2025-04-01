import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kenums.dart';

class TransactionTabNotifier with ChangeNotifier {
  int _currentTabIndex = 0;
  String _currentTab = transactionTabs[0];

  get getCurrentTabIndex => _currentTabIndex;
  get getCurrentTab => _currentTab;

  set setCurrentTabIndex(int index) {
    _currentTabIndex = index;
  }

  set setCurrentTab(String tab) {
    _currentTab = tab;
  }
}