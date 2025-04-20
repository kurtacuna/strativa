import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:strativa_frontend/src/deposit_check/models/check_model.dart';

class DepositCheckController {
  final ImagePicker _picker = ImagePicker();

  Future<File?> pickImage(String label) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      final directory = await getApplicationDocumentsDirectory();
      return File(pickedFile.path).copy('${directory.path}/${label}_${basename(pickedFile.path)}');
    }
    return null;
  }

  Future<CheckDetails> extractCheckDetails(File image) async {
    final inputImage = InputImage.fromFile(image);
    final textRecognizer = TextRecognizer(script: TextRecognitionScript.latin);
    final RecognizedText recognizedText = await textRecognizer.processImage(inputImage);

    final fullText = recognizedText.text;
    return parseCheckText(fullText);
  }

  CheckDetails parseCheckText(String text) {
    final lines = text.split('\n').map((line) => line.trim()).toList();

    String? amount;
    String? date;
    String? checkNumber;
    String? bankName;

    for (String line in lines) {
      final lowerLine = line.toLowerCase();

      // 🏦 Bank Name
      if (bankName == null && RegExp(r'\b(bank|banc|credit union|savings)\b').hasMatch(lowerLine)) {
        bankName = line;
      }

      // 📅 Date
      if (date == null) {
        final dateMatch = RegExp(r'(\d{1,2}[\/\-\.]\d{1,2}[\/\-\.]\d{2,4})').firstMatch(line);
        if (dateMatch != null) {
          date = dateMatch.group(0);
        }
      }

      // 💰 Amount
      if (amount == null) {
        final amountMatch = RegExp(r'[₱$S]?\s?(\d{1,3}(,\d{3})*(\.\d{2})?)').firstMatch(line);
        if (amountMatch != null) {
          amount = amountMatch.group(1);
        }
      }

      // 🔢 Check Number
      if (checkNumber == null &&
          RegExp(r'(check\s*no|check\s*#|chk\s*#|check number|chk\s*no)', caseSensitive: false).hasMatch(lowerLine)) {
        final numberMatch = RegExp(r'\b\d{3,10}\b').firstMatch(line);
        if (numberMatch != null) {
          checkNumber = numberMatch.group(0);
        }
      }
    }

    // 🔁 Fallback if check number still null
    if (checkNumber == null) {
      final fallbackMatch = RegExp(r'\b\d{5,12}\b').allMatches(text);
      if (fallbackMatch.isNotEmpty) {
        checkNumber = fallbackMatch.last.group(0);
      }
    }

    return CheckDetails(
      amount: amount,
      date: date,
      checkNumber: checkNumber,
      bankName: bankName,
    );
  }
}
