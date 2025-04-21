import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final middleNameController = TextEditingController();
  final lastNameController = TextEditingController();

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
                'What is your name?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              const Text("First Name"),
              const SizedBox(height: 5),
              TextFormField(
                controller: firstNameController,
                decoration: _inputDecoration("Enter your first name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'First name is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  // No need to do anything here if using controllers
                },
              ),
              const SizedBox(height: 20),
              const Text("Middle Name (optional)"),
              const SizedBox(height: 5),
              TextFormField(
                controller: middleNameController,
                decoration: _inputDecoration("Enter your middle name"),
                onSaved: (value) {},
              ),
              const SizedBox(height: 20),
              const Text("Last Name"),
              const SizedBox(height: 5),
              TextFormField(
                controller: lastNameController,
                decoration: _inputDecoration("Enter your last name"),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Last name is required';
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

                    final nameData = {
                      'first_name': firstNameController.text.trim(),
                      'middle_name': middleNameController.text.trim(),
                      'last_name': lastNameController.text.trim(),
                    };

                    debugPrint("Saved Name JSON: $nameData");

                    context.push(AppRoutes.kEmailVerify);
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
