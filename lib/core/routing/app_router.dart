import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/comparison/product_comparison_screen.dart';
import '../../features/home/home_dashboard_screen.dart';
import '../../features/product/product_ingredients_screen.dart';
import '../../features/product/product_nutrition_screen.dart';
import '../../features/product/product_overview_screen.dart';
import '../../features/recommendations/recommendations_screen.dart';
import '../../features/scanner/barcode_scanner_screen.dart';
import '../../features/splash/splash_login_screen.dart';
import 'route_paths.dart';
import 'temporary_route_target.dart';

/// PreBite GoRouter Configuration
/// Configures routing for all approved Stitch screen destinations.
final GoRouter preBiteRouter = GoRouter(
  initialLocation: PreBiteRoutes.splash,
  debugLogDiagnostics: false,
  routes: <RouteBase>[
    GoRoute(
      path: PreBiteRoutes.splash,
      name: PreBiteRoutes.splashName,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashLoginScreen(),
    ),
    GoRoute(
      path: PreBiteRoutes.login,
      name: PreBiteRoutes.loginName,
      builder: (BuildContext context, GoRouterState state) =>
          const SplashLoginScreen(),
    ),
    GoRoute(
      path: PreBiteRoutes.home,
      name: PreBiteRoutes.homeName,
      builder: (BuildContext context, GoRouterState state) =>
          const HomeDashboardScreen(),
    ),
    GoRoute(
      path: PreBiteRoutes.scanner,
      name: PreBiteRoutes.scannerName,
      builder: (BuildContext context, GoRouterState state) =>
          const BarcodeScannerScreen(),
    ),
    GoRoute(
      path: PreBiteRoutes.productOverview,
      name: PreBiteRoutes.productOverviewName,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id'] ?? '';
        return ProductOverviewScreen(productId: id);
      },
    ),
    GoRoute(
      path: PreBiteRoutes.productIngredients,
      name: PreBiteRoutes.productIngredientsName,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id'] ?? '';
        return ProductIngredientsScreen(productId: id);
      },
    ),
    GoRoute(
      path: PreBiteRoutes.productNutrition,
      name: PreBiteRoutes.productNutritionName,
      builder: (BuildContext context, GoRouterState state) {
        final id = state.pathParameters['id'] ?? '';
        return ProductNutritionScreen(productId: id);
      },
    ),
    GoRoute(
      path: PreBiteRoutes.recommendations,
      name: PreBiteRoutes.recommendationsName,
      builder: (BuildContext context, GoRouterState state) =>
          const RecommendationsScreen(),
    ),
    GoRoute(
      path: PreBiteRoutes.productComparison,
      name: PreBiteRoutes.productComparisonName,
      builder: (BuildContext context, GoRouterState state) =>
          const ProductComparisonScreen(),
    ),
    GoRoute(
      path: PreBiteRoutes.favoritesHistory,
      name: PreBiteRoutes.favoritesHistoryName,
      builder: (BuildContext context, GoRouterState state) =>
          const TemporaryRouteTarget(routeName: 'Favorites & Scan History'),
    ),
    GoRoute(
      path: PreBiteRoutes.familyProfiles,
      name: PreBiteRoutes.familyProfilesName,
      builder: (BuildContext context, GoRouterState state) =>
          const TemporaryRouteTarget(routeName: 'Family Profiles'),
    ),
    GoRoute(
      path: PreBiteRoutes.aiAssistant,
      name: PreBiteRoutes.aiAssistantName,
      builder: (BuildContext context, GoRouterState state) =>
          const TemporaryRouteTarget(routeName: 'PreBite AI Assistant'),
    ),
    GoRoute(
      path: PreBiteRoutes.profileSettings,
      name: PreBiteRoutes.profileSettingsName,
      builder: (BuildContext context, GoRouterState state) =>
          const TemporaryRouteTarget(routeName: 'Profile & Settings'),
    ),
  ],
  errorBuilder: (BuildContext context, GoRouterState state) =>
      TemporaryRouteTarget(
        routeName: 'Page Not Found',
        parameters: {'error': state.error?.toString() ?? 'Unknown error'},
      ),
);
