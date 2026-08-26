import 'package:flutter/material.dart';

import 'colors.dart';
import 'radius.dart';
import 'spacing.dart';
import 'typography.dart';

/// PreBite Theme Data
/// Configures Flutter Material 3 theme to match DESIGN.md and Stitch files.
abstract final class PreBiteTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: PreBiteColors.background,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: PreBiteColors.primary,
        onPrimary: PreBiteColors.onPrimary,
        primaryContainer: PreBiteColors.primaryContainer,
        onPrimaryContainer: PreBiteColors.onPrimaryContainer,
        secondary: PreBiteColors.secondary,
        onSecondary: PreBiteColors.onSecondary,
        secondaryContainer: PreBiteColors.secondaryContainer,
        onSecondaryContainer: PreBiteColors.onSecondaryContainer,
        tertiary: PreBiteColors.tertiary,
        onTertiary: PreBiteColors.onTertiary,
        tertiaryContainer: PreBiteColors.tertiaryContainer,
        onTertiaryContainer: PreBiteColors.onTertiaryContainer,
        error: PreBiteColors.error,
        onError: PreBiteColors.onError,
        errorContainer: PreBiteColors.errorContainer,
        onErrorContainer: PreBiteColors.onErrorContainer,
        surface: PreBiteColors.surface,
        onSurface: PreBiteColors.onSurface,
        onSurfaceVariant: PreBiteColors.onSurfaceVariant,
        outline: PreBiteColors.outline,
        outlineVariant: PreBiteColors.outlineVariant,
        inverseSurface: PreBiteColors.inverseSurface,
        onInverseSurface: PreBiteColors.inverseOnSurface,
        inversePrimary: PreBiteColors.inversePrimary,
        surfaceTint: PreBiteColors.surfaceTint,
      ),
      textTheme: PreBiteTypography.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: PreBiteColors.surface,
        foregroundColor: PreBiteColors.onSurface,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: PreBiteTypography.titleLarge,
        iconTheme: const IconThemeData(
          color: PreBiteColors.onSurfaceVariant,
          size: 24,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: PreBiteColors.primary,
          foregroundColor: PreBiteColors.onPrimary,
          textStyle: PreBiteTypography.button,
          shape: const RoundedRectangleBorder(
            borderRadius: PreBiteRadius.button,
          ),
          padding: PreBiteSpacing.buttonPadding,
          elevation: 0,
          minimumSize: const Size(0, 48),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: PreBiteColors.primary,
          side: const BorderSide(color: PreBiteColors.borderSubtle, width: 1.0),
          shape: const RoundedRectangleBorder(
            borderRadius: PreBiteRadius.button,
          ),
          padding: PreBiteSpacing.buttonPadding,
          textStyle: PreBiteTypography.button.copyWith(
            color: PreBiteColors.primary,
          ),
          minimumSize: const Size(0, 48),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: PreBiteColors.primary,
          textStyle: PreBiteTypography.button.copyWith(
            color: PreBiteColors.primary,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: PreBiteRadius.button,
          ),
          padding: PreBiteSpacing.buttonPadding,
        ),
      ),
      cardTheme: const CardThemeData(
        color: PreBiteColors.surfaceContainerLowest,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: PreBiteRadius.card,
          side: BorderSide(color: PreBiteColors.borderSubtle, width: 1.0),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: PreBiteColors.surfaceContainerLowest,
        contentPadding: PreBiteSpacing.inputPadding,
        hintStyle: PreBiteTypography.bodyMedium.copyWith(
          color: PreBiteColors.tertiaryContainer,
        ),
        labelStyle: PreBiteTypography.bodyMedium,
        prefixIconColor: PreBiteColors.onSurfaceVariant,
        suffixIconColor: PreBiteColors.onSurfaceVariant,
        border: const OutlineInputBorder(
          borderRadius: PreBiteRadius.input,
          borderSide: BorderSide(color: PreBiteColors.borderSubtle, width: 1.0),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: PreBiteRadius.input,
          borderSide: BorderSide(color: PreBiteColors.borderSubtle, width: 1.0),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: PreBiteRadius.input,
          borderSide: BorderSide(color: PreBiteColors.primaryBrand, width: 2.0),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: PreBiteRadius.input,
          borderSide: BorderSide(color: PreBiteColors.error, width: 1.5),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: PreBiteRadius.input,
          borderSide: BorderSide(color: PreBiteColors.error, width: 2.0),
        ),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: PreBiteColors.secondaryContainer,
        disabledColor: PreBiteColors.surfaceContainerHigh,
        selectedColor: PreBiteColors.primary,
        secondarySelectedColor: PreBiteColors.secondary,
        labelStyle: PreBiteTypography.labelMedium.copyWith(
          color: PreBiteColors.onSecondaryContainer,
        ),
        secondaryLabelStyle: PreBiteTypography.labelMedium.copyWith(
          color: PreBiteColors.onPrimary,
        ),
        padding: PreBiteSpacing.chipPadding,
        shape: const RoundedRectangleBorder(borderRadius: PreBiteRadius.chip),
        side: BorderSide.none,
      ),
      dividerTheme: const DividerThemeData(
        color: PreBiteColors.borderSubtle,
        thickness: 1.0,
        space: 1.0,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: PreBiteColors.surfaceContainerLowest,
        selectedItemColor: PreBiteColors.primary,
        unselectedItemColor: PreBiteColors.onSurfaceVariant,
        selectedLabelStyle: PreBiteTypography.labelMedium.copyWith(
          fontWeight: FontWeight.w700,
        ),
        unselectedLabelStyle: PreBiteTypography.labelMedium,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
      ),
    );
  }
}
