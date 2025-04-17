import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class AddressForm extends StatelessWidget {
  const AddressForm({super.key});

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(fontSize: 14, color: Colors.black),
      filled: true,
      fillColor: Colors.white,
      suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Back',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is your address?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),

            Text(
              'Country'
            ), Spacer(),

            TextFormField(
              readOnly: true,
              decoration: _inputDecoration("Philippines"),
            ),
            SizedBox(height: 12),

            Text(
              'City/Municipality/Province'
            ), Spacer(),

            TextFormField(
              readOnly: true,
              decoration: _inputDecoration("Select city"),
            ),
            SizedBox(height: 12),
            Text(
              'District/Town'
            ), Spacer(),

            TextFormField(
              readOnly: true,
              decoration: _inputDecoration("Select district"),
            ),
            SizedBox(height: 12),
            Text(
              'House/Lot/Block/Unit number'
            ), Spacer(),

            TextFormField(
              readOnly: true,
              decoration: _inputDecoration("Enter your house number"),
            ),
            SizedBox(height: 12),
            Text(
              'Street'
            ), Spacer(),

            TextFormField(
              readOnly: true,
              decoration: _inputDecoration("Enter your street"),
            ),
            SizedBox(height: 12),
            Text(
              'Subdivision/Village/Barangay'
            ), Spacer(),

            TextFormField(
              readOnly: true,
              decoration: _inputDecoration("Enter your subdivision"),
            ),
            SizedBox(height: 12),
            Text(
              'Zipcode'
            ), Spacer(),

            TextFormField(
              readOnly: true,
              decoration: _inputDecoration("Enter your zip code"),
            ),

            SizedBox(height: 20),
            AppButtonWidget(text: 'Confirm', onTap: (){
              context.push(AppRoutes.kReviewApplication);
            },),
          ],
        ),
      ),
    );
  }
}
