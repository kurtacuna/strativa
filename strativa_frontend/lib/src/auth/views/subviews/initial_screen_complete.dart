import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';


class InitialScreenComplete extends StatelessWidget {
  final Map<String, dynamic> userData;
  const InitialScreenComplete({super.key, required this.userData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Back'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              child: Column(
                children: [
                  AppIcons.kComplete
                ],
              )
              ),
            Center(
              child: Column(
                children: [ // spacing between image and text
                  Text(
                    "Verifying your information done!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Next, we'll verify your identification",
                    style: TextStyle(fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(height: 350),
            AppButtonWidget(text: 'Confirm', onTap: (){
              context.push(AppRoutes.kOpenCamera, extra: userData);
            },),
          ]
        ),
      ),
    );
  }
}
