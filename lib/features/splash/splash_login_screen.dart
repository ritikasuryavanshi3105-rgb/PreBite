import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_paths.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/shadows.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../shared/widgets/prebite_button.dart';

/// Product representation for Top Picks carousel on Splash/Login screen
class SplashTopPickItem {
  const SplashTopPickItem({
    required this.id,
    required this.name,
    required this.weight,
    required this.score,
    required this.scoreLabel,
    required this.isGoodScore,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final String weight;
  final double score;
  final String scoreLabel;
  final bool isGoodScore;
  final String imageAsset;
}

/// PreBite Splash / Login Screen
/// Implements Stitch visual source-of-truth from `splash_login/code.html` and `screen.png`.
class SplashLoginScreen extends StatelessWidget {
  const SplashLoginScreen({super.key});

  static const List<SplashTopPickItem> _topPicks = [
    SplashTopPickItem(
      id: 'amul-masti-dahi',
      name: 'Amul Masti Dahi',
      weight: '400g',
      score: 9.1,
      scoreLabel: 'Good',
      isGoodScore: true,
      imageAsset: 'assets/images/products/amul_masti_dahi.jpg',
    ),
    SplashTopPickItem(
      id: 'mother-dairy-400',
      name: 'Mother Dairy',
      weight: '400g',
      score: 8.4,
      scoreLabel: 'Good',
      isGoodScore: true,
      imageAsset: 'assets/images/products/mother_dairy.jpg',
    ),
    SplashTopPickItem(
      id: 'quaker-oats-500',
      name: 'Quaker Oats',
      weight: '500g',
      score: 8.2,
      scoreLabel: 'Good',
      isGoodScore: true,
      imageAsset: 'assets/images/products/quaker_oats.jpg',
    ),
    SplashTopPickItem(
      id: 'hersheys-syrup-400',
      name: "Hershey's Syrup",
      weight: '400g',
      score: 6.8,
      scoreLabel: 'Average',
      isGoodScore: false,
      imageAsset: 'assets/images/products/hersheys_syrup.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreBiteColors.surfaceContainerLowest,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 420),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: PreBiteSpacing.md),
                      _buildBrandingSection(),
                      const SizedBox(height: PreBiteSpacing.lg),
                      _buildIntroSection(),
                      const SizedBox(height: PreBiteSpacing.lg),
                      _buildIllustrationSection(),
                      const SizedBox(height: PreBiteSpacing.xl),
                      _buildActionButtons(context),
                      const SizedBox(height: PreBiteSpacing.xl),
                      _buildTopPicksHeader(context),
                      const SizedBox(height: PreBiteSpacing.sm),
                      _buildTopPicksCarousel(context),
                      const SizedBox(height: PreBiteSpacing.xl),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildBrandingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.lg),
      child: Column(
        children: [
          Image.asset(
            'stitch_prebite_mobile_ui_design/prebite_logo/screen.png',
            height: 52,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.eco, color: PreBiteColors.primary, size: 32),
                const SizedBox(width: 8),
                Text(
                  'PreBite',
                  style: PreBiteTypography.headlineLarge.copyWith(
                    color: PreBiteColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Know Before You Bite',
            style: PreBiteTypography.bodyMedium.copyWith(
              color: PreBiteColors.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIntroSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.lg),
      child: Column(
        children: [
          Text(
            'Scan. Analyze. Decide.',
            style: PreBiteTypography.headlineLargeMobile.copyWith(
              color: PreBiteColors.onSurface,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Make healthier choices for you and your family.',
            style: PreBiteTypography.bodyMedium.copyWith(
              color: PreBiteColors.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildIllustrationSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.lg),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 240, maxHeight: 240),
          child: AspectRatio(
            aspectRatio: 1.0,
            child: Image.asset(
              'stitch_prebite_mobile_ui_design/a_clean_modern_friendly_flat_illustration_of_healthy_foods_a_bowl_of_fresh/screen.png',
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                decoration: BoxDecoration(
                  color: PreBiteColors.surfaceContainerLow,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.restaurant_rounded,
                  size: 64,
                  color: PreBiteColors.primary,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.lg),
      child: Column(
        children: [
          PreBiteButton(
            text: 'Log In',
            isFullWidth: true,
            variant: PreBiteButtonVariant.primary,
            onPressed: () => context.go(PreBiteRoutes.home),
          ),
          const SizedBox(height: PreBiteSpacing.sm),
          PreBiteButton(
            text: 'Sign Up',
            isFullWidth: true,
            variant: PreBiteButtonVariant.outline,
            onPressed: () => context.go(PreBiteRoutes.home),
          ),
          const SizedBox(height: PreBiteSpacing.xs),
          TextButton(
            onPressed: () => context.go(PreBiteRoutes.home),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            ),
            child: Text(
              'Continue as Guest',
              style: PreBiteTypography.labelMedium.copyWith(
                color: PreBiteColors.onSurfaceVariant,
                decoration: TextDecoration.underline,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPicksHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.lg),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              'Top Picks For You',
              style: PreBiteTypography.titleLarge.copyWith(
                fontWeight: FontWeight.w700,
                color: PreBiteColors.onSurface,
              ),
            ),
          ),
          GestureDetector(
            onTap: () => context.go(PreBiteRoutes.recommendations),
            child: Text(
              'View All',
              style: PreBiteTypography.labelMedium.copyWith(
                color: PreBiteColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopPicksCarousel(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.lg),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _topPicks.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: PreBiteSpacing.sm),
        itemBuilder: (context, index) {
          final item = _topPicks[index];
          return _buildTopPickCard(context, item);
        },
      ),
    );
  }

  Widget _buildTopPickCard(BuildContext context, SplashTopPickItem item) {
    return Container(
      width: 164,
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: PreBiteRadius.md,
        border: Border.all(color: PreBiteColors.outlineVariant, width: 1.0),
        boxShadow: PreBiteShadows.bloom,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: PreBiteRadius.md,
        child: InkWell(
          onTap: () => context.go(PreBiteRoutes.productOverviewPath(item.id)),
          borderRadius: PreBiteRadius.md,
          child: Padding(
            padding: const EdgeInsets.all(PreBiteSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Thumbnail Container
                Container(
                  width: double.infinity,
                  height: 90,
                  decoration: BoxDecoration(
                    color: PreBiteColors.surfaceContainerLow,
                    borderRadius: PreBiteRadius.defaultBorderRadius,
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Image.asset(
                    item.imageAsset,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: PreBiteColors.surfaceContainerLow),
                  ),
                ),
                const SizedBox(height: PreBiteSpacing.xs),
                Text(
                  item.name,
                  style: PreBiteTypography.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                    color: PreBiteColors.onSurface,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  item.weight,
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: PreBiteColors.onSurfaceVariant,
                  ),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.only(top: 6),
                  decoration: const BoxDecoration(
                    border: Border(
                      top: BorderSide(color: Color(0x4Dbecabc), width: 1.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            item.isGoodScore ? Icons.star : Icons.star_half,
                            size: 13,
                            color: item.isGoodScore
                                ? PreBiteColors.primary
                                : PreBiteColors.tertiary,
                          ),
                          const SizedBox(width: 2),
                          Text(
                            '${item.score}/10',
                            style: PreBiteTypography.labelMedium.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: PreBiteColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: item.isGoodScore
                              ? PreBiteColors.primaryContainer
                              : PreBiteColors.surfaceVariant,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          item.scoreLabel,
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: item.isGoodScore
                                ? PreBiteColors.onPrimaryContainer
                                : PreBiteColors.onSurfaceVariant,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
