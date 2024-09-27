import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class TextThemeLight {
  static TextThemeLight? _instance;

  static TextThemeLight? get instance {
    _instance ??= TextThemeLight._init();
    return _instance;
  }

  TextThemeLight._init();

  TextTheme get theme {
    return TextTheme(
        displayLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 57,
            color: Color(0xff2E2E2E)),
        displayMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 45,
            color: Color(0xff2E2E2E)),
        displaySmall: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 36,
            color: Color(0xff2E2E2E)),
        //xx
        headlineLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 32,
            color: Color(0xff2E2E2E)),
        headlineMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 28,
            color: Color(0xff2E2E2E)),
        headlineSmall: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 24,
            color: Color(0xff2E2E2E)),
        //xx
        titleLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 22,
            color: Color(0xff2E2E2E)),
        titleMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: Color(0xff2E2E2E)),
        titleSmall: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xff2E2E2E)),
        //xx
        labelLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: Color(0xff2E2E2E)),
        labelMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: Color(0xff2E2E2E)),
        labelSmall: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 11,
            color: Color(0xff2E2E2E)),
        //xx
        bodyLarge: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: Color(0xff2E2E2E)),
        bodyMedium: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 14,
            color: Color(0xff2E2E2E)),
        bodySmall: GoogleFonts.poppins(
            fontWeight: FontWeight.w400,
            fontSize: 12,
            color: Color(0xff2E2E2E)));
  }
}
