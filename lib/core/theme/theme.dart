import 'package:flutter/material.dart';

class WaterBrosTheme {
  // Light Mode Colors
  static const Color lightPrimary = Color(0xFF2563EB); // Brand Blue
  static const Color lightSecondary = Color(0xFF06B6D4); // Water Cyan
  static const Color lightAccent = Color(0xFF10B981); // Accent Green
  static const Color lightBackground = Color(0xFFF8FAFC);
  static const Color lightSurface = Colors.white;
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightError = Color(0xFFEF4444);

  // Dark Mode Colors
  static const Color darkPrimary = Color(0xFF2563EB);
  static const Color darkSecondary = Color(0xFF0891B2); // Muted Cyan
  static const Color darkAccent = Color(0xFF10B981);
  static const Color darkBackground = Color(0xFF0F172A);
  static const Color darkSurface = Color(0xFF1E293B);
  static const Color darkTextPrimary = Color(0xFFF1F5F9);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkError = Color(0xFFEF4444);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light(
        primary: lightPrimary,
        secondary: lightSecondary,
        tertiary: lightAccent,
        surface: lightSurface,
        error: lightError,
      ),
      scaffoldBackgroundColor: lightBackground,
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFFE2E8F0), width: 1),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: lightTextPrimary),
        headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: lightTextPrimary),
        headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: lightTextPrimary),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: lightTextPrimary),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: lightTextSecondary),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: lightPrimary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: lightBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: lightTextPrimary,
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark(
        primary: darkPrimary,
        secondary: darkSecondary,
        tertiary: darkAccent,
        surface: darkSurface,
        error: darkError,
      ),
      scaffoldBackgroundColor: darkBackground,
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Color(0xFF334155), width: 1),
        ),
      ),
      textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: darkTextPrimary),
        headlineLarge: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: darkTextPrimary),
        headlineMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: darkTextPrimary),
        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.normal, color: darkTextPrimary),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: darkTextSecondary),
        labelLarge: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: darkPrimary),
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
        ),
      ),
    );
  }
}
