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

    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: SafeArea(
        child: Padding(
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
                "Please enter your mobile number so we can contact you if needed.",
              ),
              const SizedBox(height: 30),
              const Text("Mobile Number"),
              const SizedBox(height: 5),
              TextField(
                controller: mobileController,
                keyboardType: TextInputType.phone,
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
              const Spacer(),
              AppButtonWidget(
                text: 'Confirm',
                onTap: () {
                  final updatedData = {
                    ...userData,
                    'phone_number': mobileController.text.trim(),
                  };
                  context.push(AppRoutes.kBirthday, extra: updatedData);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
