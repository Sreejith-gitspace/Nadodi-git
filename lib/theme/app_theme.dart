import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF1B5E20);
  static const Color accent = Color(0xFF43A047);
  static const Color background = Color(0xFFF2F5F2);
  static const Color surface = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: primary,
    colorScheme: const ColorScheme.light(
      primary: primary,
      secondary: accent,
      background: background,
      surface: surface,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primary,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    scaffoldBackgroundColor: background,
    cardTheme: CardTheme(
      color: surface,
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: primary),
    ),
  );
}
