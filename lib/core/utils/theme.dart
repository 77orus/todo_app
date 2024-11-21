import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:toddo_app/core/utils/app_colors.dart';

ThemeData getAppDarkTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.background,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        fontSize: 32,
        color: AppColors.white,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.white,
      ),
      displaySmall: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.white.withOpacity(.44),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.white,
        ),
      ),
      hintStyle: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.white,
      ),
      fillColor: AppColors.lightBlack,
      filled: true,
    ),
  );
}

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.white,
      centerTitle: true,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.lato(
        fontSize: 32,
        color: AppColors.background,
        fontWeight: FontWeight.bold,
      ),
      displayMedium: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.background,
      ),
      displaySmall: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.background.withOpacity(.44),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: AppColors.background,
        ),
      ),
      hintStyle: GoogleFonts.lato(
        fontSize: 16,
        color: AppColors.background,
      ),
      fillColor: AppColors.white,
      filled: true,
    ),
    
  );
}
