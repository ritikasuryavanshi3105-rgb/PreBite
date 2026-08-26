import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';

/// PreBite Reusable 1px Divider
/// Implements DESIGN.md:
/// - 1px horizontal rule (#E2E7E3 / borderSubtle)
class PreBiteDivider extends StatelessWidget {
  const PreBiteDivider({
    super.key,
    this.color = PreBiteColors.borderSubtle,
    this.thickness = 1.0,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.height = 1.0,
  });

  final Color color;
  final double thickness;
  final double indent;
  final double endIndent;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: color,
      thickness: thickness,
      indent: indent,
      endIndent: endIndent,
      height: height,
    );
  }
}
