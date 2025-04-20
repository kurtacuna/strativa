import 'package:flutter/services.dart';
import 'package:strativa_frontend/common/utils/amount.dart';

TextEditingValue formatDecimalInput(
  TextEditingValue oldValue,
  TextEditingValue newValue
) {
  try {
    // When the user presses backspace on a comma,
    // it gets removed from the oldValue and evaluated again,
    // ending with the same old and new value.
    // e.g. 1,234 -> 1234 -> reapplies the comma -> 1,234

    int cursorPosition = oldValue.selection.baseOffset;

    if (newValue.text.contains('.')) {
      final String inputtedAmount = newValue.text;
      final String previousAmount = oldValue.text;
      
      if (inputtedAmount.contains('.') && inputtedAmount.indexOf('.') != inputtedAmount.lastIndexOf('.')) {
        return oldValue;
      }

      final String formattedAmount = addCommaToDecimalNumber(previousAmount, inputtedAmount);

      if (cursorPosition > formattedAmount.length) {
        int diff = cursorPosition - formattedAmount.length;
        cursorPosition -= diff;
      } else {
        cursorPosition = formattedAmount.length;
      }

      newValue = TextEditingValue(
        text: formattedAmount,
        selection: TextSelection.fromPosition(
          TextPosition(offset: cursorPosition)
        )
      );

      return newValue;

    } else {

      if (newValue.text.length > 6) {
        return oldValue;
      }

      final formattedAmount = addCommaToWholeNumber(newValue.text);

      if (cursorPosition > formattedAmount.length) {
        int diff = cursorPosition - formattedAmount.length;
        cursorPosition -= diff;
      } else {
        cursorPosition = formattedAmount.length;
      }
      
      newValue = TextEditingValue(
        text: formattedAmount,
        selection: TextSelection.fromPosition(
          TextPosition(offset: cursorPosition)
        )
      );

      return newValue;
    }
  } catch (e) {
    print("Format Error: $e");
  }
  
  return newValue;
}