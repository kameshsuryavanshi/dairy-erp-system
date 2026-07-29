import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryBlue = Color(0xFF1A365D);
  static const Color primaryDark = Color(0xFF0A1628);
  static const Color accentBlue = Color(0xFF2B6CB0);
  static const Color lightBlue = Color(0xFFEBF4FF);
  static const Color backgroundGrey = Color(0xFFF7FAFC);
  static const Color textDark = Color(0xFF1A365D);
  static const Color textMuted = Color(0xFF718096);
  static const Color successGreen = Color(0xFF3182CE);
  static const Color errorRed = Color(0xFFE53E3E);

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: primaryBlue,
    colorScheme: const ColorScheme.light(
      primary: primaryBlue,
      secondary: accentBlue,
      surface: Colors.white,
      error: errorRed,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: textDark,
    ),
    scaffoldBackgroundColor: backgroundGrey,
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryBlue,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: primaryBlue,
        foregroundColor: Colors.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      filled: true,
      fillColor: Colors.white,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Colors.white,
      indicatorColor: lightBlue,
      labelTextStyle: WidgetStateProperty.all(
        const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      ),
    ),
    textTheme: const TextTheme(
      displayLarge:
          TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: textDark),
      displayMedium:
          TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: textDark),
      displaySmall:
          TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: textDark),
      headlineLarge:
          TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: textDark),
      headlineMedium:
          TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: textDark),
      headlineSmall:
          TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: textDark),
      bodyLarge: TextStyle(fontSize: 16, color: textDark),
      bodyMedium: TextStyle(fontSize: 14, color: textDark),
      bodySmall: TextStyle(fontSize: 12, color: textDark),
      labelSmall: TextStyle(fontSize: 11, color: textMuted),
    ),
    fontFamily: 'Inter',
    shadowColor: Colors.black.withValues(alpha: 0.05),
    dividerColor: Colors.grey[200],
    dividerTheme: DividerThemeData(
      color: Colors.grey[200],
      thickness: 1,
      space: 0,
    ),
  );
}
