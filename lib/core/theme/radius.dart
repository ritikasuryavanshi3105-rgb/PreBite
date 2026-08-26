import 'package:flutter/material.dart';

/// PreBite Border Radius Tokens
/// Based on DESIGN.md (Rounded, friendly aesthetic).
abstract final class PreBiteRadius {
  static const double smValue = 4.0;
  static const double defaultValue = 8.0;
  static const double mdValue = 12.0;
  static const double lgValue = 16.0;
  static const double xlValue = 24.0;
  static const double fullValue = 9999.0;

  // Radius objects
  static const Radius smRadius = Radius.circular(smValue);
  static const Radius defaultRadius = Radius.circular(defaultValue);
  static const Radius mdRadius = Radius.circular(mdValue);
  static const Radius lgRadius = Radius.circular(lgValue);
  static const Radius xlRadius = Radius.circular(xlValue);
  static const Radius fullRadius = Radius.circular(fullValue);

  // BorderRadius objects
  static const BorderRadius sm = BorderRadius.all(smRadius);
  static const BorderRadius defaultBorderRadius = BorderRadius.all(
    defaultRadius,
  );
  static const BorderRadius md = BorderRadius.all(mdRadius);
  static const BorderRadius lg = BorderRadius.all(lgRadius);
  static const BorderRadius xl = BorderRadius.all(xlRadius);
  static const BorderRadius full = BorderRadius.all(fullRadius);

  // Component-specific radius helpers
  static const BorderRadius button = md; // 12px
  static const BorderRadius input = md; // 12px
  static const BorderRadius card = lg; // 16px
  static const BorderRadius modal = BorderRadius.only(
    topLeft: lgRadius,
    topRight: lgRadius,
  ); // 16px top rounded
  static const BorderRadius chip = full; // Pill shape
}
