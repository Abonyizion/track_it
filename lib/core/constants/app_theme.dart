import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class AppTheme {
  // Light Theme
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: Colors.grey.shade100,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.blue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: AppColors.white,
    iconTheme: const IconThemeData(color: AppColors.textDark),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: AppColors.textDark),
      bodyMedium: TextStyle(color: AppColors.textDark),
      titleLarge: TextStyle(
        color: AppColors.textDark,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: AppColors.blue,
      secondary: AppColors.green,
      surface: Colors.white,
      onSurface: AppColors.textDark,
      error: AppColors.red,
    ),
  );

  // Dark Theme
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.black54,
    scaffoldBackgroundColor: AppColors.scaffoldBgDark,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.deepNavyBlue,
      foregroundColor: Colors.white,
      elevation: 0,
    ),
    cardColor: AppColors.cardBgDark,
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
      titleLarge: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: AppColors.blue,
      secondary: AppColors.green,
      surface: Colors.black54,
      onSurface: Colors.white,
      error: AppColors.red,
    ),
  );
}
