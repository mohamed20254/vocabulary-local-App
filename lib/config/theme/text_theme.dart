import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class AppTextTheme {
  static final TextTheme textTheme = GoogleFonts.robotoTextTheme().copyWith(
    displayLarge: const TextStyle(fontSize: 96, fontWeight: FontWeight.bold),
    displayMedium: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
    displaySmall: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
    headlineLarge: const TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
    headlineMedium: const TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
    headlineSmall: const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
    titleLarge: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
    titleMedium: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
    titleSmall: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
    bodyLarge: const TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
    bodyMedium: const TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
    bodySmall: const TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
    labelLarge: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
    labelMedium: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
    labelSmall: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500),
  );
}
