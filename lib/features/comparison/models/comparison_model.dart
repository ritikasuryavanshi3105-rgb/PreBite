/// Comparison Product Item Model
class ComparisonProductItem {
  const ComparisonProductItem({
    required this.id,
    required this.brand,
    required this.name,
    required this.weight,
    required this.imageAsset,
    required this.score,
    required this.badgeLabel,
    this.isWinner = false,
  });

  final String id;
  final String brand;
  final String name;
  final String weight;
  final String imageAsset;
  final double score;
  final String badgeLabel;
  final bool isWinner;
}

/// Comparison Metric Row for "At a Glance"
class ComparisonMetricRow {
  const ComparisonMetricRow({
    required this.metric,
    required this.product1Value,
    required this.product2Value,
    this.product1IsBetter = false,
    this.product2IsBetter = false,
  });

  final String metric;
  final String product1Value;
  final String product2Value;
  final bool product1IsBetter;
  final bool product2IsBetter;
}

/// Comparison Detailed Nutrient Row
class ComparisonNutrientRow {
  const ComparisonNutrientRow({
    required this.nutrient,
    required this.product1Value,
    required this.product2Value,
    this.indentLevel = 0,
    this.product1IsBetter = false,
    this.product2IsBetter = false,
  });

  final String nutrient;
  final String product1Value;
  final String product2Value;
  final int indentLevel; // 0: root, 1: sub-item, 2: detail sub-item
  final bool product1IsBetter;
  final bool product2IsBetter;
}

/// Complete Comparison Data Model
class ProductComparisonData {
  const ProductComparisonData({
    required this.product1,
    required this.product2,
    required this.winnerTitle,
    required this.winnerDescription,
    required this.atAGlanceMetrics,
    required this.detailedNutrients,
    required this.recommendationText,
  });

  final ComparisonProductItem product1;
  final ComparisonProductItem product2;
  final String winnerTitle;
  final String winnerDescription;
  final List<ComparisonMetricRow> atAGlanceMetrics;
  final List<ComparisonNutrientRow> detailedNutrients;
  final String recommendationText;
}
