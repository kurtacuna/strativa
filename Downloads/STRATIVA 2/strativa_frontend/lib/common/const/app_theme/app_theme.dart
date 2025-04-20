import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:strativa_frontend/common/const/kcolors.dart';

ThemeData lightMode = ThemeData(
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: ColorsCommon.kPrimaryL4,
    cursorColor: ColorsCommon.kPrimaryL4,
    selectionHandleColor: ColorsCommon.kPrimaryL1,
  ),
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
  textSelectionTheme: TextSelectionThemeData(
    selectionColor: ColorsCommon.kPrimaryL4,
    cursorColor: ColorsCommon.kPrimaryL4,
    selectionHandleColor: ColorsCommon.kPrimaryL1,
  ),
  colorScheme: ColorScheme.dark(
    surface: ColorsDark.testColor,
    // background: ColorsDark.testColor,
  ),
  scaffoldBackgroundColor: ColorsDark.testColor,
  textTheme: GoogleFonts.poppinsTextTheme(
    ThemeData.dark().textTheme,
  ),
);