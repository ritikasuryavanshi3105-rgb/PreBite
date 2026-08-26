import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../core/routing/route_paths.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/radius.dart';
import '../../../core/theme/shadows.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../../../shared/widgets/prebite_button.dart';

/// "Our Recommendation" Card & Final Actions
class ComparisonRecommendationCard extends StatefulWidget {
  const ComparisonRecommendationCard({
    super.key,
    required this.recommendationText,
    required this.winnerProductId,
    required this.winnerProductName,
  });

  final String recommendationText;
  final String winnerProductId;
  final String winnerProductName;

  @override
  State<ComparisonRecommendationCard> createState() =>
      _ComparisonRecommendationCardState();
}

class _ComparisonRecommendationCardState
    extends State<ComparisonRecommendationCard> {
  bool _isFavorited = false;

  void _toggleFavorite() {
    setState(() {
      _isFavorited = !_isFavorited;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFavorited
              ? 'Added ${widget.winnerProductName} to Favorites!'
              : 'Removed from Favorites.',
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.surface,
        borderRadius: PreBiteRadius.card,
        border: Border.all(color: PreBiteColors.surfaceVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      padding: PreBiteSpacing.allLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Our Recommendation',
            textAlign: TextAlign.center,
            style: PreBiteTypography.titleLarge.copyWith(
              color: PreBiteColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: PreBiteSpacing.md),
          Text(
            widget.recommendationText,
            textAlign: TextAlign.center,
            style: PreBiteTypography.bodyLarge.copyWith(
              color: PreBiteColors.onSurfaceVariant,
              height: 1.45,
            ),
          ),
          const SizedBox(height: PreBiteSpacing.lg),
          // Action Buttons
          Row(
            children: [
              Expanded(
                child: PreBiteButton(
                  text: 'View Amul Details',
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: PreBiteColors.onPrimary,
                    size: 18,
                  ),
                  onPressed: () => context.go(
                    PreBiteRoutes.productOverviewPath(widget.winnerProductId),
                  ),
                  variant: PreBiteButtonVariant.primary,
                  size: PreBiteButtonSize.medium,
                ),
              ),
            ],
          ),
          const SizedBox(height: PreBiteSpacing.sm),
          Row(
            children: [
              Expanded(
                child: PreBiteButton(
                  text: _isFavorited ? 'Favorited' : 'Add to Favorites',
                  icon: Icon(
                    _isFavorited ? Icons.favorite : Icons.favorite_border,
                    color: PreBiteColors.primary,
                    size: 18,
                  ),
                  onPressed: _toggleFavorite,
                  variant: PreBiteButtonVariant.secondary,
                  size: PreBiteButtonSize.medium,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
