import 'package:flutter/material.dart';

class BalanceNotifier with ChangeNotifier {
  // TODO: change _showBalance to get from local storage
  bool _showBalance = true;
  get getShowBalance => _showBalance;
  void toggleShowBalance() {
    _showBalance =! _showBalance;
    notifyListeners();
  }
}