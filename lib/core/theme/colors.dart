import 'package:flutter/material.dart';

/// PreBite Color Tokens
/// Based on DESIGN.md ("Verdant Spectrum") and Stitch UI source of truth.
abstract final class PreBiteColors {
  // Brand Primary Palette
  static const Color primary = Color(0xFF006B32);
  static const Color primaryBrand = Color(0xFF168A45);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF0E8642);
  static const Color onPrimaryContainer = Color(0xFFF7FFF3);
  static const Color inversePrimary = Color(0xFF73DC8D);

  static const Color primaryFixed = Color(0xFF8FF9A7);
  static const Color primaryFixedDim = Color(0xFF73DC8D);
  static const Color onPrimaryFixed = Color(0xFF00210B);
  static const Color onPrimaryFixedVariant = Color(0xFF005225);

  // Secondary Palette
  static const Color secondary = Color(0xFF0F6D37);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFF9FF6B2);
  static const Color onSecondaryContainer = Color(0xFF19733D);
  static const Color secondaryFixed = Color(0xFF9FF6B2);
  static const Color secondaryFixedDim = Color(0xFF84D998);
  static const Color onSecondaryFixed = Color(0xFF00210C);
  static const Color onSecondaryFixedVariant = Color(0xFF005227);

  // Tertiary / Neutral Slate Palette
  static const Color tertiary = Color(0xFF535F58);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF6B7770);
  static const Color onTertiaryContainer = Color(0xFFF5FFF7);
  static const Color tertiaryFixed = Color(0xFFD9E6DD);
  static const Color tertiaryFixedDim = Color(0xFFBDCAC1);
  static const Color onTertiaryFixed = Color(0xFF131E19);
  static const Color onTertiaryFixedVariant = Color(0xFF3E4943);

  // Surface & Background Palette
  static const Color background = Color(0xFFFCF9F8);
  static const Color onBackground = Color(0xFF1B1B1B);

  static const Color surface = Color(0xFFFCF9F8);
  static const Color surfaceDim = Color(0xFFDCD9D9);
  static const Color surfaceBright = Color(0xFFFCF9F8);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF6F3F2);
  static const Color surfaceContainer = Color(0xFFF0EDED);
  static const Color surfaceContainerHigh = Color(0xFFEAE7E7);
  static const Color surfaceContainerHighest = Color(0xFFE5E2E1);
  static const Color surfaceVariant = Color(0xFFE5E2E1);
  static const Color surfaceTint = Color(0xFF006D33);

  static const Color onSurface = Color(0xFF1B1B1B);
  static const Color onSurfaceVariant = Color(0xFF3E4A3F);

  static const Color inverseSurface = Color(0xFF313030);
  static const Color inverseOnSurface = Color(0xFFF3F0EF);

  // Borders & Outlines
  static const Color outline = Color(0xFF6E7A6E);
  static const Color outlineVariant = Color(0xFFBECABC);
  static const Color borderSubtle = Color(0xFFE2E7E3);

  // Semantic / Functional Status Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  static const Color warning = Color(0xFFD97706);
  static const Color warningContainer = Color(0xFFFEF3C7);
  static const Color onWarningContainer = Color(0xFF78350F);

  static const Color success = Color(0xFF006B32);
  static const Color successContainer = Color(0xFFEAF7EE);
  static const Color onSuccessContainer = Color(0xFF005225);

  static const Color info = Color(0xFF2563EB);
  static const Color infoContainer = Color(0xFFDBEAFE);
  static const Color onInfoContainer = Color(0xFF1E40AF);

  // Health Score & NOVA Classification Specific Tones
  static const Color scoreExcellent = Color(0xFF006B32);
  static const Color scoreGood = Color(0xFF168A45);
  static const Color scoreModerate = Color(0xFFD97706);
  static const Color scorePoor = Color(0xFFBA1A1A);

  static const Color nova1 = Color(
    0xFF006B32,
  ); // Unprocessed / minimally processed
  static const Color nova2 = Color(
    0xFF0E8642,
  ); // Processed culinary ingredients
  static const Color nova3 = Color(0xFFD97706); // Processed foods
  static const Color nova4 = Color(0xFFBA1A1A); // Ultra-processed foods
}
