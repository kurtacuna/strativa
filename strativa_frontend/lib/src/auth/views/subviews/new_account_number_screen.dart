import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/const/kicons.dart';

class NewAccountNumberScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const NewAccountNumberScreen({super.key, required this.userData});

  @override
  State<NewAccountNumberScreen> createState() => _NewAccountNumberScreenState();
}

class _NewAccountNumberScreenState extends State<NewAccountNumberScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              AppIcons.kSuccessfulIcon,
              const SizedBox(height: 32),
              const Text(
                'Set up your username!',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'Create a unique username that you’ll use to log in to your account.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
              const SizedBox(height: 24),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Username',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter your username',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter a username';
                  }
                  return null;
                },
              ),
              const Spacer(),
              AppButtonWidget(
                text: 'Next',
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    final mergedData = {
                      ...widget.userData,
                      'username': _usernameController.text.trim(),
                    };

                    context.push(
                      AppRoutes.kCreatePassword,
                      extra: mergedData,
                    );
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
