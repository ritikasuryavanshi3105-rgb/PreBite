import '../models/comparison_model.dart';

/// PreBite Mock Comparison Data
/// Implements data source matching Stitch `product_comparison/code.html` and `screen.png`.
abstract final class MockComparisonData {
  static const ProductComparisonData defaultComparison = ProductComparisonData(
    product1: ComparisonProductItem(
      id: 'amul-masti-dahi',
      brand: 'AMUL',
      name: 'Masti Dahi',
      weight: '400g Cup',
      imageAsset: 'assets/images/products/amul_masti_dahi.jpg',
      score: 9.1,
      badgeLabel: 'Excellent Choice',
      isWinner: true,
    ),
    product2: ComparisonProductItem(
      id: 'mother-dairy-400',
      brand: 'MOTHER DAIRY',
      name: 'Classic Curd',
      weight: '400g Cup',
      imageAsset: 'assets/images/products/mother_dairy.jpg',
      score: 8.8,
      badgeLabel: 'Great Choice',
      isWinner: false,
    ),
    winnerTitle: 'Amul Masti Dahi',
    winnerDescription:
        'With a higher PreBite score of 9.1 and slightly better protein-to-fat ratio, this is the optimal choice.',
    atAGlanceMetrics: [
      ComparisonMetricRow(
        metric: 'Score',
        product1Value: '9.1',
        product2Value: '8.8',
        product1IsBetter: true,
      ),
      ComparisonMetricRow(
        metric: 'Protein',
        product1Value: '3.1g',
        product2Value: '3.0g',
        product1IsBetter: true,
      ),
      ComparisonMetricRow(
        metric: 'Added Sugar',
        product1Value: '0g',
        product2Value: '0g',
      ),
      ComparisonMetricRow(
        metric: 'Total Fat',
        product1Value: '3.0g',
        product2Value: '3.5g',
        product1IsBetter: true,
      ),
    ],
    detailedNutrients: [
      ComparisonNutrientRow(
        nutrient: 'Calories',
        product1Value: '61 kcal',
        product2Value: '65 kcal',
        indentLevel: 0,
      ),
      ComparisonNutrientRow(
        nutrient: 'Protein',
        product1Value: '3.1 g',
        product2Value: '3.0 g',
        indentLevel: 1,
        product1IsBetter: true,
      ),
      ComparisonNutrientRow(
        nutrient: 'Carbohydrates',
        product1Value: '4.5 g',
        product2Value: '4.8 g',
        indentLevel: 0,
      ),
      ComparisonNutrientRow(
        nutrient: 'Total Sugars',
        product1Value: '4.5 g',
        product2Value: '4.8 g',
        indentLevel: 1,
      ),
      ComparisonNutrientRow(
        nutrient: 'Added Sugars',
        product1Value: '0 g',
        product2Value: '0 g',
        indentLevel: 2,
      ),
      ComparisonNutrientRow(
        nutrient: 'Total Fat',
        product1Value: '3.0 g',
        product2Value: '3.5 g',
        indentLevel: 0,
        product1IsBetter: true,
      ),
      ComparisonNutrientRow(
        nutrient: 'Saturated Fat',
        product1Value: '2.0 g',
        product2Value: '2.3 g',
        indentLevel: 1,
      ),
      ComparisonNutrientRow(
        nutrient: 'Sodium',
        product1Value: '45 mg',
        product2Value: '50 mg',
        indentLevel: 0,
        product1IsBetter: true,
      ),
      ComparisonNutrientRow(
        nutrient: 'Calcium',
        product1Value: '120 mg',
        product2Value: '120 mg',
        indentLevel: 0,
      ),
    ],
    recommendationText:
        'Both products offer a simple, clean ingredient profile consisting solely of pasteurized milk and active cultures. Amul Masti Dahi edges out as the better option due to slightly lower total fat and sodium content, resulting in a superior PreBite score.',
  );
}
