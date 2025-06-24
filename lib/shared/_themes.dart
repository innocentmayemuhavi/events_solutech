import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Custom primary color #407BFF
const Color primaryColor = Color(0xFF407BFF);

// Light theme
ThemeData get lightTheme => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
  ),
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      fontFamily: GoogleFonts.quicksand().fontFamily,
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  textTheme: ThemeData.light().textTheme.copyWith(
    headlineSmall: TextStyle(color: primaryColor),
    titleLarge: TextStyle(color: primaryColor),
  ),
);

// Dark theme
ThemeData get darkTheme => ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
  ),
  useMaterial3: true,
  inputDecorationTheme: InputDecorationTheme(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
  textTheme: ThemeData.dark().textTheme.copyWith(
    headlineSmall: TextStyle(color: primaryColor),
    titleLarge: TextStyle(color: primaryColor),
  ),
);
