// lib/themes/theme.dart
import 'package:flutter/material.dart';
import 'palette.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      fontFamily: 'PixelifySans',

      primaryColor: AppColors.primaryPurple,
      scaffoldBackgroundColor: AppColors.primaryPurple,

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
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),

      textTheme: const TextTheme(
        bodyLarge: TextStyle(
          color: AppColors.white,
          fontSize: 18,
          fontFamily: 'PixelifySans',
        ),
        bodyMedium: TextStyle(
          color: AppColors.white,
          fontSize: 16,
          fontFamily: 'PixelifySans',
        ),
        bodySmall: TextStyle(
          color: AppColors.white,
          fontSize: 14,
          fontFamily: 'PixelifySans',
        ),
        headlineLarge: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 26,
          fontWeight: FontWeight.bold,
          fontFamily: 'PixelifySans',
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.white,
        labelStyle: const TextStyle(
          color: AppColors.primaryPurple, // color inicial del label
          fontFamily: 'PixelifySans',
        ),
        floatingLabelStyle: const TextStyle(
          color: AppColors.accentGreen, // cuando sube
          fontWeight: FontWeight.bold,
          fontFamily: 'PixelifySans',
        ),
        hintStyle: const TextStyle(
          color: AppColors.grey, // color del hint
          fontFamily: 'PixelifySans',
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.accentGreen, width: 2),
        ),
      ),

      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.primaryPurple,
        titleTextStyle: TextStyle(
          color: AppColors.accentGreen,
          fontSize: 22,
          fontWeight: FontWeight.bold,
          fontFamily: 'PixelifySans',
        ),
        iconTheme: IconThemeData(
          color: AppColors.accentGreen,
        ),
      ),
    );
  }
}