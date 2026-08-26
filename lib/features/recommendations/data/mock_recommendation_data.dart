import 'package:flutter/material.dart';

import '../models/recommendation_model.dart';

/// PreBite Mock Recommendation Repository
/// Matches Stitch `recommendations_best_picks/code.html` and `screen.png`.
abstract final class MockRecommendationData {
  static const List<RecommendedProductItem> recommendations = [
    // 1. Amul Masti Dahi
    RecommendedProductItem(
      id: 'amul-masti-dahi',
      name: 'Amul Masti Dahi',
      brand: 'Amul',
      score: 9.1,
      badgeLabel: 'Excellent Choice',
      imageAsset: 'assets/images/products/amul_masti_dahi.jpg',
      highlights: [
        RecommendationHighlight(text: 'No added sugar'),
        RecommendationHighlight(text: 'Good protein'),
        RecommendationHighlight(text: 'Good calcium'),
      ],
      filters: [
        RecommendationFilter.all,
        RecommendationFilter.topRated,
        RecommendationFilter.lowSugar,
        RecommendationFilter.highProtein,
        RecommendationFilter.forFamily,
      ],
    ),
    // 2. Mother Dairy Classic Curd
    RecommendedProductItem(
      id: 'mother-dairy-400',
      name: 'Mother Dairy Classic Curd',
      brand: 'Mother Dairy',
      score: 8.8,
      badgeLabel: 'Great Choice',
      imageAsset: 'assets/images/products/mother_dairy.jpg',
      highlights: [
        RecommendationHighlight(text: 'Good protein'),
        RecommendationHighlight(text: 'Moderate fat'),
        RecommendationHighlight(text: 'Simple ingredients'),
      ],
      filters: [
        RecommendationFilter.all,
        RecommendationFilter.topRated,
        RecommendationFilter.highProtein,
        RecommendationFilter.forFamily,
      ],
    ),
    // 3. Quaker Oats
    RecommendedProductItem(
      id: 'quaker-oats-500',
      name: 'Quaker Oats',
      brand: 'Quaker',
      score: 8.2,
      badgeLabel: 'Good Choice',
      imageAsset: 'assets/images/products/quaker_oats.jpg',
      highlights: [
        RecommendationHighlight(text: 'High fiber'),
        RecommendationHighlight(text: 'Low added sugar'),
        RecommendationHighlight(text: 'Good whole grains'),
      ],
      filters: [
        RecommendationFilter.all,
        RecommendationFilter.lowSugar,
        RecommendationFilter.forFamily,
      ],
    ),
    // 4. Nestlé a+ Milk
    RecommendedProductItem(
      id: 'nestle-milk',
      name: 'Nestlé a+ Milk',
      brand: 'Nestlé',
      score: 8.0,
      badgeLabel: 'Good Choice',
      imageAsset: 'assets/images/products/amul_masti_dahi.jpg',
      highlights: [
        RecommendationHighlight(text: 'Good protein'),
        RecommendationHighlight(text: 'Calcium'),
        RecommendationHighlight(text: 'Simple ingredients'),
      ],
      filters: [
        RecommendationFilter.all,
        RecommendationFilter.highProtein,
        RecommendationFilter.lowSodium,
        RecommendationFilter.forFamily,
      ],
    ),
    // 5. Hershey's Syrup
    RecommendedProductItem(
      id: 'hersheys-syrup-400',
      name: "Hershey's Syrup",
      brand: "Hershey's",
      score: 6.8,
      badgeLabel: 'Occasional Choice',
      imageAsset: 'assets/images/products/hersheys_syrup.jpg',
      isOccasional: true,
      highlights: [
        RecommendationHighlight(
          text: 'Higher added sugar',
          isPositive: false,
          icon: Icons.warning_amber_rounded,
        ),
        RecommendationHighlight(
          text: 'Use in moderation',
          isPositive: false,
          icon: Icons.info_outline,
        ),
      ],
      filters: [RecommendationFilter.all],
    ),
  ];
}
