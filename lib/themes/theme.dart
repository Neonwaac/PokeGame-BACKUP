import 'package:flutter/material.dart';
import 'palette.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'PixelifySans',

      // Colores globales
      primaryColor: AppColors.primaryPurple,
      scaffoldBackgroundColor: AppColors.primaryPurple,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.accentGreen,
        primary: AppColors.primaryPurple,
        secondary: AppColors.accentGreen,
        error: AppColors.errorRed,
        background: AppColors.primaryPurple,
        surface: AppColors.purpleLight,
        brightness: Brightness.dark,
      ),

      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGreen,
          foregroundColor: AppColors.black,
          textStyle: const TextStyle(
            fontFamily: 'PixelifySans',
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          shadowColor: AppColors.accentBlue,
          elevation: 6,
        ),
      ),

      // Textos
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.white,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: AppColors.boneWhite,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: AppColors.grey,
          fontSize: 14,
        ),
        headlineLarge: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.yellowAccent,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        labelStyle: const TextStyle(
          color: AppColors.primaryPurple,
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.accentGreen,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(
          color: AppColors.grey,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.accentGreen, width: 2),
        ),
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryPurple,
        titleTextStyle: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: AppColors.accentGreen,
        ),
      ),

      cardTheme: CardThemeData(
        color: AppColors.purpleLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: AppColors.shadow,
      ),
    );
  }
}
