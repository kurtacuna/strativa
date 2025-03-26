import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: ColorsLight.kWhite,
    // background: ColorsLight.kWhite,
  ),
  scaffoldBackgroundColor: ColorsLight.kWhite,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.light().textTheme,
  ),
);

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: ColorsDark.testColor,
    // background: ColorsDark.testColor,
  ),
  scaffoldBackgroundColor: ColorsDark.testColor,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.dark().textTheme,
  ),
);