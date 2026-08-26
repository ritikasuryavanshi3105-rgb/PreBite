import 'package:flutter/material.dart';

/// PreBite Elevation & Ambient Shadow Tokens
/// Diffused ambient shadows tinted with brand green (10% / 5% / 2% opacity of #0B6B36)
/// as specified in DESIGN.md.
abstract final class PreBiteShadows {
  static const Color shadowTint = Color(0xFF0B6B36);

  /// Soft Bloom Shadow (for cards and containers)
  static const List<BoxShadow> bloom = [
    BoxShadow(
      color: Color.fromRGBO(11, 107, 54, 0.05),
      offset: Offset(0, 4),
      blurRadius: 24,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color.fromRGBO(11, 107, 54, 0.02),
      offset: Offset(0, 2),
      blurRadius: 8,
      spreadRadius: -2,
    ),
  ];

  /// Soft Ambient Shadow
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color.fromRGBO(11, 107, 54, 0.05),
      offset: Offset(0, 4),
      blurRadius: 20,
    ),
  ];

  /// Lifted / Interactive Elevation Shadow
  static const List<BoxShadow> hoverLift = [
    BoxShadow(
      color: Color.fromRGBO(11, 107, 54, 0.10),
      offset: Offset(0, 8),
      blurRadius: 32,
      spreadRadius: -4,
    ),
    BoxShadow(
      color: Color.fromRGBO(11, 107, 54, 0.05),
      offset: Offset(0, 4),
      blurRadius: 16,
      spreadRadius: -4,
    ),
  ];

  /// Floating Action Button / Modal Bottom Sheet Shadow
  static const List<BoxShadow> modal = [
    BoxShadow(
      color: Color.fromRGBO(11, 107, 54, 0.12),
      offset: Offset(0, -4),
      blurRadius: 24,
    ),
  ];
}
