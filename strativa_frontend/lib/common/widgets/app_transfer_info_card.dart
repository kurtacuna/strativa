import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

class TransferInfoCard extends StatelessWidget {
  final String label;
  final String iconPath;
  final String accountType;
  final String accountNumber;

  const TransferInfoCard({
    super.key,
    required this.label,
    required this.iconPath,
    required this.accountType,
    required this.accountNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(iconPath, width: 24, height: 24),
            const SizedBox(width: 10),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          accountType,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          accountNumber,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 16,
            color: Colors.black54,
          ),
        ),
        const Divider(color: ColorsCommon.kGray, thickness: 1, height: 24),
      ],
    );
  }
}
