import 'package:flutter/material.dart';

class GenerateQrAccountModalNotifier with ChangeNotifier {
  // TODO: change type once model is done
  dynamic _account;
  bool _widgetIsBeingDisposed = false;
  TextEditingController? _amountController;
  bool _specifyAmount = false;

  get getAccount => _account;
  get getAmountController => _amountController;
  get getSpecifyAmount => _specifyAmount;

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

  set setSpecifyAmount(bool state) {
    _specifyAmount = state;
    notifyListeners();
  }
}