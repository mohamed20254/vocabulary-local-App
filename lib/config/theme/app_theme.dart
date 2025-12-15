import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.dark,
    appBarTheme: const AppBarThemeData(elevation: 0.0, centerTitle: true),
  );
}
