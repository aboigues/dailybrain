import 'package:flutter/material.dart';

/// Design system typography for DailyBrain
/// Based on specification section 4.1
class AppTypography {
  AppTypography._(); // Private constructor

  // Font families
  // TODO: Uncomment when custom fonts are added to assets/fonts/
  // static const String fontFamilyHeading = 'Poppins';
  // static const String fontFamilyBody = 'Inter';
  // static const String fontFamilyMono = 'JetBrainsMono';

  // Using system defaults for now
  static const String? fontFamilyHeading = null; // Will use default heading font
  static const String? fontFamilyBody = null; // Will use default body font
  static const String? fontFamilyMono = null; // Will use default monospace font

  // Headings
  static const TextStyle h1 = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 32,
    height: 40 / 32, // line-height / font-size
    fontWeight: FontWeight.w700,
  );

  static const TextStyle h2 = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 24,
    height: 32 / 24,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle h3 = TextStyle(
    fontFamily: fontFamilyHeading,
    fontSize: 20,
    height: 28 / 20,
    fontWeight: FontWeight.w600,
  );

  // Body text
  static const TextStyle bodyLarge = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 18,
    height: 28 / 18,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle body = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 16,
    height: 24 / 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodySmall = TextStyle(
    fontFamily: fontFamilyBody,
    fontSize: 14,
    height: 20 / 14,
    fontWeight: FontWeight.w400,
  );

  // Monospace (for scores)
  static const TextStyle mono = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle monoLarge = TextStyle(
    fontFamily: fontFamilyMono,
    fontSize: 24,
    fontWeight: FontWeight.w700,
  );
}
