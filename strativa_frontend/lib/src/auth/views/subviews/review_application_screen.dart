import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class ReviewApplicationScreen extends StatefulWidget {
  final Map<String, dynamic> userData;

  const ReviewApplicationScreen({Key? key, required this.userData})
    : super(key: key);

  @override
  State<ReviewApplicationScreen> createState() =>
      _ReviewApplicationScreenState();
}

class _ReviewApplicationScreenState extends State<ReviewApplicationScreen> {
  bool isEditing = false;

  late TextEditingController fullNameController;
  late TextEditingController birthdayController;
  late TextEditingController genderController;
  late TextEditingController maritalStatusController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController addressController;

  @override
  void initState() {
    super.initState();

    fullNameController = TextEditingController(
      text:
          "${widget.userData['first_name']} ${widget.userData['middle_name']} ${widget.userData['last_name']}"
              .trim()
              .replaceAll(RegExp(r'\s+'), ' '),
    );

    birthdayController = TextEditingController(
      text: widget.userData['date_of_birth'] ?? '',
    );
    genderController = TextEditingController(
      text: widget.userData['gender'] ?? '',
    );
    maritalStatusController = TextEditingController(
      text: widget.userData['marital_status'] ?? '',
    );
    emailController = TextEditingController(
      text: widget.userData['email'] ?? '',
    );
    phoneController = TextEditingController(
      text: widget.userData['phone_number'] ?? '',
    );

    final String address = [
          widget.userData['unit'],
          widget.userData['street'],
          widget.userData['barangay'],
          widget.userData['municipality'],
          widget.userData['province'],
          widget.userData['region'],
        ]
        .where((part) => part != null && part.toString().trim().isNotEmpty)
        .map((part) => part.toString().trim())
        .join(', ');

    addressController = TextEditingController(text: address);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    birthdayController.dispose();
    genderController.dispose();
    maritalStatusController.dispose();
    emailController.dispose();
    phoneController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Back', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(
              isEditing ? Icons.save : Icons.edit,
              color: Colors.orange,
            ),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Review your application',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 24),
        
              _buildSectionTitle('Personal Details'),
              _buildEditableInfoSection([
                {'label': 'Name', 'controller': fullNameController},
                {'label': 'Birthday', 'controller': birthdayController},
                {'label': 'Gender', 'controller': genderController},
                {
                  'label': 'Marital Status',
                  'controller': maritalStatusController,
                },
              ]),
        
              const SizedBox(height: 24),
        
              _buildSectionTitle('Contact Details'),
              _buildEditableInfoSection([
                {'label': 'Email', 'controller': emailController},
                {'label': 'Phone number', 'controller': phoneController},
                {'label': 'Address', 'controller': addressController},
              ]),
        
              const SizedBox(height: 39),
              _buildDeclaration(),
        
              const SizedBox(height: 24),
              AppButtonWidget(
                text: 'Confirm and Continue',
                onTap: () {
                  print('--- User Application Data ---');
                  print('Full Name: ${fullNameController.text}');
                  print('Birthday: ${birthdayController.text}');
                  print('Gender: ${genderController.text}');
                  print('Marital Status: ${maritalStatusController.text}');
                  print('Email: ${emailController.text}');
                  print('Phone Number: ${phoneController.text}');
                  print('Address: ${addressController.text}');
        
                  // 🟧 New debug prints for image paths
                  print(
                    'Selfie Image Path: ${widget.userData['selfie_image_path']}',
                  );
                  print('ID Image Path: ${widget.userData['id_image_path']}');
                  print('-----------------------------');
        
                  // Navigate to next screen or handle data submission here.
                  context.push(AppRoutes.kAccountNumber);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildEditableInfoSection(List<Map<String, dynamic>> fields) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
            fields
                .map(
                  (field) =>
                      _buildEditableTile(field['label'], field['controller']),
                )
                .toList(),
      ),
    );
  }

  Widget _buildEditableTile(String label, TextEditingController controller) {
    bool isBirthdayField = label.toLowerCase() == 'birthday';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label: ',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child:
                isEditing
                    ? (isBirthdayField
                        ? TextField(
                          controller: controller,
                          readOnly: true,
                          onTap: () async {
                            DateTime initialDate = DateTime.now();
                            if (controller.text.isNotEmpty) {
                              try {
                                initialDate = DateFormat(
                                  'MM/dd/yyyy',
                                ).parse(controller.text);
                              } catch (_) {}
                            }

                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: initialDate,
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            );

                            if (pickedDate != null) {
                              String formattedDate = DateFormat(
                                'MM/dd/yyyy',
                              ).format(pickedDate);
                              setState(() {
                                controller.text = formattedDate;
                              });
                            }
                          },
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.calendar_today),
                          ),
                        )
                        : TextField(
                          controller: controller,
                          decoration: const InputDecoration(
                            isDense: true,
                            border: OutlineInputBorder(),
                          ),
                        ))
                    : Text(controller.text.isNotEmpty ? controller.text : '-'),
          ),
        ],
      ),
    );
  }

  Widget _buildDeclaration() {
    return const Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text:
                'By clicking confirm, I declare that I am a Filipino citizen and I agree to the ',
          ),
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
