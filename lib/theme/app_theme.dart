import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF4F46E5);
  static const Color primaryLight = Color(0xFFEEF2FF);

  static const Color purple = Color(0xFF7C3AED);
  static const Color purpleLight = Color(0xFFF3E8FF);

  static const Color blue = Color(0xFF2563EB);
  static const Color blueLight = Color(0xFFEFF6FF);

  static const Color green = Color(0xFF10B981);
  static const Color greenLight = Color(0xFFECFDF5);

  static const Color orange = Color(0xFFF59E0B);
  static const Color orangeLight = Color(0xFFFFFBEB);

  static const Color red = Color(0xFFEF4444);
  static const Color redLight = Color(0xFFFEF2F2);

  static const Color background = Color(0xFFF7F8FC);
  static const Color card = Colors.white;

  static const Color textDark = Color(0xFF172554);
  static const Color textMedium = Color(0xFF64748B);
  static const Color border = Color(0xFFE2E8F0);
}

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
    ),
    fontFamily: 'Arial',
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.textDark,
      centerTitle: false,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 14,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(
          color: AppColors.border,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(
          color: AppColors.border,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12),
        ),
        borderSide: BorderSide(
          color: AppColors.primary,
          width: 1.5,
        ),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(
          color: AppColors.border,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.dark,
    ),
  );
}
