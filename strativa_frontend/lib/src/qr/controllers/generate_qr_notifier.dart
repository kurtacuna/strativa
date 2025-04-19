import 'package:flutter/material.dart';

class GenerateQrNotifier with ChangeNotifier {

  TextEditingController? _amountController;
  bool _specifyAmount = false;
  
  get getAmountController => _amountController;
  get getSpecifyAmount => _specifyAmount;


  set setAmountController(TextEditingController? controller) {
    _amountController = controller;
  }

  set setSpecifyAmount(bool state) {
    _specifyAmount = state;
    notifyListeners();
  }
}