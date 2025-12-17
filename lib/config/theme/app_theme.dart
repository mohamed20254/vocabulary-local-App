import 'package:flutter/material.dart';
import 'package:vocabulary/config/theme/text_theme.dart';

abstract class AppTheme {
  static ThemeData appTheme = ThemeData(
    brightness: Brightness.dark,

    appBarTheme: const AppBarThemeData(
      titleTextStyle: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),

      elevation: 0.0,
      centerTitle: true,
    ),
    textTheme: AppTextTheme.textTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blueAccent,
        side: BorderSide(color: Colors.white, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
  );
}
