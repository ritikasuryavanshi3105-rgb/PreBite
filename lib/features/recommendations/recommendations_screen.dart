import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_paths.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../../shared/widgets/prebite_app_bar.dart';
import 'data/mock_recommendation_data.dart';
import 'models/recommendation_model.dart';
import 'widgets/recommendation_filters_bar.dart';
import 'widgets/recommendation_product_card.dart';
import 'widgets/recommendation_summary_card.dart';

/// PreBite Recommendations & Best Picks Screen
/// Route: `/recommendations`
/// Matches Stitch visual source of truth from `recommendations_best_picks/code.html` and `screen.png`.
class RecommendationsScreen extends StatefulWidget {
  const RecommendationsScreen({super.key});

  @override
  State<RecommendationsScreen> createState() => _RecommendationsScreenState();
}

class _RecommendationsScreenState extends State<RecommendationsScreen> {
  RecommendationFilter _selectedFilter = RecommendationFilter.all;

  List<RecommendedProductItem> get _filteredProducts {
    if (_selectedFilter == RecommendationFilter.all) {
      return MockRecommendationData.recommendations;
    }
    return MockRecommendationData.recommendations
        .where((item) => item.filters.contains(_selectedFilter))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = _filteredProducts;

    return Scaffold(
      backgroundColor: PreBiteColors.background,
      appBar: PreBiteAppBar(
        title: 'PreBite',
        showBackButton: false,
        foregroundColor: PreBiteColors.primary,
        leading: const Icon(Icons.eco, color: PreBiteColors.primary, size: 28),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            color: PreBiteColors.onSurfaceVariant,
            tooltip: 'Search',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search recommendations...'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            color: PreBiteColors.onSurfaceVariant,
            tooltip: 'Filter',
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Advanced recommendation filters...'),
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
                  _buildHeaderIntro(),
                  const SizedBox(height: PreBiteSpacing.md),
                  const RecommendationSummaryCard(),
                  const SizedBox(height: PreBiteSpacing.md),
                  RecommendationFiltersBar(
                    selectedFilter: _selectedFilter,
                    onFilterSelected: (filter) {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                  ),
                  const SizedBox(height: PreBiteSpacing.md),
                  _buildSortHeader(),
                  const SizedBox(height: PreBiteSpacing.md),
                  // Product list
                  ...products.map(
                    (product) => Padding(
                      padding: const EdgeInsets.only(bottom: PreBiteSpacing.lg),
                      child: RecommendationProductCard(product: product),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  /// Header & Intro Section
  Widget _buildHeaderIntro() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: PreBiteSpacing.xs),
        Text(
          'Recommendations',
          style: PreBiteTypography.headlineLargeMobile.copyWith(
            color: PreBiteColors.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Best Recommendations For You',
          style: PreBiteTypography.titleLarge.copyWith(
            color: PreBiteColors.onSurface,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Products selected based on your preferences, nutrition profile and PreBite score.',
          style: PreBiteTypography.bodyMedium.copyWith(
            color: PreBiteColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Sort and Count Header
  Widget _buildSortHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'RECOMMENDED FOR YOU',
          style: PreBiteTypography.labelMedium.copyWith(
            color: PreBiteColors.onSurfaceVariant,
            letterSpacing: 0.8,
            fontWeight: FontWeight.w600,
          ),
        ),
        InkWell(
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Sorting options: Score (High to Low)'),
                duration: Duration(seconds: 1),
              ),
            );
          },
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sort',
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: PreBiteColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Icon(
                  Icons.expand_more,
                  size: 18,
                  color: PreBiteColors.primary,
                ),
              ],
            ),
          ),
        ),
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
            // Analysis (Active Pill)
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
