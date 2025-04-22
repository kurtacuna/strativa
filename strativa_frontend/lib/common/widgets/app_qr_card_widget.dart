import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';
import 'package:strativa_frontend/common/const/kstrings.dart';

class AppQRCardWidget extends StatefulWidget {
  final VoidCallback onTap;

  const AppQRCardWidget({super.key, required this.onTap});

  @override
  State<AppQRCardWidget> createState() => _AppQRCardWidgetState();
}

class _AppQRCardWidgetState extends State<AppQRCardWidget> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.03 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          child: Container(
            height: 104.h,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: ColorsCommon.kAccentL2,
              borderRadius: BorderRadius.circular(6),
              boxShadow: [
                BoxShadow(
                  color: ColorsCommon.kAccentL2.withAlpha(77),
                  blurRadius: 6,
                  spreadRadius: 2,
                  offset: const Offset(0, 0),
                ),
              ],
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Center(
                          child: Image.asset(
                            'assets/icons/QR_hands_icon.png',
                            width: constraints.maxWidth * 0.9,
                            height: constraints.maxHeight * 0.9,
                            fit: BoxFit.contain,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text(
                              AppText.kScanGenerate,
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18.sp,
                                    color: Colors.white,
                                    letterSpacing: 0.8,
                                  ),
                            ),
                            const SizedBox(width: 20),
                            Text(
                              ">",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 24.sp,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
