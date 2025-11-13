import 'package:flutter/material.dart';

class AppTheme {
  // Light Theme Colors
  static const Color lightBackground = Colors.white;
  static const Color lightSurface = Colors.white;
  static const Color lightPrimary = Color(0xFF8B4513);
  static const Color lightSecondary = Color(0xFF5D4037);
  static const Color lightText = Color(0xFF1F2937);
  static const Color lightSecondaryText = Color(0xFF6B7280);
  static const Color lightBorder = Color(0xFFE5E7EB);
  static const Color lightDivider = Color(0xFFF3F4F6);
  static const Color lightError = Color(0xFFDC2626);

  // Dark Theme Colors
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkPrimary = Color(0xFFFFB74D);
  static const Color darkSecondary = Color(0xFFBCAAA4);
  static const Color darkText = Colors.white;
  static const Color darkSecondaryText = Color(0xFFA1A1AA);
  static const Color darkBorder = Color(0xFF2D2D2D);
  static const Color darkDivider = Color(0xFF2D2D2D);
  static const Color darkError = Color(0xFFF87171);

  static ThemeData lightTheme() {
    final colorScheme = ColorScheme.light(
      primary: lightPrimary,
      secondary: lightSecondary,
      surface: lightSurface,
      onSurface: lightText,
      error: lightError,
      onError: lightError,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: lightBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: lightBackground,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: lightText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        iconTheme: IconThemeData(color: lightText),
      ),
      cardTheme: CardThemeData(
        color: lightSurface,
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: lightBorder, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: lightDivider,
        thickness: 1,
        space: 1,
      ),
    );
  }

  static ThemeData darkTheme() {
    final colorScheme = ColorScheme.dark(
      primary: darkPrimary,
      secondary: darkSecondary,
      surface: darkSurface,
      onSurface: darkText,
      error: darkError,
      onError: darkError,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: darkBackground,
      appBarTheme: AppBarTheme(
        backgroundColor: darkSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: darkText,
          fontSize: 20,
          fontWeight: FontWeight.w600,
          fontFamily: 'Poppins',
        ),
        iconTheme: IconThemeData(color: darkText),
      ),
      cardTheme: CardThemeData(
        color: darkSurface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: darkBorder, width: 1),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: darkDivider,
        thickness: 1,
        space: 1,
      ),
    );
  }
}
