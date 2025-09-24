import 'package:flutter/material.dart';
import 'palette.dart';

class AppTheme {
  /// Tema Claro
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'PixelifySans',
      brightness: Brightness.light,

      // Colores globales
      primaryColor: AppColors.primaryPurple,
      scaffoldBackgroundColor: AppColors.accentGreen,
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: AppColors.primaryPurple, // botones morados
        onPrimary: AppColors.accentGreen, // texto verde en botones
        secondary: AppColors.accentGreen,
        onSecondary: AppColors.primaryPurple,
        error: AppColors.errorRed,
        onError: AppColors.white,
        surface: AppColors.purpleLight,
        onSurface: AppColors.primaryPurple,
      ),

      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryPurple,
          foregroundColor: AppColors.accentGreen,
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
          color: AppColors.primaryPurple,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: AppColors.primaryPurple,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: AppColors.primaryPurple,
          fontSize: 14,
        ),
        headlineLarge: TextStyle(
          color: AppColors.primaryPurple,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.primaryPurple,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        labelStyle: const TextStyle(color: AppColors.primaryPurple),
        floatingLabelStyle: const TextStyle(
          color: AppColors.primaryPurple,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(color: AppColors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.primaryPurple, width: 2),
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
        color: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        elevation: 4,
        shadowColor: AppColors.shadow,
      ),
    );
  }

  /// Tema Oscuro
  static ThemeData get darkTheme {
    return ThemeData(
      fontFamily: 'PixelifySans',
      brightness: Brightness.dark,

      // 🎨 Colores globales
      primaryColor: AppColors.accentGreen,
      scaffoldBackgroundColor: AppColors.primaryPurple,
      colorScheme: ColorScheme(
        brightness: Brightness.dark,
        primary: AppColors.accentGreen, // botones verdes
        onPrimary: AppColors.primaryPurple, // texto morado en botones
        secondary: AppColors.primaryPurple,
        onSecondary: AppColors.accentGreen,
        error: AppColors.errorRed,
        onError: AppColors.white,
        surface: AppColors.purpleLight,
        onSurface: AppColors.accentGreen,
      ),

      // Botones
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGreen,
          foregroundColor: AppColors.primaryPurple,
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

      // 📝 Textos
      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 18,
        ),
        bodyMedium: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 16,
        ),
        bodySmall: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 14,
        ),
        headlineLarge: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 26,
          fontWeight: FontWeight.bold,
        ),
        headlineMedium: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Inputs
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.purpleDark,
        labelStyle: const TextStyle(color: AppColors.accentGreen),
        floatingLabelStyle: const TextStyle(
          color: AppColors.accentGreen,
          fontWeight: FontWeight.bold,
        ),
        hintStyle: const TextStyle(color: AppColors.grey),
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
