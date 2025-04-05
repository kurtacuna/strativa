import 'package:flutter/material.dart';


class ValidID extends StatelessWidget {
  const ValidID({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Back')),
      body: Padding(
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
            Text(
              "Acceptable IDs:",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            )
          ]
          
        ),

      ),
      //appBar: ,
    );
  }
}
