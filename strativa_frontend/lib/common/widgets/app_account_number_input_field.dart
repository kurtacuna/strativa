import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';

class AppAccountNumberInputField extends StatelessWidget {
  final TextEditingController controller;

  const AppAccountNumberInputField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: AppText.kAccountNumber,
        filled: true,
        fillColor: const Color(0xFFE9EFEF),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 14,
        ),
      ),
      style: const TextStyle(fontSize: 16),
    );
  }
}
