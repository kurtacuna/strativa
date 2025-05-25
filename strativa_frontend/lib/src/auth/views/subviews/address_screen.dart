import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:philippines_rpcmb/philippines_rpcmb.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class AddressForm extends StatefulWidget {
  final Map<String, dynamic>? previousData;

  const AddressForm({super.key, this.previousData});

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  final _formKey = GlobalKey<FormState>();

  Region? _region;
  Province? _province;
  Municipality? _municipality;
  String? _barangay;

  String? _unit;
  String? _street;

  InputDecoration _inputDecoration(String labelText) {
    return InputDecoration(
      labelText: labelText,
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
    );
  }

  void _saveForm() {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (isValid) {
      _formKey.currentState?.save();

      final addressData = {
        'region': _region?.regionName,
        'province': _province?.name,
        'municipality': _municipality?.name,
        'barangay': _barangay,
        'unit': _unit,
        'street': _street,
      };
      final mergedData = {
        ...?widget.previousData, // <- existing gender/marital data
        ...addressData, // <- new address data
      };

      debugPrint('Merged JSON to send: $mergedData');

      context.push(AppRoutes.kReviewApplication, extra: mergedData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        title: const Text('Back', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'What is your address?',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 20),

                const Text('Region'),
                PhilippineRegionDropdownView(
                  value: _region,
                  onChanged: (Region? value) {
                    setState(() {
                      if (_region != value) {
                        _province = null;
                        _municipality = null;
                        _barangay = null;
                      }
                      _region = value;
                    });
                  },
                ),
                const SizedBox(height: 12),

                const Text('Province'),
                PhilippineProvinceDropdownView(
                  value: _province,
                  provinces: _region?.provinces ?? [],
                  onChanged: (Province? value) {
                    setState(() {
                      if (_province != value) {
                        _municipality = null;
                        _barangay = null;
                      }
                      _province = value;
                    });
                  },
                ),
                const SizedBox(height: 12),

                const Text('City/Municipality'),
                PhilippineMunicipalityDropdownView(
                  value: _municipality,
                  municipalities: _province?.municipalities ?? [],
                  onChanged: (Municipality? value) {
                    setState(() {
                      if (_municipality != value) {
                        _barangay = null;
                      }
                      _municipality = value;
                    });
                  },
                ),
                const SizedBox(height: 12),

                const Text('Barangay'),
                PhilippineBarangayDropdownView(
                  barangays: _municipality?.barangays ?? [],
                  onChanged: (String? value) {
                    setState(() {
                      _barangay = value;
                    });
                  },
                ),
                const SizedBox(height: 20),

                const Text('Unit / House / Lot No.'),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: _inputDecoration("Enter unit/house/lot number"),
                  onSaved: (value) => _unit = value,
                ),
                const SizedBox(height: 12),

                const Text('Street'),
                const SizedBox(height: 8),
                TextFormField(
                  decoration: _inputDecoration("Enter street name"),
                  onSaved: (value) => _street = value,
                ),
                const SizedBox(height: 24),
                AppButtonWidget(text: 'Confirm', onTap: _saveForm),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
