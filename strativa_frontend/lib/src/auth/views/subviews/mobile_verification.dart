import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class MobileVerification extends StatelessWidget {
  final Map<String, dynamic> userData;

  const MobileVerification({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    final mobileController = TextEditingController();
    final codeController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What is your mobile number?",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Enter the OTP sent to mobile number to complete the verification process.",
            ),
            const SizedBox(height: 30),
            const Text("Mobile Number"),
            const SizedBox(height: 5),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextField(
                    controller: mobileController,
                    decoration: InputDecoration(
                      hintText: "Enter mobile number",
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
                        "Send Code",
                        style: TextStyle(color: Colors.white),
                      ),
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
                  "Verify mobile number",
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
                  ...userData, // keep previous data
                  'phone_number': mobileController.text.trim(),
                };
                context.push(AppRoutes.kBirthday, extra: updatedData);
              },
            ),
          ],
        ),
      ),
    );
  }
}
