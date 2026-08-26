import 'package:flutter/material.dart';

/// PreBite Spacing Tokens
/// Fluid grid scale based on an 8px rhythmic model (with 4px sub-unit) from DESIGN.md.
abstract final class PreBiteSpacing {
  static const double unit = 4.0;
  static const double xs = 4.0;
  static const double sm = 8.0;
  static const double md = 16.0;
  static const double lg = 24.0;
  static const double xl = 40.0;

  static const double gutter = 16.0;
  static const double marginMobile = 16.0;
  static const double marginDesktop = 64.0;

  // Convenience EdgeInsets
  static const EdgeInsets zero = EdgeInsets.zero;

  static const EdgeInsets allXs = EdgeInsets.all(xs);
  static const EdgeInsets allSm = EdgeInsets.all(sm);
  static const EdgeInsets allMd = EdgeInsets.all(md);
  static const EdgeInsets allLg = EdgeInsets.all(lg);
  static const EdgeInsets allXl = EdgeInsets.all(xl);

  static const EdgeInsets horizontalSm = EdgeInsets.symmetric(horizontal: sm);
  static const EdgeInsets horizontalMd = EdgeInsets.symmetric(horizontal: md);
  static const EdgeInsets horizontalLg = EdgeInsets.symmetric(horizontal: lg);
  static const EdgeInsets horizontalScreen = EdgeInsets.symmetric(
    horizontal: marginMobile,
  );

  static const EdgeInsets verticalSm = EdgeInsets.symmetric(vertical: sm);
  static const EdgeInsets verticalMd = EdgeInsets.symmetric(vertical: md);
  static const EdgeInsets verticalLg = EdgeInsets.symmetric(vertical: lg);

  static const EdgeInsets screenPaddingMobile = EdgeInsets.symmetric(
    horizontal: marginMobile,
    vertical: lg,
  );

  static const EdgeInsets cardPadding = EdgeInsets.all(lg);
  static const EdgeInsets cardPaddingDense = EdgeInsets.all(md);
  static const EdgeInsets buttonPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: 12.0,
  );
  static const EdgeInsets chipPadding = EdgeInsets.symmetric(
    horizontal: 12.0,
    vertical: 6.0,
  );
  static const EdgeInsets inputPadding = EdgeInsets.symmetric(
    horizontal: md,
    vertical: 14.0,
  );
}
