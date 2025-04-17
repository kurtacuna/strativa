import 'package:flutter/material.dart';
import 'package:strativa_frontend/common/const/kicons.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class ReviewApplicationScreen extends StatelessWidget {
  const ReviewApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Review your application',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            _buildSectionTitleWithEdit(
              title: 'Personal Details',
              onTap: () {
                // Handle personal details edit
              },
            ),
            _buildInfoSection([
              'Name',
              'Birthday',
              'Country of birth',
              'City of birth',
              'Gender',
              'Marital Status',
            ]),

            const SizedBox(height: 24),

            _buildSectionTitleWithEdit(
              title: 'Contact Details',
              onTap: () {
                // Handle contact details edit
              },
            ),
            _buildInfoSection([
              'Email',
              'Phone number',
              'Address',
              'District/ Town',
              'City / Municipality / Province',
              'Zip code',
              'Country',
            ]),

            const SizedBox(height: 40),
            _buildDeclaration(),
            AppButtonWidget(text: 'Confirm and Continue', onTap: (){
              context.push(AppRoutes.kAccountNumber);
            },),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitleWithEdit({
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            onTap: onTap,
            child: Row(
              children: [
                AppIcons.kEditIcon,
                SizedBox(width: 10),
                Text('Edit', style: TextStyle(color: Colors.orange)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection(List<String> fields) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: fields.map((field) => _buildInfoTile(field, '')).toList(),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(value.isNotEmpty ? value : '-'),
          ),
        ],
      ),
    );
  }

  Widget _buildDeclaration() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(text: 'By clicking confirm, I declare that I am a Filipino citizen and I agree to the '),
          TextSpan(
            text: 'Data Privacy Statement',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
          TextSpan(text: ' and the '),
          TextSpan(
            text: 'Terms & conditions',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
