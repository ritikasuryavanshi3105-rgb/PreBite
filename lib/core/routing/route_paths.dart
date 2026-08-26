/// PreBite Route Paths & Route Names
/// Corresponds to all approved Stitch screen destinations.
abstract final class PreBiteRoutes {
  // Route Paths
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String scanner = '/scanner';
  static const String productOverview = '/product/:id';
  static const String productIngredients = '/product/:id/ingredients';
  static const String productNutrition = '/product/:id/nutrition';
  static const String recommendations = '/recommendations';
  static const String productComparison = '/compare';
  static const String favoritesHistory = '/history';
  static const String familyProfiles = '/family-profiles';
  static const String aiAssistant = '/ai-assistant';
  static const String profileSettings = '/settings';

  // Route Names
  static const String splashName = 'splash';
  static const String loginName = 'login';
  static const String homeName = 'home';
  static const String scannerName = 'scanner';
  static const String productOverviewName = 'product-overview';
  static const String productIngredientsName = 'product-ingredients';
  static const String productNutritionName = 'product-nutrition';
  static const String recommendationsName = 'recommendations';
  static const String productComparisonName = 'product-comparison';
  static const String favoritesHistoryName = 'favorites-history';
  static const String familyProfilesName = 'family-profiles';
  static const String aiAssistantName = 'ai-assistant';
  static const String profileSettingsName = 'profile-settings';

  /// Helper to generate product overview path with ID
  static String productOverviewPath(String productId) => '/product/$productId';

  /// Helper to generate product ingredients path with ID
  static String productIngredientsPath(String productId) =>
      '/product/$productId/ingredients';

  /// Helper to generate product nutrition path with ID
  static String productNutritionPath(String productId) =>
      '/product/$productId/nutrition';
}
