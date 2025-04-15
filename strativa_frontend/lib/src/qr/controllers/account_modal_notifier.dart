import 'package:flutter/material.dart';

class AccountModalNotifier with ChangeNotifier {
  // TODO: change once model is done
  dynamic _account;
  bool _widgetIsBeingDisposed = false;

  get getAccount => _account;
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
}