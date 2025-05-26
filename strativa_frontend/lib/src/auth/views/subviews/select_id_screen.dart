import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';

class ValidID extends StatelessWidget {
  const ValidID({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Back')),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Do you have your ID with you?',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Please keep it nearby, as you'll need to take a photo of your government-issued ID.",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 15),
                Text(
                  "Acceptable IDs:",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                const Text('• National ID', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Text('• Driver’s License', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Text('• Passport', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Text('• PRC ID', style: TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                const Text('• SSS IID', style: TextStyle(fontSize: 16)),
                SizedBox(height: 330),
          
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.info_outline, size: 18, color: Colors.teal),
                    SizedBox(width: 6),
                    Expanded(
                      child: Text(
                        "Don’t have any of these IDs? Visit any branch near you for advice on other acceptable documents",
                        style: TextStyle(fontSize: 11),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                AppButtonWidget(text: 'Confirm', onTap: () {
                  context.push(AppRoutes.kDataPrivacy);
                }),
              ],
            ),
          ),
        ),
      ),
      //appBarr: ,
    );
  }
}
