import 'package:intl/intl.dart';

String daysPastSinceDate(DateTime date) {
  int days = DateTime.now().difference(date).inDays;

  if (days == 0) {
    return "Today, ${DateTime.now()}";
  } else {
    return "$days day${days > 1 ? "s" : ""} ago, ${DateFormat('yMMMMd').format(date)}";
  }
}

String greetUserByTimeOfDay() {
  int hour = DateTime.now().hour;
  String greeting = '';
  
  if (hour >= 0 && hour < 12) {
    greeting = 'Morning';
  } else if (hour >= 12 && hour < 18) {
    greeting = 'Afternoon';
  } else {
    greeting = 'Evening';
  }
  
  return 'Good $greeting,';
}

String getCardExpiry(DateTime date) {
  return DateFormat('M/yy').format(date);
}