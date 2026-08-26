import 'package:flutter/material.dart';
import '../models/product_model.dart';

/// PreBite Mock Product Repository
/// Supplies comprehensive, realistic product data based on the Stitch UI source of truth.
abstract final class MockProductRepository {
  static const ProductDetailModel amulMastiDahi = ProductDetailModel(
    id: 'amul-masti-dahi',
    name: 'Amul Masti Dahi',
    brand: 'Amul',
    category: 'Dairy / Curd',
    weight: '400g',
    imageAsset: 'assets/images/products/amul_masti_dahi.jpg',
    score: 9.1,
    maxScore: 10.0,
    scoreLabel: 'Good Choice',
    scoreSummary: 'A healthy everyday option based on your preferences.',
    verdictTitle: 'Good Choice For You',
    verdictDescription:
        'This product matches your current food preferences and has a strong overall PreBite score.',
    nutritionScore: 9.0,
    ingredientsScore: 9.2,
    personalFitScore: 9.1,
    whyScoresWell: ['Low Added Sugar', 'Good Protein', 'Simple Ingredients'],
    ingredientSummary: [
      IngredientSummaryItem(name: 'Milk Solids', level: HealthLevel.good),
      IngredientSummaryItem(name: 'Milk', level: HealthLevel.good),
      IngredientSummaryItem(name: 'Live Cultures', level: HealthLevel.good),
      IngredientSummaryItem(
        name: 'Sugar (Trace)',
        isTrace: true,
        level: HealthLevel.neutral,
      ),
    ],
    ingredientCount: 4,
    goodIngredientCount: 3,
    neutralIngredientCount: 1,
    concernIngredientCount: 0,
    forYouMessage:
        'No major ingredient concerns identified based on your dietary profile. This product aligns with your health goals.',
    allergenInfo: 'Contains: Milk',
    detailedIngredients: [
      DetailedIngredientItem(
        name: 'Milk',
        description:
            'A natural source of high-quality protein, calcium, and essential vitamins vital for bone health and general wellbeing.',
        statusLabel: 'Good',
        level: HealthLevel.good,
        iconData: Icons.water_drop_outlined,
      ),
      DetailedIngredientItem(
        name: 'Milk Solids',
        description:
            'Used to improve texture and nutritional profile, adding extra protein and thickness to the yogurt without artificial thickeners.',
        statusLabel: 'Good',
        level: HealthLevel.good,
        iconData: Icons.grain_outlined,
      ),
      DetailedIngredientItem(
        name: 'Live Cultures',
        description:
            'Beneficial probiotics that aid in digestion, support gut health, and drive the natural fermentation process of the yogurt.',
        statusLabel: 'Excellent',
        level: HealthLevel.excellent,
        iconData: Icons.biotech_outlined,
      ),
      DetailedIngredientItem(
        name: 'Sugar (Naturally Occurring)',
        description:
            'Contains naturally occurring lactose from milk. No added refined sugars are present, keeping the glycemic impact low.',
        statusLabel: 'Neutral',
        level: HealthLevel.neutral,
        iconData: Icons.scatter_plot_outlined,
      ),
    ],
    nutritionScoreLabel: 'Excellent',
    servingLabel: 'Per Serving (200g)',
    nutritionPer100g: [
      NutritionTableItem(name: 'Energy', amount: '61', unit: 'kcal'),
      NutritionTableItem(
        name: 'Protein',
        amount: '3.1',
        unit: 'g',
        tag: 'Good',
        tagLevel: HealthLevel.good,
      ),
      NutritionTableItem(name: 'Total Sugar', amount: '4.5', unit: 'g'),
      NutritionTableItem(
        name: 'Added Sugar',
        amount: '0',
        unit: 'g',
        tag: 'Excellent',
        tagLevel: HealthLevel.excellent,
        isIndented: true,
      ),
      NutritionTableItem(name: 'Total Fat', amount: '3.0', unit: 'g'),
      NutritionTableItem(
        name: 'Sodium',
        amount: '45',
        unit: 'mg',
        tag: 'Low',
        tagLevel: HealthLevel.low,
      ),
      NutritionTableItem(name: 'Calcium', amount: '120', unit: 'mg'),
    ],
    nutritionPerServing: [
      NutritionTableItem(name: 'Energy', amount: '122', unit: 'kcal'),
      NutritionTableItem(
        name: 'Protein',
        amount: '6.2',
        unit: 'g',
        tag: 'Good',
        tagLevel: HealthLevel.good,
      ),
      NutritionTableItem(name: 'Total Sugar', amount: '9.0', unit: 'g'),
      NutritionTableItem(
        name: 'Added Sugar',
        amount: '0',
        unit: 'g',
        tag: 'Excellent',
        tagLevel: HealthLevel.excellent,
        isIndented: true,
      ),
      NutritionTableItem(name: 'Total Fat', amount: '6.0', unit: 'g'),
      NutritionTableItem(
        name: 'Sodium',
        amount: '90',
        unit: 'mg',
        tag: 'Low',
        tagLevel: HealthLevel.low,
      ),
      NutritionTableItem(name: 'Calcium', amount: '240', unit: 'mg'),
    ],
    nutritionHighlights: [
      NutritionHighlightItem(
        label: 'Low Added Sugar',
        iconData: Icons.water_drop_outlined,
      ),
      NutritionHighlightItem(
        label: 'Good Protein',
        iconData: Icons.fitness_center_outlined,
      ),
      NutritionHighlightItem(
        label: 'Moderate Fat',
        iconData: Icons.balance_outlined,
        isNeutral: true,
      ),
      NutritionHighlightItem(
        label: 'Source of Calcium',
        iconData: Icons.health_and_safety_outlined,
      ),
    ],
    whatThisMeansForYou:
        'This product fits well with your preferences for high protein and low added sugar. It\'s a great choice for your daily dairy intake.',
  );

  static const ProductDetailModel motherDairy = ProductDetailModel(
    id: 'mother-dairy-400',
    name: 'Mother Dairy Classic Dahi',
    brand: 'Mother Dairy',
    category: 'Dairy / Curd',
    weight: '400g',
    imageAsset: 'assets/images/products/mother_dairy.jpg',
    score: 8.4,
    maxScore: 10.0,
    scoreLabel: 'Good Choice',
    scoreSummary: 'Wholesome dairy option with balanced nutritional profile.',
    verdictTitle: 'Good Choice For You',
    verdictDescription:
        'Low added sugar and natural probiotics align well with your health goals.',
    nutritionScore: 8.5,
    ingredientsScore: 8.6,
    personalFitScore: 8.4,
    whyScoresWell: ['No Added Sugar', 'Rich Calcium', 'Active Probiotics'],
    ingredientSummary: [
      IngredientSummaryItem(name: 'Pasteurized Milk', level: HealthLevel.good),
      IngredientSummaryItem(name: 'Milk Solids', level: HealthLevel.good),
      IngredientSummaryItem(name: 'Lactic Cultures', level: HealthLevel.good),
    ],
    ingredientCount: 3,
    goodIngredientCount: 3,
    neutralIngredientCount: 0,
    concernIngredientCount: 0,
    forYouMessage:
        'Clean ingredient list with no synthetic additives or extra sugars.',
    allergenInfo: 'Contains: Milk',
    detailedIngredients: [
      DetailedIngredientItem(
        name: 'Pasteurized Milk',
        description: 'High quality milk providing natural protein and calcium.',
        statusLabel: 'Good',
        level: HealthLevel.good,
        iconData: Icons.water_drop_outlined,
      ),
      DetailedIngredientItem(
        name: 'Milk Solids',
        description: 'Improves consistency and increases protein content.',
        statusLabel: 'Good',
        level: HealthLevel.good,
        iconData: Icons.grain_outlined,
      ),
      DetailedIngredientItem(
        name: 'Lactic Cultures',
        description:
            'Essential beneficial bacterial cultures for gut digestion.',
        statusLabel: 'Excellent',
        level: HealthLevel.excellent,
        iconData: Icons.biotech_outlined,
      ),
    ],
    nutritionScoreLabel: 'Good',
    servingLabel: 'Per Serving (200g)',
    nutritionPer100g: [
      NutritionTableItem(name: 'Energy', amount: '65', unit: 'kcal'),
      NutritionTableItem(
        name: 'Protein',
        amount: '3.3',
        unit: 'g',
        tag: 'Good',
        tagLevel: HealthLevel.good,
      ),
      NutritionTableItem(name: 'Total Sugar', amount: '4.8', unit: 'g'),
      NutritionTableItem(
        name: 'Added Sugar',
        amount: '0',
        unit: 'g',
        tag: 'Excellent',
        tagLevel: HealthLevel.excellent,
        isIndented: true,
      ),
      NutritionTableItem(name: 'Total Fat', amount: '3.2', unit: 'g'),
      NutritionTableItem(
        name: 'Sodium',
        amount: '50',
        unit: 'mg',
        tag: 'Low',
        tagLevel: HealthLevel.low,
      ),
      NutritionTableItem(name: 'Calcium', amount: '130', unit: 'mg'),
    ],
    nutritionPerServing: [
      NutritionTableItem(name: 'Energy', amount: '130', unit: 'kcal'),
      NutritionTableItem(
        name: 'Protein',
        amount: '6.6',
        unit: 'g',
        tag: 'Good',
        tagLevel: HealthLevel.good,
      ),
      NutritionTableItem(name: 'Total Sugar', amount: '9.6', unit: 'g'),
      NutritionTableItem(
        name: 'Added Sugar',
        amount: '0',
        unit: 'g',
        tag: 'Excellent',
        tagLevel: HealthLevel.excellent,
        isIndented: true,
      ),
      NutritionTableItem(name: 'Total Fat', amount: '6.4', unit: 'g'),
      NutritionTableItem(
        name: 'Sodium',
        amount: '100',
        unit: 'mg',
        tag: 'Low',
        tagLevel: HealthLevel.low,
      ),
      NutritionTableItem(name: 'Calcium', amount: '260', unit: 'mg'),
    ],
    nutritionHighlights: [
      NutritionHighlightItem(
        label: 'Zero Added Sugar',
        iconData: Icons.water_drop_outlined,
      ),
      NutritionHighlightItem(
        label: 'Good Protein',
        iconData: Icons.fitness_center_outlined,
      ),
      NutritionHighlightItem(
        label: 'High Calcium',
        iconData: Icons.health_and_safety_outlined,
      ),
    ],
    whatThisMeansForYou:
        'A nutritious dairy pick that supports bone density and digestive health.',
  );

  static const ProductDetailModel quakerOats = ProductDetailModel(
    id: 'quaker-oats-500',
    name: 'Quaker Rolled Oats',
    brand: 'Quaker',
    category: 'Breakfast / Cereals',
    weight: '500g',
    imageAsset: 'assets/images/products/quaker_oats.jpg',
    score: 8.2,
    maxScore: 10.0,
    scoreLabel: 'Good Choice',
    scoreSummary: 'High-fiber whole grain that aids cardiovascular health.',
    verdictTitle: 'Good Choice For You',
    verdictDescription:
        '100% whole grain oats rich in beta-glucan fiber for cholesterol management.',
    nutritionScore: 8.4,
    ingredientsScore: 9.5,
    personalFitScore: 8.2,
    whyScoresWell: ['100% Whole Grain', 'High Dietary Fiber', 'Zero Additives'],
    ingredientSummary: [
      IngredientSummaryItem(name: 'Whole Grain Oats', level: HealthLevel.good),
    ],
    ingredientCount: 1,
    goodIngredientCount: 1,
    neutralIngredientCount: 0,
    concernIngredientCount: 0,
    forYouMessage:
        'Single ingredient purity with zero added sugar or artificial preservatives.',
    allergenInfo: 'Contains: Gluten (Oats)',
    detailedIngredients: [
      DetailedIngredientItem(
        name: 'Whole Grain Rolled Oats',
        description:
            'Pure 100% unrefined oats loaded with soluble fiber and complex carbohydrates.',
        statusLabel: 'Excellent',
        level: HealthLevel.excellent,
        iconData: Icons.grain_outlined,
      ),
    ],
    nutritionScoreLabel: 'Good',
    servingLabel: 'Per Serving (40g)',
    nutritionPer100g: [
      NutritionTableItem(name: 'Energy', amount: '389', unit: 'kcal'),
      NutritionTableItem(
        name: 'Protein',
        amount: '12.5',
        unit: 'g',
        tag: 'Good',
        tagLevel: HealthLevel.good,
      ),
      NutritionTableItem(
        name: 'Dietary Fiber',
        amount: '10.0',
        unit: 'g',
        tag: 'High',
        tagLevel: HealthLevel.good,
      ),
      NutritionTableItem(name: 'Total Sugar', amount: '1.0', unit: 'g'),
      NutritionTableItem(
        name: 'Added Sugar',
        amount: '0',
        unit: 'g',
        tag: 'Excellent',
        tagLevel: HealthLevel.excellent,
        isIndented: true,
      ),
      NutritionTableItem(name: 'Total Fat', amount: '6.9', unit: 'g'),
      NutritionTableItem(
        name: 'Sodium',
        amount: '5',
        unit: 'mg',
        tag: 'Low',
        tagLevel: HealthLevel.low,
      ),
    ],
    nutritionPerServing: [
      NutritionTableItem(name: 'Energy', amount: '156', unit: 'kcal'),
      NutritionTableItem(
        name: 'Protein',
        amount: '5.0',
        unit: 'g',
        tag: 'Good',
        tagLevel: HealthLevel.good,
      ),
      NutritionTableItem(
        name: 'Dietary Fiber',
        amount: '4.0',
        unit: 'g',
        tag: 'High',
        tagLevel: HealthLevel.good,
      ),
      NutritionTableItem(name: 'Total Sugar', amount: '0.4', unit: 'g'),
      NutritionTableItem(
        name: 'Added Sugar',
        amount: '0',
        unit: 'g',
        tag: 'Excellent',
        tagLevel: HealthLevel.excellent,
        isIndented: true,
      ),
      NutritionTableItem(name: 'Total Fat', amount: '2.8', unit: 'g'),
      NutritionTableItem(
        name: 'Sodium',
        amount: '2',
        unit: 'mg',
        tag: 'Low',
        tagLevel: HealthLevel.low,
      ),
    ],
    nutritionHighlights: [
      NutritionHighlightItem(
        label: 'High Soluble Fiber',
        iconData: Icons.grain_outlined,
      ),
      NutritionHighlightItem(
        label: 'Complex Carbs',
        iconData: Icons.bolt_outlined,
      ),
      NutritionHighlightItem(
        label: 'Zero Added Sugar',
        iconData: Icons.water_drop_outlined,
      ),
    ],
    whatThisMeansForYou:
        'Great breakfast option for sustained energy and heart health.',
  );

  static const ProductDetailModel hersheysSyrup = ProductDetailModel(
    id: 'hersheys-syrup-400',
    name: "Hershey's Chocolate Syrup",
    brand: "Hershey's",
    category: 'Syrups & Spreads',
    weight: '400g',
    imageAsset: 'assets/images/products/hersheys_syrup.jpg',
    score: 6.8,
    maxScore: 10.0,
    scoreLabel: 'Moderate',
    scoreSummary: 'High sugar dessert topping meant for occasional treats.',
    verdictTitle: 'Enjoy In Moderation',
    verdictDescription:
        'High sugar content and processed ingredients mean this is best consumed occasionally.',
    nutritionScore: 5.5,
    ingredientsScore: 6.0,
    personalFitScore: 6.8,
    whyScoresWell: ['Low Saturated Fat', 'Classic Chocolate Flavor'],
    ingredientSummary: [
      IngredientSummaryItem(
        name: 'Sugar / Corn Syrup',
        level: HealthLevel.concern,
      ),
      IngredientSummaryItem(name: 'Cocoa', level: HealthLevel.good),
      IngredientSummaryItem(name: 'Preservatives', level: HealthLevel.concern),
    ],
    ingredientCount: 7,
    goodIngredientCount: 2,
    neutralIngredientCount: 2,
    concernIngredientCount: 3,
    forYouMessage:
        'High glycemic index due to added sugars and corn syrup. Watch portion sizes.',
    allergenInfo: 'May contain: Milk, Soy',
    detailedIngredients: [
      DetailedIngredientItem(
        name: 'High Fructose Corn Syrup',
        description: 'Sweetener with high caloric density and fast absorption.',
        statusLabel: 'Concern',
        level: HealthLevel.concern,
        iconData: Icons.warning_amber_outlined,
      ),
      DetailedIngredientItem(
        name: 'Cocoa Powder',
        description: 'Provides chocolate taste and minor antioxidant benefits.',
        statusLabel: 'Good',
        level: HealthLevel.good,
        iconData: Icons.eco_outlined,
      ),
    ],
    nutritionScoreLabel: 'Moderate',
    servingLabel: 'Per Serving (20g)',
    nutritionPer100g: [
      NutritionTableItem(name: 'Energy', amount: '265', unit: 'kcal'),
      NutritionTableItem(name: 'Protein', amount: '1.5', unit: 'g'),
      NutritionTableItem(
        name: 'Total Sugar',
        amount: '60.0',
        unit: 'g',
        tag: 'High',
        tagLevel: HealthLevel.concern,
      ),
      NutritionTableItem(
        name: 'Added Sugar',
        amount: '55.0',
        unit: 'g',
        tag: 'High',
        tagLevel: HealthLevel.concern,
        isIndented: true,
      ),
      NutritionTableItem(name: 'Total Fat', amount: '0.8', unit: 'g'),
      NutritionTableItem(name: 'Sodium', amount: '35', unit: 'mg'),
    ],
    nutritionPerServing: [
      NutritionTableItem(name: 'Energy', amount: '53', unit: 'kcal'),
      NutritionTableItem(name: 'Protein', amount: '0.3', unit: 'g'),
      NutritionTableItem(
        name: 'Total Sugar',
        amount: '12.0',
        unit: 'g',
        tag: 'High',
        tagLevel: HealthLevel.concern,
      ),
      NutritionTableItem(
        name: 'Added Sugar',
        amount: '11.0',
        unit: 'g',
        tag: 'High',
        tagLevel: HealthLevel.concern,
        isIndented: true,
      ),
      NutritionTableItem(name: 'Total Fat', amount: '0.16', unit: 'g'),
      NutritionTableItem(name: 'Sodium', amount: '7', unit: 'mg'),
    ],
    nutritionHighlights: [
      NutritionHighlightItem(
        label: 'High Added Sugar',
        iconData: Icons.warning_amber_outlined,
        isNeutral: true,
      ),
      NutritionHighlightItem(
        label: 'Low Fat',
        iconData: Icons.check_circle_outline,
      ),
    ],
    whatThisMeansForYou:
        'Occasional treat. Consider fruit purees or dark chocolate as alternatives.',
  );

  /// Lookup product by ID with realistic fallback
  static ProductDetailModel getProductById(String? id) {
    final cleanId = id?.toLowerCase().trim() ?? '';
    if (cleanId.contains('mother')) {
      return motherDairy;
    } else if (cleanId.contains('quaker') || cleanId.contains('oats')) {
      return quakerOats;
    } else if (cleanId.contains('hershey') || cleanId.contains('syrup')) {
      return hersheysSyrup;
    }
    // Default / primary Stitch reference is Amul Masti Dahi
    return amulMastiDahi;
  }
}
