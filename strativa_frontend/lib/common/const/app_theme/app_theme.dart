import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: KcolorsLight.kBackground,
    // background: KcolorsLight.kBackground,
  ),
  scaffoldBackgroundColor: KcolorsLight.kBackground,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.light().textTheme,
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: KcolorsDark.testColor,
    // background: KcolorsDark.testColor,
  ),
  scaffoldBackgroundColor: KcolorsDark.testColor,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.dark().textTheme,
  ),
);