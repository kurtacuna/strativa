import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class BirthdayScreen extends StatelessWidget {
  const BirthdayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final DateOfBirthController = TextEditingController();
    final CityOfBirthController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Back'),),
      body: Padding(
        padding: const EdgeInsets.all(25),
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
            TextField(
              controller: DateOfBirthController,
              decoration: InputDecoration(
                hintText: "(MM/DD/YYYY)",
                fillColor: const Color(0xFFEFF3F0),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text("City of Birth"),
            const SizedBox(height: 5),
            TextField(
              controller: CityOfBirthController,
              decoration: InputDecoration(
                hintText: "Enter your City of Birth",
                fillColor: const Color(0xFFEFF3F0),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const Spacer(),
            AppButtonWidget(text: 'Confirm', onTap: (){
              context.push(AppRoutes.kInitialComplete);
            },),
          ],
        ),
      ),
    );
  }
}