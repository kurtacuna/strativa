import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class EmailVerification extends StatelessWidget {
  final Map<String, dynamic> nameData;

  const EmailVerification({super.key, required this.nameData});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is your email address?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Please enter your email address so we can proceed with the registration.",
            ),
            const SizedBox(height: 30),
            const Text("Email Address"),
            const SizedBox(height: 5),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Enter email address",
                fillColor: const Color(0xFFEFF3F0),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),
            AppButtonWidget(
              text: 'Confirm',
              onTap: () {
                final updatedData = {
                  ...nameData,
                  'email': emailController.text.trim(),
                };

                context.push(
                  AppRoutes.kMobileNumber,
                  extra: updatedData,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
