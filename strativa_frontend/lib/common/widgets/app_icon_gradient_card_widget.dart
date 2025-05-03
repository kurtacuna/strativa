import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppIconGradientCardWidget extends StatefulWidget {
  final String iconPath;
  final String label;
  final VoidCallback onTap;

  const AppIconGradientCardWidget({
    super.key,
    required this.iconPath,
    required this.label,
    required this.onTap,
  });

  @override
  State<AppIconGradientCardWidget> createState() =>
      _AppIconGradientCardWidgetState();
}

class _AppIconGradientCardWidgetState extends State<AppIconGradientCardWidget> {
  bool _isHovered = false;

  static const double _defaultBorderRadius = 6;
  static final double _defaultCardSize = 140.w;
  static const double _labelFontSize = 15;
  static const Color _labelColor = Color(0xFF004440);

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          children: [
            AnimatedScale(
              scale: _isHovered ? 1.05 : 1.0,
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeOut,
              child: Container(
                width: _defaultCardSize,
                height: _defaultCardSize,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF56B4AE),
                      Color(0xFF41C0B8),
                      Color(0xFF55D8D0),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(_defaultBorderRadius),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Center(
                      child: Image.asset(
                        widget.iconPath,
                        width: constraints.maxWidth * 0.9,
                        height: constraints.maxHeight * 0.9,
                        fit: BoxFit.contain,
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: _defaultCardSize,
              child: Text(
                widget.label,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: _labelFontSize,
                  color: _labelColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
