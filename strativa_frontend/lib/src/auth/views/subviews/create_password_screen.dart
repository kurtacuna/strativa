import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:strativa_frontend/common/const/kroutes.dart';
import 'package:strativa_frontend/common/widgets/app_button_widget.dart';

class CreatePasswordScreen extends StatefulWidget {
  final Map<String, dynamic> mergedData;          // ← receive previous info

  const CreatePasswordScreen({super.key, required this.mergedData});

  @override
  State<CreatePasswordScreen> createState() => _CreatePasswordScreenState();
}

class _CreatePasswordScreenState extends State<CreatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl        = TextEditingController();
  final _confirmPasswordCtrl = TextEditingController();

  bool _obscure1 = true, _obscure2 = true;

  @override
  void dispose() {
    _passwordCtrl.dispose();
    _confirmPasswordCtrl.dispose();
    super.dispose();
  }

  bool get _isValid {
    // run validators without showing messages
    final pwd = _passwordCtrl.text;
    final confirm = _confirmPasswordCtrl.text;
    return _passwordValidator(pwd) == null &&
           _confirmValidator(confirm)  == null;
  }

  String? _passwordValidator(String? value) {
    final v = value ?? '';
    if (v.length < 8)                                   return 'At least 8 characters';
    if (!RegExp(r'[A-Z]').hasMatch(v))                  return 'Include an uppercase letter';
    if (!RegExp(r'[a-z]').hasMatch(v))                  return 'Include a lowercase letter';
    if (!RegExp(r'\d').hasMatch(v))                     return 'Include a number';
    if (!RegExp(r'[!@#\$%^&*]').hasMatch(v))            return 'Include a special character';
    return null;
  }

  String? _confirmValidator(String? value) {
    if (value != _passwordCtrl.text) return 'Passwords don’t match';
    return null;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final mergedData = {
        ...widget.mergedData,
        'password': _passwordCtrl.text,
      };
      context.go(
        AppRoutes.kLoginScreen, 
        extra: mergedData
      );
    }
  }

  InputDecoration _decoration(String hint, bool obscure, VoidCallback toggle) {
    return InputDecoration(
      hintText: hint,
      border: InputBorder.none,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      suffixIcon: IconButton(
        icon: Icon(obscure ? Icons.visibility : Icons.visibility_off),
        onPressed: toggle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Back')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          onChanged: () => setState(() {}), // rebuild to enable/disable button
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              const Center(
                child: Text('Make a strong password',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 16),
              const Text('• At least 8 characters'),
              const Text('• At least one uppercase letter'),
              const Text('• At least one lowercase letter'),
              const Text('• At least one number'),
              const Text('• At least one special character (!@#\$%^&*)'),
              const SizedBox(height: 24),

              const Text('Password', style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _decoratedField(
                child: TextFormField(
                  controller: _passwordCtrl,
                  obscureText: _obscure1,
                  decoration: _decoration('Enter a password', _obscure1,
                      () => setState(() => _obscure1 = !_obscure1)),
                  validator: _passwordValidator,
                ),
              ),

              const SizedBox(height: 24),

              const Text('Confirm password',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              _decoratedField(
                child: TextFormField(
                  controller: _confirmPasswordCtrl,
                  obscureText: _obscure2,
                  decoration: _decoration('Re‑enter password', _obscure2,
                      () => setState(() => _obscure2 = !_obscure2)),
                  validator: _confirmValidator,
                ),
              ),

              const Spacer(),
              AppButtonWidget(
                text: 'Confirm',
                onTap: _isValid ? _submit : null,      // disabled until valid
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper to reuse the same white‑box styling
  Widget _decoratedField({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2)),
        ],
      ),
      child: child,
    );
  }
}
