import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../models/recommendation_model.dart';

/// Horizontally scrollable filter chips bar for recommendations
class RecommendationFiltersBar extends StatelessWidget {
  const RecommendationFiltersBar({
    super.key,
    required this.selectedFilter,
    required this.onFilterSelected,
  });

  final RecommendationFilter selectedFilter;
  final ValueChanged<RecommendationFilter> onFilterSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const BouncingScrollPhysics(),
      child: Row(
        children: RecommendationFilter.values.map((filter) {
          final isSelected = filter == selectedFilter;
          return Padding(
            padding: const EdgeInsets.only(right: PreBiteSpacing.sm),
            child: InkWell(
              onTap: () => onFilterSelected(filter),
              borderRadius: PreBiteRadius.chip,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? PreBiteColors.primary
                      : PreBiteColors.surface,
                  borderRadius: PreBiteRadius.chip,
                  border: Border.all(
                    color: isSelected
                        ? PreBiteColors.primary
                        : PreBiteColors.outlineVariant,
                    width: 1.0,
                  ),
                ),
                child: Text(
                  filter.label,
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: isSelected
                        ? PreBiteColors.onPrimary
                        : PreBiteColors.onSurfaceVariant,
                    fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
