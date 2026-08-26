import 'package:flutter/material.dart';

import '../theme/colors.dart';
import '../theme/typography.dart';

/// Temporary Route Target
/// Minimal, temporary destination used solely to verify route resolution
/// and navigation transitions before full Stitch screen UI is implemented.
class TemporaryRouteTarget extends StatelessWidget {
  const TemporaryRouteTarget({
    super.key,
    required this.routeName,
    this.parameters = const <String, String>{},
  });

  final String routeName;
  final Map<String, String> parameters;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: PreBiteColors.background,
      appBar: AppBar(
        title: Text(routeName, style: PreBiteTypography.titleLarge),
        backgroundColor: PreBiteColors.surface,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(routeName, style: PreBiteTypography.headlineMedium),
            if (parameters.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text('Params: $parameters', style: PreBiteTypography.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }
}
