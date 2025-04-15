import 'package:flutter/material.dart';

class AccountModalNotifier with ChangeNotifier {
  // TODO: change type once model is done
  dynamic _account;
  bool _widgetIsBeingDisposed = false;
  TextEditingController? _amountController;

  get getAccount => _account;
  get getAmountController => _amountController;

  set setAccount(dynamic account) {
    _account = account;
    if (!_widgetIsBeingDisposed) {
      notifyListeners();
    } else {
      _widgetIsBeingDisposed = false;
    }
  }

  set setWidgetIsBeingDisposed(bool state) {
    _widgetIsBeingDisposed = state;
  }

  set setAmountController(TextEditingController? controller) {
    _amountController = controller;
  }
}