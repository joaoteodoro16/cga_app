import 'package:cga_app/app/core/ui/styles/app_colors.dart';
import 'package:cga_app/app/core/ui/styles/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get theme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      brightness: Brightness.light,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.white,

      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.primary,
        titleTextStyle: AppTextStyles.instance.textMedium.copyWith(
          color: AppColors.white,
          fontSize: 19,
        ),
        iconTheme: IconThemeData(color: AppColors.white),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        foregroundColor: AppColors.white,
      ),
    );
  }
}
