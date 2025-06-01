import 'package:flutter/material.dart';
import 'package:flutter_riverpod_best_practices/core/constants/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/constants/app_text_styles.dart';

class AppTheme {
  static final themeData = ThemeData(
    scaffoldBackgroundColor: AppColors.white,
    primaryColor: AppColors.primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: AppColors.primaryColor,
      //background: AppColors.white,
      surface: AppColors.white,
    ),
    // appBarTheme: AppBarTheme(
    //   backgroundColor: AppColors.white,
    //   elevation: 0,
    //   surfaceTintColor: AppColors.white,
    //   iconTheme: IconThemeData(color: AppColors.black),
    //   titleTextStyle: AppTextStyles.appBarTitleTS,
    // ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    // textTheme: TextTheme(
    //   bodyLarge: TextStyle(color: AppColors.text),
    //   bodyMedium: TextStyle(color: AppColors.text),
    //   titleLarge: AppTextStyles.appBarTitleTS,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.border),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.primaryColor),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: AppTextStyles.btnTS,
      ),
    ),
  );
}
