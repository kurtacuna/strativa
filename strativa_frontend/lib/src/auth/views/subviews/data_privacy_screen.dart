import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class DataPrivacyScreen extends StatefulWidget {
  const DataPrivacyScreen({super.key});

  @override
  State<DataPrivacyScreen> createState() => _DataPrivacyScreenState();
}

class _DataPrivacyScreenState extends State<DataPrivacyScreen> {
  bool _isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Data Privacy Statement',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Your privacy matters to us. We are committed to protecting your personal data in accordance with applicable laws and regulations. u agree that we may collect, use, store, and process your personal information to provide our services, verify your identity, and comply with regulatory requirements.We implement strict security measures to safeguard your data and will only share it with authorized parties as required by law.",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Privacy Policy',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "We values your privacy and is committed to protecting your personal information. This Privacy Policy explains how we collect, use, share, and protect your data when you use our services.",
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1. Information We Collect\n'
                      'We may collect the following types of information:\n\n'
                      '• Personal Information: Name, mobile number, email address, and government-issued ID details.\n\n'
                      '• Transaction Information: Payment details, linked accounts, and transaction history.\n\n'
                      '• Device & Usage Data: IP address, device information, and app usage patterns.\n',
                    ),
                    Text(
                      '2. How We Use Your Information\n'
                      'We use your data to:\n\n'
                      '• Verify your identity and process transactions.\n\n'
                      '• Improve security and prevent fraud.\n\n'
                      '• Enhance your user experience and provide customer support.\n\n'
                      '• Comply with legal and regulatory requirements.\n',
                    ),
                    Text(
                      '3. How We Share Your Information\n'
                      'We do not sell your personal data. However, we may share your information with:\n\n'
                      '• Authorized Service Providers: Third-party partners that help us deliver our services.\n\n'
                      '• Regulatory Authorities: If required by law or for fraud prevention.\n\n'
                      '• Business Partners: When necessary for seamless transactions.\n',
                    ),
                    Text(
                      '4. How We Protect Your Information\n'
                      'We implement strict security measures, including encryption and access controls, to safeguard your data from unauthorized access, loss, or misuse.\n',
                    ),
                    Text(
                      '5. Your Rights & Choices\n'
                      'You have the right to:\n\n'
                      '• Access, update, or delete your personal information.\n\n'
                      '• Withdraw consent for certain data processing activities.\n\n'
                      '• File a complaint if you believe your data privacy rights have been violated.\n',
                    ),
                    Text(
                      '6.  Retention of Your Information\n'
                      'We retain your data only as long as necessary for legal, security, and business purposes. When no longer needed, we securely delete or anonymize your information.\n',
                    ),
                    Text(
                      '7. Updates to This Privacy Policy\n'
                      'We may update this policy from time to time. We encourage you to review it periodically to stay informed about how we handle your data.\n',
                    ),
                  ],
                ),
              ),
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.teal,
                      value: _isChecked,
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value!;
                        });
                      },
                    ),
                    const Expanded(
                      child: Text(
                        'I am allowing Strativa to collect and process my personal information.',
                        style: TextStyle(fontSize: 13),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AppButtonWidget(
                  text: 'Confirm',
                  onTap: _isChecked
                      ? () {
                          context.push(AppRoutes.kRegName);
                        }
                      : null,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
