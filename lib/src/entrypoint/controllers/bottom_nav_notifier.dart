import 'package:flutter/material.dart';

class BottomNavNotifier with ChangeNotifier {
  int _index = 0;
  get getIndex => _index;
  set setIndex(int index) {
    _index = index;
    notifyListeners();
  }
}