import 'package:flutter/material.dart';

/// Highlight item for a recommended product
class RecommendationHighlight {
  const RecommendationHighlight({
    required this.text,
    this.isPositive = true,
    this.icon,
  });

  final String text;
  final bool isPositive;
  final IconData? icon;
}

/// Category Filter Tag
enum RecommendationFilter {
  all('All'),
  topRated('Top Rated'),
  lowSugar('Low Sugar'),
  highProtein('High Protein'),
  lowSodium('Low Sodium'),
  forFamily('For Family');

  const RecommendationFilter(this.label);
  final String label;
}

/// Model for a recommended product card
class RecommendedProductItem {
  const RecommendedProductItem({
    required this.id,
    required this.name,
    required this.brand,
    required this.score,
    required this.badgeLabel,
    required this.imageAsset,
    required this.highlights,
    this.isOccasional = false,
    this.filters = const [RecommendationFilter.all],
  });

  final String id;
  final String name;
  final String brand;
  final double score;
  final String badgeLabel;
  final String imageAsset;
  final List<RecommendationHighlight> highlights;
  final bool isOccasional;
  final List<RecommendationFilter> filters;
}
