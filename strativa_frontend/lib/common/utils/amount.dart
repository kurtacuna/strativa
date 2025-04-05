import 'package:intl/intl.dart';

String addCommaToAmount(double amount) {
  String formattedAmount = NumberFormat("#,##0.00").format(amount);
  
  return formattedAmount;
}

String addCommaToWholeNumber(String wholeNumber) {
  String formattedWholeNumber = NumberFormat("#,###").format(int.parse(wholeNumber));

  return formattedWholeNumber;
}

String addCommaToDecimalNumber(String previousAmount, String decimalNumber) {
  List split = decimalNumber.split('.');
  String integerPart = split[0];
  String decimalPart = split[1];
  String formattedAmount = '';

  if (decimalPart.length > 2) {
    return previousAmount;
  }

  if (integerPart.isEmpty) {
    return "0.$decimalPart";
  }
  
  final formattedIntegerPart = addCommaToWholeNumber(integerPart);

  formattedAmount = "$formattedIntegerPart.$decimalPart";

  return formattedAmount;
}