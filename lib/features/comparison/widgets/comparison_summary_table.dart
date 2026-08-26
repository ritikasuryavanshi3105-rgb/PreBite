import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/shadows.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../models/comparison_model.dart';

/// "At a Glance" Summary Table
class ComparisonSummaryTable extends StatelessWidget {
  const ComparisonSummaryTable({
    super.key,
    required this.metrics,
    required this.product1Name,
    required this.product2Name,
  });

  final List<ComparisonMetricRow> metrics;
  final String product1Name;
  final String product2Name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'At a Glance',
          style: PreBiteTypography.titleLarge.copyWith(
            color: PreBiteColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: PreBiteSpacing.sm),
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
              // Header Row
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
                        'METRIC',
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
                        product1Name,
                        textAlign: TextAlign.center,
                        style: PreBiteTypography.labelMedium.copyWith(
                          color: PreBiteColors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                        product2Name,
                        textAlign: TextAlign.center,
                        style: PreBiteTypography.labelMedium.copyWith(
                          color: PreBiteColors.onSurface,
                          fontWeight: FontWeight.w700,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              // Metric Rows
              ...metrics.asMap().entries.map((entry) {
                final index = entry.key;
                final row = entry.value;
                final isLast = index == metrics.length - 1;

                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: PreBiteSpacing.md,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: PreBiteColors.surface,
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
                      // Metric Label
                      Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            if (row.metric == 'Score') ...[
                              const Icon(
                                Icons.eco,
                                color: PreBiteColors.primary,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                            ],
                            Flexible(
                              child: Text(
                                row.metric,
                                style: PreBiteTypography.bodyMedium.copyWith(
                                  color: PreBiteColors.onSurface,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Product 1 Value
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: row.product1IsBetter
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: PreBiteColors.secondaryContainer
                                        .withValues(alpha: 0.35),
                                    borderRadius: PreBiteRadius.sm,
                                  ),
                                  child: Text(
                                    row.product1Value,
                                    style: PreBiteTypography.button.copyWith(
                                      color: PreBiteColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              : Text(
                                  row.product1Value,
                                  style: PreBiteTypography.bodyMedium.copyWith(
                                    color: PreBiteColors.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                        ),
                      ),
                      // Product 2 Value
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: row.product2IsBetter
                              ? Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: PreBiteColors.secondaryContainer
                                        .withValues(alpha: 0.35),
                                    borderRadius: PreBiteRadius.sm,
                                  ),
                                  child: Text(
                                    row.product2Value,
                                    style: PreBiteTypography.button.copyWith(
                                      color: PreBiteColors.primary,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                    ),
                                  ),
                                )
                              : Text(
                                  row.product2Value,
                                  style: PreBiteTypography.bodyMedium.copyWith(
                                    color: PreBiteColors.onSurfaceVariant,
                                    fontWeight: FontWeight.w500,
                                  ),
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
