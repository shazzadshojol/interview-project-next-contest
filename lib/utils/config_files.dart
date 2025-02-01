// lib/app/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFFE91E63);
  static const Color background = Colors.white;
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF333333);
  static const Color textSecondary = Color(0xFF666666);
  static const Color ratingYellow = Color(0xFFFFD700);
  static const Color discountRed = Color(0xFFE91E63);
  static const Color divider = Color(0xFFEEEEEE);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static const TextStyle body = TextStyle(
    fontSize: 14,
    color: AppColors.textSecondary,
  );

  static const TextStyle body2 = TextStyle(
    fontSize: 10,
    color: AppColors.textSecondary,
  );

  static const TextStyle price = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.primary,
  );
}

class AppTheme {
  static ThemeData get light => ThemeData(
        primaryColor: AppColors.primary,
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          iconTheme: IconThemeData(color: AppColors.textPrimary),
        ),
        cardTheme: const CardTheme(
          color: AppColors.cardBackground,
          elevation: 2,
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        ),
        dividerTheme: const DividerThemeData(
          color: AppColors.divider,
          thickness: 1,
          space: 1,
        ),
      );
}
