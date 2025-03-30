import 'package:intl/intl.dart';

String addCommaToPrice(double price) {
  String formattedPrice = NumberFormat("#,##0.00").format(price);
  
  return formattedPrice;
}