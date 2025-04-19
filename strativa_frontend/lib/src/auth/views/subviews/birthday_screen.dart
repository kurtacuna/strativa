import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:intl/intl.dart';

class BirthdayScreen extends StatefulWidget {
  const BirthdayScreen({super.key});

  @override
  State<BirthdayScreen> createState() => _BirthdayScreenState();
}

class _BirthdayScreenState extends State<BirthdayScreen> {
  final _formKey = GlobalKey<FormState>();
  final dateOfBirthController = TextEditingController();
  final cityOfBirthController = TextEditingController();

  OutlineInputBorder _defaultBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.transparent),
      );

  OutlineInputBorder _focusedBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.blue, width: 2),
      );

  OutlineInputBorder _errorBorder() => OutlineInputBorder(
        borderRadius: BorderRadius.circular(6),
        borderSide: const BorderSide(color: Colors.red, width: 2),
      );

  InputDecoration _inputDecoration(String hintText) {
    return InputDecoration(
      hintText: hintText,
      fillColor: const Color(0xFFEFF3F0),
      filled: true,
      border: _defaultBorder(),
      focusedBorder: _focusedBorder(),
      errorBorder: _errorBorder(),
      focusedErrorBorder: _errorBorder(),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        dateOfBirthController.text = DateFormat('MM/dd/yyyy').format(picked);
      });
    }
  }

  @override
  void dispose() {
    dateOfBirthController.dispose();
    cityOfBirthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'What is your birthday?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text("Date of Birth (MM/DD/YYYY)"),
              const SizedBox(height: 5),
              GestureDetector(
                onTap: () => _selectDate(context),
                child: AbsorbPointer(
                  child: TextFormField(
                    controller: dateOfBirthController,
                    decoration: _inputDecoration("(MM/DD/YYYY)"),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Birthdate is required';
                      }
                      return null;
                    },
                    onSaved: (value) {},
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text("City of Birth"),
              const SizedBox(height: 5),
              TextFormField(
                controller: cityOfBirthController,
                decoration: _inputDecoration("Enter your City of Birth"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'City of birth is required';
                  }
                  return null;
                },
                onSaved: (value) {},
              ),
              const Spacer(),
              AppButtonWidget(
                text: 'Confirm',
                onTap: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();

                    final birthdayData = {
                      'date_of_birth': dateOfBirthController.text.trim(),
                      'city_of_birth': cityOfBirthController.text.trim(),
                    };

                    debugPrint('Saved Birthday JSON: $birthdayData');

                    context.push(AppRoutes.kInitialComplete);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
