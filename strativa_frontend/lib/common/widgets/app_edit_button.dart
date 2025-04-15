import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EditButton extends StatelessWidget {
  final VoidCallback onTap;

  const EditButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          SvgPicture.asset("assets/icons/edit_icon.svg", width: 20, height: 20),
          const SizedBox(width: 6),
          const Text(
            "Edit",
            style: TextStyle(
              color: Colors.orange,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
