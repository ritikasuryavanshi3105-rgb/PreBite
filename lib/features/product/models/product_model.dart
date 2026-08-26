import 'package:flutter/material.dart';

/// Rating level for ingredient or nutrition item
enum HealthLevel { good, excellent, neutral, moderate, concern, low }

/// Individual summary ingredient item
class IngredientSummaryItem {
  const IngredientSummaryItem({
    required this.name,
    this.isTrace = false,
    this.level = HealthLevel.good,
  });

  final String name;
  final bool isTrace;
  final HealthLevel level;
}

/// Detailed ingredient breakdown item
class DetailedIngredientItem {
  const DetailedIngredientItem({
    required this.name,
    required this.description,
    required this.statusLabel,
    required this.level,
    required this.iconData,
  });

  final String name;
  final String description;
  final String statusLabel;
  final HealthLevel level;
  final IconData iconData;
}

/// Nutrition table row item
class NutritionTableItem {
  const NutritionTableItem({
    required this.name,
    required this.amount,
    this.unit = '',
    this.tag,
    this.tagLevel,
    this.isIndented = false,
  });

  final String name;
  final String amount;
  final String unit;
  final String? tag;
  final HealthLevel? tagLevel;
  final bool isIndented;

  String get displayValue => unit.isNotEmpty ? '$amount $unit' : amount;
}

/// Nutrition highlight card item
class NutritionHighlightItem {
  const NutritionHighlightItem({
    required this.label,
    required this.iconData,
    this.isNeutral = false,
  });

  final String label;
  final IconData iconData;
  final bool isNeutral;
}

/// Comprehensive Product Detail Model
class ProductDetailModel {
  const ProductDetailModel({
    required this.id,
    required this.name,
    required this.brand,
    required this.category,
    required this.weight,
    required this.imageAsset,
    required this.score,
    this.maxScore = 10.0,
    required this.scoreLabel,
    required this.scoreSummary,
    required this.verdictTitle,
    required this.verdictDescription,
    required this.nutritionScore,
    required this.ingredientsScore,
    required this.personalFitScore,
    required this.whyScoresWell,
    required this.ingredientSummary,
    required this.ingredientCount,
    required this.goodIngredientCount,
    required this.neutralIngredientCount,
    required this.concernIngredientCount,
    required this.forYouMessage,
    required this.allergenInfo,
    required this.detailedIngredients,
    required this.nutritionScoreLabel,
    required this.nutritionPer100g,
    required this.nutritionPerServing,
    required this.servingLabel,
    required this.nutritionHighlights,
    required this.whatThisMeansForYou,
  });

  final String id;
  final String name;
  final String brand;
  final String category;
  final String weight;
  final String imageAsset;
  final double score;
  final double maxScore;
  final String scoreLabel;
  final String scoreSummary;
  final String verdictTitle;
  final String verdictDescription;
  final double nutritionScore;
  final double ingredientsScore;
  final double personalFitScore;
  final List<String> whyScoresWell;
  final List<IngredientSummaryItem> ingredientSummary;
  final int ingredientCount;
  final int goodIngredientCount;
  final int neutralIngredientCount;
  final int concernIngredientCount;
  final String forYouMessage;
  final String allergenInfo;
  final List<DetailedIngredientItem> detailedIngredients;
  final String nutritionScoreLabel;
  final List<NutritionTableItem> nutritionPer100g;
  final List<NutritionTableItem> nutritionPerServing;
  final String servingLabel;
  final List<NutritionHighlightItem> nutritionHighlights;
  final String whatThisMeansForYou;
}
