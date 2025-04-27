import 'package:flutter/material.dart';

class BottomNavNotifier with ChangeNotifier {
  int _index = 1;
  get getIndex => _index;
  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}
