import 'package:flutter/material.dart';
import 'package:dailybrain/core/constants/colors.dart';
import 'package:dailybrain/core/constants/typography.dart';
import 'package:dailybrain/core/constants/spacing.dart';

/// Application theme implementing the design system
/// Constitution Principle V: User Experience Non-Negotiables
class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    // Colors
    colorScheme: ColorScheme.light(
      primary: AppColors.primary500,
      secondary: AppColors.secondary500,
      error: AppColors.error,
      surface: AppColors.bgPrimary,
    ),

    scaffoldBackgroundColor: AppColors.bgPrimary,

    // Typography
    textTheme: TextTheme(
      displayLarge: AppTypography.h1,
      displayMedium: AppTypography.h2,
      displaySmall: AppTypography.h3,
      bodyLarge: AppTypography.bodyLarge,
      bodyMedium: AppTypography.body,
      bodySmall: AppTypography.bodySmall,
    ),

    // Constitution Principle V: Touch targets minimum 44x44px
    // Setting minimum interactive area
    materialTapTargetSize: MaterialTapTargetSize.padded,

    // Button theme
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary500,
        foregroundColor: AppColors.textOnPrimary,
        textStyle: AppTypography.body.copyWith(
          fontWeight: FontWeight.w600,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        // Constitution Principle V: Touch targets 44x44px minimum
        minimumSize: const Size(88, 44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
      ),
    ),

    // Text button theme
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.primary500,
        textStyle: AppTypography.body,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        // Constitution Principle V: Touch targets minimum
        minimumSize: const Size(44, 44),
      ),
    ),

    // Icon button theme
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        foregroundColor: AppColors.gray900,
        // Constitution Principle V: Touch targets 44x44px minimum
        minimumSize: const Size(44, 44),
      ),
    ),

    // Card theme
    cardTheme: CardTheme(
      color: AppColors.bgSecondary,
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    ),

    // App bar theme
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.bgPrimary,
      foregroundColor: AppColors.gray900,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: AppTypography.h3.copyWith(
        color: AppColors.gray900,
      ),
    ),

    // Input decoration theme
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.gray50,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(
          color: AppColors.primary500,
          width: 2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        borderSide: const BorderSide(
          color: AppColors.error,
          width: 2,
        ),
      ),
      contentPadding: const EdgeInsets.all(AppSpacing.md),
    ),

    // Progress indicator theme
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary500,
    ),

    // Divider theme
    dividerTheme: const DividerThemeData(
      color: AppColors.gray100,
      thickness: 1,
      space: AppSpacing.md,
    ),
  );
}
