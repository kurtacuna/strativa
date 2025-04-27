import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class EmailVerification extends StatelessWidget {
  final Map<String, dynamic>nameData;

  const EmailVerification({super.key, required this.nameData});

  @override
  Widget build(BuildContext context) {
    final emailController = TextEditingController();
    final codeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Back'),
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
              "We will send you an OTP verification. So that we\nmake sure that it’s you.",
            ),
            const SizedBox(height: 30),
            const Text("Email Address"),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
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
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        // Connect to backend here
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00B1AC),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: Text(
                        "Send Code", style: TextStyle(color: Colors.white),
                      )
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text("Input Field"),
            const SizedBox(height: 5),
            TextField(
              controller: codeController,
              decoration: InputDecoration(
                hintText: "Enter Code",
                fillColor: const Color(0xFFEFF3F0),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  // Connect to backend here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00B1AC),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                child: const Text(
                  "Verify email address",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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