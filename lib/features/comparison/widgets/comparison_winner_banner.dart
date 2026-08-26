import 'package:flutter/material.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/shadows.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';

/// "Best Choice For You" Winner Banner
class ComparisonWinnerBanner extends StatelessWidget {
  const ComparisonWinnerBanner({
    super.key,
    required this.winnerTitle,
    required this.winnerDescription,
  });

  final String winnerTitle;
  final String winnerDescription;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.secondaryContainer,
        borderRadius: PreBiteRadius.button,
        boxShadow: PreBiteShadows.bloom,
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          // Background watermark medal
          Positioned(
            right: -20,
            top: -20,
            child: Opacity(
              opacity: 0.15,
              child: Icon(
                Icons.workspace_premium,
                size: 160,
                color: PreBiteColors.primary,
              ),
            ),
          ),
          // Content
          Padding(
            padding: PreBiteSpacing.allLg,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Green circle check icon
                Container(
                  width: 52,
                  height: 52,
                  decoration: const BoxDecoration(
                    color: PreBiteColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: PreBiteColors.onPrimary,
                    size: 30,
                  ),
                ),
                const SizedBox(width: PreBiteSpacing.md),
                // Texts
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'BEST CHOICE FOR YOU',
                        style: PreBiteTypography.labelMedium.copyWith(
                          color: PreBiteColors.onSecondaryContainer,
                          letterSpacing: 1.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        winnerTitle,
                        style: PreBiteTypography.headlineMedium.copyWith(
                          color: PreBiteColors.onSurface,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        winnerDescription,
                        style: PreBiteTypography.bodyMedium.copyWith(
                          color: PreBiteColors.onSecondaryContainer,
                          height: 1.3,
                        ),
                      ),
                    ],
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
