import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_paths.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../shared/widgets/prebite_app_bar.dart';
import 'data/mock_comparison_data.dart';
import 'models/comparison_model.dart';
import 'widgets/comparison_nutrition_table.dart';
import 'widgets/comparison_product_card.dart';
import 'widgets/comparison_recommendation_card.dart';
import 'widgets/comparison_summary_table.dart';
import 'widgets/comparison_winner_banner.dart';

/// PreBite Product Comparison Screen
/// Route: `/compare`
/// Implements the Stitch visual source of truth from `product_comparison/code.html` and `screen.png`.
class ProductComparisonScreen extends StatefulWidget {
  const ProductComparisonScreen({super.key, this.comparisonData});

  final ProductComparisonData? comparisonData;

  @override
  State<ProductComparisonScreen> createState() =>
      _ProductComparisonScreenState();
}

class _ProductComparisonScreenState extends State<ProductComparisonScreen> {
  late ProductComparisonData _data;

  @override
  void initState() {
    super.initState();
    _data = widget.comparisonData ?? MockComparisonData.defaultComparison;
  }

  void _handleBack(BuildContext context) {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      context.go(PreBiteRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreBiteColors.background,
      appBar: PreBiteAppBar(
        title: 'Compare Products',
        showBackButton: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: PreBiteColors.onSurfaceVariant,
          onPressed: () => _handleBack(context),
          tooltip: 'Back',
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: PreBiteColors.onSurfaceVariant,
            tooltip: 'Search',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search and add products to compare...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.only(
            left: PreBiteSpacing.marginMobile,
            right: PreBiteSpacing.marginMobile,
            top: PreBiteSpacing.sm,
            bottom: PreBiteSpacing.xl,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 720),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildIntroSection(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  _buildProductGrid(),
                  const SizedBox(height: PreBiteSpacing.lg),
                  ComparisonWinnerBanner(
                    winnerTitle: _data.winnerTitle,
                    winnerDescription: _data.winnerDescription,
                  ),
                  const SizedBox(height: PreBiteSpacing.lg),
                  ComparisonSummaryTable(
                    metrics: _data.atAGlanceMetrics,
                    product1Name: _data.product1.brand,
                    product2Name: _data.product2.brand,
                  ),
                  const SizedBox(height: PreBiteSpacing.lg),
                  ComparisonNutritionTable(
                    nutrients: _data.detailedNutrients,
                    product1Name: _data.product1.brand,
                    product2Name: _data.product2.brand,
                  ),
                  const SizedBox(height: PreBiteSpacing.lg),
                  ComparisonRecommendationCard(
                    recommendationText: _data.recommendationText,
                    winnerProductId: _data.product1.id,
                    winnerProductName: _data.product1.name,
                  ),
                  const SizedBox(height: PreBiteSpacing.lg),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  /// Intro Header Section
  Widget _buildIntroSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: PreBiteSpacing.xs),
        Text(
          'Compare Products',
          style: PreBiteTypography.headlineLargeMobile.copyWith(
            color: PreBiteColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'See which product is the better choice for you.',
          style: PreBiteTypography.bodyLarge.copyWith(
            color: PreBiteColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Side-by-Side Product Cards Grid
  Widget _buildProductGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: ComparisonProductCard(product: _data.product1)),
        const SizedBox(width: PreBiteSpacing.md),
        Expanded(child: ComparisonProductCard(product: _data.product2)),
      ],
    );
  }

  /// Bottom Navigation Bar with Analysis Active
  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        border: Border(
          top: BorderSide(color: PreBiteColors.surfaceVariant, width: 1.0),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Home
            _buildNavItem(
              context: context,
              icon: Icons.home_outlined,
              label: 'Home',
              onTap: () => context.go(PreBiteRoutes.home),
            ),
            // Scan
            _buildNavItem(
              context: context,
              icon: Icons.qr_code_scanner_rounded,
              label: 'Scan',
              onTap: () => context.go(PreBiteRoutes.scanner),
            ),
            // Analysis (Active)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: PreBiteColors.secondaryContainer,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.analytics,
                    color: PreBiteColors.onSecondaryContainer,
                    size: 20,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'Analysis',
                    style: PreBiteTypography.labelMedium.copyWith(
                      color: PreBiteColors.onSecondaryContainer,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
            // Profile
            _buildNavItem(
              context: context,
              icon: Icons.person_outline_rounded,
              label: 'Profile',
              onTap: () => context.go(PreBiteRoutes.profileSettings),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: PreBiteColors.onSurfaceVariant, size: 22),
            const SizedBox(height: 2),
            Text(
              label,
              style: PreBiteTypography.labelMedium.copyWith(
                color: PreBiteColors.onSurfaceVariant,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
