import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routing/route_paths.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/shadows.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

/// Top pick product item for Home Dashboard carousel
class HomeTopPickItem {
  const HomeTopPickItem({
    required this.id,
    required this.name,
    required this.weight,
    required this.score,
    required this.scoreLabel,
    required this.imageAsset,
  });

  final String id;
  final String name;
  final String weight;
  final double score;
  final String scoreLabel;
  final String imageAsset;
}

/// PreBite Home Dashboard Screen
/// Implements the Stitch Home Dashboard reference (`home_dashboard/code.html` and `screen.png`).
class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  static const List<HomeTopPickItem> _topPicks = [
    HomeTopPickItem(
      id: 'amul-masti-dahi',
      name: 'Amul Masti Dahi',
      weight: '400g',
      score: 9.1,
      scoreLabel: 'Good Choice',
      imageAsset: 'assets/images/products/home_amul_dahi.jpg',
    ),
    HomeTopPickItem(
      id: 'mother-dairy-400',
      name: 'Mother Dairy Dahi',
      weight: '400g',
      score: 8.4,
      scoreLabel: 'Good Choice',
      imageAsset: 'assets/images/products/home_mother_dairy.jpg',
    ),
    HomeTopPickItem(
      id: 'quaker-oats-500',
      name: 'Quaker Oats',
      weight: '500g',
      score: 8.2,
      scoreLabel: 'Good Choice',
      imageAsset: 'assets/images/products/home_quaker_oats.jpg',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreBiteColors.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildMobileHeader(context),
            Expanded(
              child: SingleChildScrollView(
                physics: const ClampingScrollPhysics(),
                padding: const EdgeInsets.only(bottom: PreBiteSpacing.xl),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: PreBiteSpacing.md,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: PreBiteSpacing.sm),
                          _buildGreetingSection(),
                          const SizedBox(height: PreBiteSpacing.md),
                          _buildSearchBar(),
                          const SizedBox(height: PreBiteSpacing.lg),
                          _buildHeroScanBanner(context),
                          const SizedBox(height: PreBiteSpacing.lg),
                          _buildQuickActionsBentoGrid(context),
                          const SizedBox(height: PreBiteSpacing.xl),
                          _buildTopPicksHeader(context),
                          const SizedBox(height: PreBiteSpacing.md),
                          _buildTopPicksCarousel(context),
                          const SizedBox(height: PreBiteSpacing.xl),
                          _buildHealthInsightCard(),
                          const SizedBox(height: PreBiteSpacing.lg),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  /// Mobile Top App Bar
  Widget _buildMobileHeader(BuildContext context) {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.md),
      decoration: const BoxDecoration(color: PreBiteColors.surface),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              color: PreBiteColors.onSurfaceVariant,
              size: 26,
            ),
            onPressed: () {},
            tooltip: 'Menu',
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
          Image.asset(
            'stitch_prebite_mobile_ui_design/prebite_logo/screen.png',
            height: 32,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.eco, color: PreBiteColors.primary, size: 24),
                const SizedBox(width: 4),
                Text(
                  'PreBite',
                  style: PreBiteTypography.titleLarge.copyWith(
                    color: PreBiteColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.notifications_none_rounded,
                      color: PreBiteColors.onSurfaceVariant,
                      size: 26,
                    ),
                    onPressed: () {},
                    tooltip: 'Notifications',
                    padding: const EdgeInsets.all(4),
                    constraints: const BoxConstraints(),
                  ),
                  Positioned(
                    top: 4,
                    right: 4,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: PreBiteColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: PreBiteSpacing.sm),
              GestureDetector(
                onTap: () => context.go(PreBiteRoutes.profileSettings),
                child: Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: PreBiteColors.surfaceContainerLow,
                    border: Border.all(
                      color: PreBiteColors.outlineVariant,
                      width: 1.0,
                    ),
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/avatars/riya_avatar.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.person_rounded,
                        size: 20,
                        color: PreBiteColors.primary,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Greeting Section
  Widget _buildGreetingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Good Morning, Riya!',
          style: PreBiteTypography.headlineLargeMobile.copyWith(
            color: PreBiteColors.onSurface,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: PreBiteSpacing.xs),
        Text(
          'Ready to make a healthier choice today?',
          style: PreBiteTypography.bodyMedium.copyWith(
            color: PreBiteColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  /// Search Bar
  Widget _buildSearchBar() {
    return Container(
      height: 52,
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: PreBiteColors.outlineVariant, width: 1.0),
        boxShadow: PreBiteShadows.soft,
      ),
      padding: const EdgeInsets.symmetric(horizontal: PreBiteSpacing.md),
      child: Row(
        children: [
          const Icon(
            Icons.search_rounded,
            color: PreBiteColors.onSurfaceVariant,
            size: 22,
          ),
          const SizedBox(width: PreBiteSpacing.sm),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search products, brands or ingredients',
                hintStyle: PreBiteTypography.bodyMedium.copyWith(
                  color: PreBiteColors.onSurfaceVariant,
                ),
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.zero,
              ),
              style: PreBiteTypography.bodyMedium.copyWith(
                color: PreBiteColors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Hero Banner ("Know Before You Bite")
  Widget _buildHeroScanBanner(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.primary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: PreBiteShadows.soft,
      ),
      padding: const EdgeInsets.all(PreBiteSpacing.lg),
      child: Stack(
        children: [
          // Background decorative watermark
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(
              Icons.qr_code_scanner_rounded,
              size: 130,
              color: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Know Before You Bite',
                style: PreBiteTypography.headlineMedium.copyWith(
                  color: PreBiteColors.onPrimary,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
              const SizedBox(height: PreBiteSpacing.xs),
              Text(
                "Scan a product barcode to instantly understand what's inside.",
                style: PreBiteTypography.bodyMedium.copyWith(
                  color: PreBiteColors.onPrimary.withValues(alpha: 0.9),
                ),
              ),
              const SizedBox(height: PreBiteSpacing.md),
              ElevatedButton.icon(
                onPressed: () => context.go(PreBiteRoutes.scanner),
                icon: const Icon(
                  Icons.qr_code_scanner_rounded,
                  size: 20,
                  color: PreBiteColors.primary,
                ),
                label: Text(
                  'Scan Barcode',
                  style: PreBiteTypography.button.copyWith(
                    color: PreBiteColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: PreBiteColors.surfaceContainerLowest,
                  foregroundColor: PreBiteColors.primary,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(borderRadius: PreBiteRadius.md),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// Quick Actions Bento Grid (2x2)
  Widget _buildQuickActionsBentoGrid(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cardWidth = (constraints.maxWidth - PreBiteSpacing.md) / 2;
        return Column(
          children: [
            Row(
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildBentoCard(
                    context: context,
                    icon: Icons.qr_code_scanner_rounded,
                    iconBgColor: PreBiteColors.secondaryContainer.withValues(
                      alpha: 0.5,
                    ),
                    iconColor: PreBiteColors.secondary,
                    label: 'Scan\nBarcode',
                    onTap: () => context.go(PreBiteRoutes.scanner),
                  ),
                ),
                const SizedBox(width: PreBiteSpacing.md),
                SizedBox(
                  width: cardWidth,
                  child: _buildBentoCard(
                    context: context,
                    icon: Icons.compare_arrows_rounded,
                    iconBgColor: PreBiteColors.surfaceContainerHighest,
                    iconColor: PreBiteColors.onSurfaceVariant,
                    label: 'Compare\nProducts',
                    onTap: () => context.go(PreBiteRoutes.productComparison),
                  ),
                ),
              ],
            ),
            const SizedBox(height: PreBiteSpacing.md),
            Row(
              children: [
                SizedBox(
                  width: cardWidth,
                  child: _buildBentoCard(
                    context: context,
                    icon: Icons.favorite_rounded,
                    iconBgColor: PreBiteColors.errorContainer.withValues(
                      alpha: 0.5,
                    ),
                    iconColor: PreBiteColors.error,
                    label: 'My\nFavorites',
                    onTap: () => context.go(PreBiteRoutes.favoritesHistory),
                  ),
                ),
                const SizedBox(width: PreBiteSpacing.md),
                SizedBox(
                  width: cardWidth,
                  child: _buildBentoCard(
                    context: context,
                    icon: Icons.history_rounded,
                    iconBgColor: PreBiteColors.surfaceContainerHighest,
                    iconColor: PreBiteColors.onSurfaceVariant,
                    label: 'Scan\nHistory',
                    onTap: () => context.go(PreBiteRoutes.favoritesHistory),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Widget _buildBentoCard({
    required BuildContext context,
    required IconData icon,
    required Color iconBgColor,
    required Color iconColor,
    required String label,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: PreBiteRadius.lg,
        border: Border.all(color: PreBiteColors.outlineVariant, width: 1.0),
        boxShadow: PreBiteShadows.soft,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: PreBiteRadius.lg,
        child: InkWell(
          onTap: onTap,
          borderRadius: PreBiteRadius.lg,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: PreBiteSpacing.lg,
              horizontal: PreBiteSpacing.sm,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 24, color: iconColor),
                ),
                const SizedBox(height: PreBiteSpacing.sm),
                Text(
                  label,
                  textAlign: TextAlign.center,
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: PreBiteColors.onSurface,
                    fontWeight: FontWeight.w600,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Top Picks Header
  Widget _buildTopPicksHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          'Top Picks For You',
          style: PreBiteTypography.titleLarge.copyWith(
            fontWeight: FontWeight.w700,
            color: PreBiteColors.onSurface,
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
    );
  }

  /// Top Picks Carousel
  Widget _buildTopPicksCarousel(BuildContext context) {
    return SizedBox(
      height: 230,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _topPicks.length,
        separatorBuilder: (context, index) =>
            const SizedBox(width: PreBiteSpacing.md),
        itemBuilder: (context, index) {
          final item = _topPicks[index];
          return _buildHomeProductCard(context, item);
        },
      ),
    );
  }

  /// Individual Product Card
  Widget _buildHomeProductCard(BuildContext context, HomeTopPickItem item) {
    return Container(
      width: 220,
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: PreBiteColors.outlineVariant, width: 1.0),
        boxShadow: PreBiteShadows.soft,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () => context.go(PreBiteRoutes.productOverviewPath(item.id)),
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Image container with Score Badge
              Container(
                height: 120,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: PreBiteColors.surfaceVariant,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          top: Radius.circular(15),
                        ),
                        child: Image.asset(
                          item.imageAsset,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Center(
                                child: Icon(
                                  Icons.shopping_bag_outlined,
                                  size: 40,
                                  color: PreBiteColors.onSurfaceVariant,
                                ),
                              ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: PreBiteColors.secondary,
                          borderRadius: BorderRadius.circular(999),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x33000000),
                              blurRadius: 4,
                              offset: Offset(0, 1),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 13,
                              color: PreBiteColors.onSecondary,
                            ),
                            const SizedBox(width: 3),
                            Text(
                              item.score.toStringAsFixed(1),
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                                color: PreBiteColors.onSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Body
              Padding(
                padding: const EdgeInsets.all(PreBiteSpacing.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: PreBiteTypography.titleLarge.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: PreBiteColors.onSurface,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 2),
                    Text(
                      item.weight,
                      style: PreBiteTypography.bodyMedium.copyWith(
                        color: PreBiteColors.onSurfaceVariant,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.only(top: 8),
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(
                            color: PreBiteColors.surfaceVariant,
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 16,
                            color: PreBiteColors.secondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            item.scoreLabel,
                            style: PreBiteTypography.labelMedium.copyWith(
                              color: PreBiteColors.secondary,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
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
        ),
      ),
    );
  }

  /// Health Insight Card
  Widget _buildHealthInsightCard() {
    return Container(
      decoration: BoxDecoration(
        color: PreBiteColors.secondaryContainer.withValues(alpha: 0.3),
        borderRadius: PreBiteRadius.md,
        border: Border.all(color: PreBiteColors.secondaryContainer, width: 1.0),
      ),
      padding: const EdgeInsets.all(PreBiteSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: PreBiteColors.secondaryContainer,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.spa_rounded,
              color: PreBiteColors.onSecondaryContainer,
              size: 22,
            ),
          ),
          const SizedBox(width: PreBiteSpacing.md),
          Expanded(
            child: Text(
              'Choose products with less added sugar and more protein to support healthier everyday choices.',
              style: PreBiteTypography.bodyMedium.copyWith(
                color: PreBiteColors.onSurface,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom Navigation Bar (Matching Stitch navigation bar)
  Widget _buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: PreBiteColors.surfaceContainerLowest,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
        border: const Border(
          top: BorderSide(color: PreBiteColors.outlineVariant, width: 1.0),
        ),
        boxShadow: PreBiteShadows.soft,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          // Home (Active)
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
                  Icons.home_rounded,
                  color: PreBiteColors.onSecondaryContainer,
                  size: 22,
                ),
                const SizedBox(width: 6),
                Text(
                  'Home',
                  style: PreBiteTypography.labelMedium.copyWith(
                    color: PreBiteColors.onSecondaryContainer,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          // Scan
          _buildNavItem(
            context: context,
            icon: Icons.qr_code_scanner_rounded,
            label: 'Scan',
            onTap: () => context.go(PreBiteRoutes.scanner),
          ),
          // Analysis
          _buildNavItem(
            context: context,
            icon: Icons.analytics_outlined,
            label: 'Analysis',
            onTap: () => context.go(PreBiteRoutes.recommendations),
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
