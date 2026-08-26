import 'package:flutter/material.dart';

import 'core/routing/routing.dart';
import 'core/theme/theme.dart';

void main() {
  runApp(const PreBiteApp());
}

/// Main PreBite Application Entrypoint
class PreBiteApp extends StatelessWidget {
  const PreBiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PreBite',
      theme: PreBiteTheme.lightTheme,
      routerConfig: preBiteRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
