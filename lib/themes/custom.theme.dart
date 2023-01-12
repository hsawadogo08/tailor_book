import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tailor_book/constants/color.dart';

class CustomTheme {
  static ThemeData themeData = ThemeData(
    primarySwatch: primarySwatch,
    primaryColor: primaryColor,
    backgroundColor: kGris,
    scaffoldBackgroundColor: kWhite,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryColor,
    ),
    textTheme: TextTheme(
      headline1: GoogleFonts.exo2(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: kWhite,
      ),
      headline2: GoogleFonts.exo2(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        color: primaryColor,
      ),
      headline3: GoogleFonts.exo2(
        fontSize: 16,
        color: kWhite,
        fontWeight: FontWeight.w700,
      ),
      headline4: GoogleFonts.exo2(
        fontSize: 12,
        color: kWhite,
        fontWeight: FontWeight.w600,
      ),
      headline5: GoogleFonts.exo2(
        fontSize: 8,
        color: kWhite,
        fontWeight: FontWeight.w500,
      ),
    ),
  );
}
