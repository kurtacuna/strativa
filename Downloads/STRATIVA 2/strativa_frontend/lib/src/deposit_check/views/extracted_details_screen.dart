import 'dart:io';
import 'package:flutter/material.dart';
import 'package:strativa_frontend/src/deposit_check/controllers/deposit_check_controller.dart';
import 'package:strativa_frontend/src/deposit_check/models/check_model.dart';

class ExtractedDetailsScreen extends StatefulWidget {
  final File frontImage;
  final File backImage;
  const ExtractedDetailsScreen({super.key, required this.frontImage, required this.backImage});

  @override
  State<ExtractedDetailsScreen> createState() => _ExtractedDetailsScreenState();
}

class _ExtractedDetailsScreenState extends State<ExtractedDetailsScreen> {
  final DepositCheckController controller = DepositCheckController();
  CheckDetails? details;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _extractDetails();
  }

  Future<void> _extractDetails() async {
    final result = await controller.extractCheckDetails(widget.frontImage);
    setState(() {
      details = result;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Extracted Check Details")),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("🧾 Extracted Info", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 10),
                  Text("Amount: ${details?.amount ?? 'N/A'}"),
                  Text("Date: ${details?.date ?? 'N/A'}"),
                  Text("Check #: ${details?.checkNumber ?? 'N/A'}"),
                  Text("Bank: ${details?.bankName ?? 'N/A'}"),
                ],
              ),
            ),
    );
  }
}
