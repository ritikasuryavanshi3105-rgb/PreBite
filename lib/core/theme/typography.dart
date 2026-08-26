import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'colors.dart';

/// PreBite Typography Tokens
/// Based on DESIGN.md (Inter font family, high contrast hierarchy).
abstract final class PreBiteTypography {
  static const String fontFamily = 'Inter';

  /// Display Large (48px / 56px, Bold) - letter spacing -0.02em
  static TextStyle get displayLarge => GoogleFonts.inter(
    fontSize: 48,
    fontWeight: FontWeight.w700,
    height: 56 / 48,
    letterSpacing: -0.02 * 48,
    color: PreBiteColors.onBackground,
  );

  /// Headline Large Desktop (32px / 40px, Bold) - letter spacing -0.01em
  static TextStyle get headlineLarge => GoogleFonts.inter(
    fontSize: 32,
    fontWeight: FontWeight.w700,
    height: 40 / 32,
    letterSpacing: -0.01 * 32,
    color: PreBiteColors.onBackground,
  );

  /// Headline Large Mobile (28px / 36px, Bold)
  static TextStyle get headlineLargeMobile => GoogleFonts.inter(
    fontSize: 28,
    fontWeight: FontWeight.w700,
    height: 36 / 28,
    color: PreBiteColors.onBackground,
  );

  /// Headline Medium (24px / 32px, Semi-Bold)
  static TextStyle get headlineMedium => GoogleFonts.inter(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    height: 32 / 24,
    color: PreBiteColors.onBackground,
  );

  /// Title Large (20px / 28px, Semi-Bold)
  static TextStyle get titleLarge => GoogleFonts.inter(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    color: PreBiteColors.onBackground,
  );

  /// Body Large (16px / 24px, Regular)
  static TextStyle get bodyLarge => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    color: PreBiteColors.onSurface,
  );

  /// Body Medium (14px / 20px, Regular)
  static TextStyle get bodyMedium => GoogleFonts.inter(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    height: 20 / 14,
    color: PreBiteColors.onSurfaceVariant,
  );

  /// Label Medium (12px / 16px, Medium) - letter spacing +0.05em
  static TextStyle get labelMedium => GoogleFonts.inter(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    height: 16 / 12,
    letterSpacing: 0.05 * 12,
    color: PreBiteColors.onSurfaceVariant,
  );

  /// Button Text (16px / 24px, Semi-Bold)
  static TextStyle get button => GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    color: PreBiteColors.onPrimary,
  );

  /// TextTheme representation for MaterialApp
  static TextTheme get textTheme => TextTheme(
    displayLarge: displayLarge,
    headlineLarge: headlineLarge,
    headlineMedium: headlineMedium,
    titleLarge: titleLarge,
    titleMedium: titleLarge.copyWith(fontSize: 16, height: 24 / 16),
    titleSmall: titleLarge.copyWith(fontSize: 14, height: 20 / 14),
    bodyLarge: bodyLarge,
    bodyMedium: bodyMedium,
    bodySmall: bodyMedium.copyWith(fontSize: 12, height: 16 / 12),
    labelLarge: button,
    labelMedium: labelMedium,
    labelSmall: labelMedium.copyWith(fontSize: 10, height: 14 / 10),
  );
}
