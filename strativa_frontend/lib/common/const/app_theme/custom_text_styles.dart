import 'package:flutter/material.dart';

class CustomTextStyles {
  final BuildContext _context;
  const CustomTextStyles(this._context);

  TextStyle get appLogo => Theme.of(_context).textTheme.displayLarge!.copyWith(
    fontSize: 30,
    fontWeight: FontWeight.w900,
  );
}