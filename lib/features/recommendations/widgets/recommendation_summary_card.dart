import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/shadows.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';

/// "Made For You" Summary Card
class RecommendationSummaryCard extends StatelessWidget {
  const RecommendationSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.secondaryContainer,
        borderRadius: PreBiteRadius.button,
        border: Border.all(
          color: PreBiteColors.outlineVariant.withValues(alpha: 0.2),
          width: 1.0,
        ),
        boxShadow: PreBiteShadows.bloom,
      ),
      padding: PreBiteSpacing.allMd,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon Container
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PreBiteColors.surface.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.health_and_safety,
              color: PreBiteColors.primary,
              size: 24,
            ),
          ),
          const SizedBox(width: PreBiteSpacing.sm),
          // Text Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Made For You',
                  style: PreBiteTypography.titleLarge.copyWith(
                    color: PreBiteColors.onSecondaryContainer,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'These products match your current preferences and health goals.',
                  style: PreBiteTypography.bodyMedium.copyWith(
                    color: PreBiteColors.onSecondaryContainer,
                    height: 1.35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
