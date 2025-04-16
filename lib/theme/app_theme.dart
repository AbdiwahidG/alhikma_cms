import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF1A1C1E),
    colorScheme: const ColorScheme.dark(
      background: Color(0xFF1A1C1E),
      surface: Color(0xFF212325),
      primary: Color(0xFF00BFA5),
      secondary: Color(0xFFFF6B4A),
      onBackground: Colors.white,
      onSurface: Colors.white,
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF212325),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      bodyLarge: TextStyle(
        fontSize: 16,
        color: Colors.white,
      ),
      bodyMedium: TextStyle(
        fontSize: 14,
        color: Colors.white70,
      ),
    ),
    dividerColor: Colors.white12,
  );

  static var primaryColor;
} 