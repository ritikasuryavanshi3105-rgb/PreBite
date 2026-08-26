import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/shadows.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../models/comparison_model.dart';

/// Detailed Nutrition Comparison Table
class ComparisonNutritionTable extends StatelessWidget {
  const ComparisonNutritionTable({
    super.key,
    required this.nutrients,
    required this.product1Name,
    required this.product2Name,
  });

  final List<ComparisonNutrientRow> nutrients;
  final String product1Name;
  final String product2Name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              'Detailed Nutrition',
              style: PreBiteTypography.titleLarge.copyWith(
                color: PreBiteColors.onSurface,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'Per 100g',
              style: PreBiteTypography.labelMedium.copyWith(
                color: PreBiteColors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: PreBiteSpacing.sm),
        // Nutrition Table Card
        Container(
          decoration: BoxDecoration(
            color: PreBiteColors.surface,
            borderRadius: PreBiteRadius.button,
            border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
            boxShadow: PreBiteShadows.bloom,
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: [
              // Table Header
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: PreBiteSpacing.md,
                  vertical: 12,
                ),
                decoration: const BoxDecoration(
                  color: PreBiteColors.surfaceContainerLowest,
                  border: Border(
                    bottom: BorderSide(
                      color: PreBiteColors.surfaceVariant,
                      width: 1.0,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(
                        'NUTRIENT',
                        style: PreBiteTypography.labelMedium.copyWith(
                          color: PreBiteColors.onSurfaceVariant,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        product1Name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: PreBiteTypography.labelMedium.copyWith(
                          color: PreBiteColors.onSurface,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        product2Name.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: PreBiteTypography.labelMedium.copyWith(
                          color: PreBiteColors.onSurface,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.8,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // Nutrient Rows
              ...nutrients.asMap().entries.map((entry) {
                final index = entry.key;
                final row = entry.value;
                final isLast = index == nutrients.length - 1;

                double leftPadding = PreBiteSpacing.md;
                if (row.indentLevel == 1) {
                  leftPadding = 32.0;
                } else if (row.indentLevel >= 2) {
                  leftPadding = 44.0;
                }

                return Container(
                  padding: EdgeInsets.only(
                    left: leftPadding,
                    right: PreBiteSpacing.md,
                    top: 11,
                    bottom: 11,
                  ),
                  decoration: BoxDecoration(
                    color: index.isEven
                        ? PreBiteColors.surface
                        : PreBiteColors.surfaceContainerLowest.withValues(
                            alpha: 0.6,
                          ),
                    border: !isLast
                        ? const Border(
                            bottom: BorderSide(
                              color: PreBiteColors.surfaceVariant,
                              width: 1.0,
                            ),
                          )
                        : null,
                  ),
                  child: Row(
                    children: [
                      // Nutrient Name
                      Expanded(
                        flex: 4,
                        child: Text(
                          row.nutrient,
                          style: PreBiteTypography.bodyMedium.copyWith(
                            color: row.indentLevel > 0
                                ? PreBiteColors.onSurfaceVariant
                                : PreBiteColors.onSurface,
                            fontSize: row.indentLevel >= 2 ? 13 : 14,
                            fontWeight: row.indentLevel == 0
                                ? FontWeight.w600
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                      // Product 1 Value
                      Expanded(
                        flex: 3,
                        child: Text(
                          row.product1Value,
                          textAlign: TextAlign.center,
                          style: PreBiteTypography.bodyMedium.copyWith(
                            color: row.product1IsBetter
                                ? PreBiteColors.primary
                                : PreBiteColors.onSurface,
                            fontWeight: row.product1IsBetter
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                        ),
                      ),
                      // Product 2 Value
                      Expanded(
                        flex: 3,
                        child: Text(
                          row.product2Value,
                          textAlign: TextAlign.center,
                          style: PreBiteTypography.bodyMedium.copyWith(
                            color: row.product2IsBetter
                                ? PreBiteColors.primary
                                : PreBiteColors.onSurfaceVariant,
                            fontWeight: row.product2IsBetter
                                ? FontWeight.w700
                                : FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
