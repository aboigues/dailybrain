import 'package:flutter/material.dart';

/// Design system colors for DailyBrain
/// Based on specification section 4.1
class AppColors {
  AppColors._(); // Private constructor to prevent instantiation

  // Primary - Brain Blue
  static const Color primary500 = Color(0xFF4A90E2);
  static const Color primary600 = Color(0xFF357ABD);
  static const Color primary700 = Color(0xFF2868A8);

  // Secondary - Energy Yellow
  static const Color secondary500 = Color(0xFFF5A623);
  static const Color secondary600 = Color(0xFFE09612);

  // Semantic colors
  static const Color success = Color(0xFF7ED321);
  static const Color error = Color(0xFFD0021B);
  static const Color warning = Color(0xFFF8E71C);

  // Neutrals
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF3F4F6);
  static const Color gray500 = Color(0xFF6B7280);
  static const Color gray900 = Color(0xFF111827);

  // Backgrounds
  static const Color bgPrimary = Color(0xFFFFFFFF);
  static const Color bgSecondary = Color(0xFFF9FAFB);
  static const Color bgDark = Color(0xFF1F2937);

  // Accessibility - Constitution Principle V
  // WCAG AA minimum contrast ratio (4.5:1)
  static const Color textOnPrimary = Colors.white;
  static const Color textOnSecondary = Colors.black;
}
