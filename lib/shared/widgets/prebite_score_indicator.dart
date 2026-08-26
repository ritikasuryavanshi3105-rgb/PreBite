import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../core/theme/colors.dart';
import '../../core/theme/radius.dart';
import '../../core/theme/typography.dart';

/// PreBite Circular Score Ring / Donut Chart
/// Implements DESIGN.md:
/// - Primary Green (#006B32) active segment
/// - Light neutral / surface-container (#F0EDED) empty track
/// - Centered headline typography (e.g. "9.1 / 10" or "85 / 100")
class PreBiteScoreRing extends StatelessWidget {
  const PreBiteScoreRing({
    super.key,
    required this.score,
    this.maxScore = 10.0,
    this.size = 120.0,
    this.strokeWidth = 8.0,
    this.activeColor,
    this.trackColor,
    this.showFraction = true,
  });

  final double score;
  final double maxScore;
  final double size;
  final double strokeWidth;
  final Color? activeColor;
  final Color? trackColor;
  final bool showFraction;

  Color get _resolvedActiveColor {
    if (activeColor != null) return activeColor!;
    final normalized = (score / maxScore).clamp(0.0, 1.0);
    if (normalized >= 0.8) return PreBiteColors.scoreExcellent;
    if (normalized >= 0.6) return PreBiteColors.scoreGood;
    if (normalized >= 0.4) return PreBiteColors.scoreModerate;
    return PreBiteColors.scorePoor;
  }

  @override
  Widget build(BuildContext context) {
    final normalized = (score / maxScore).clamp(0.0, 1.0);
    final isTenScale = maxScore <= 10.0;
    final scoreText = isTenScale
        ? score.toStringAsFixed(1)
        : score.toInt().toString();
    final maxText = isTenScale ? '/ 10' : '/ 100';

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ScoreRingPainter(
              progress: normalized,
              strokeWidth: strokeWidth,
              activeColor: _resolvedActiveColor,
              trackColor: trackColor ?? PreBiteColors.surfaceContainer,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                scoreText,
                style: PreBiteTypography.headlineLarge.copyWith(
                  fontSize: size * 0.28,
                  height: 1.0,
                  fontWeight: FontWeight.w700,
                  color: PreBiteColors.onBackground,
                ),
              ),
              if (showFraction)
                Text(
                  maxText,
                  style: PreBiteTypography.labelMedium.copyWith(
                    fontSize: size * 0.12,
                    color: PreBiteColors.onSurfaceVariant,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ScoreRingPainter extends CustomPainter {
  const _ScoreRingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.activeColor,
    required this.trackColor,
  });

  final double progress;
  final double strokeWidth;
  final Color activeColor;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // Background track
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, trackPaint);

    // Active progress arc
    if (progress > 0) {
      final activePaint = Paint()
        ..color = activeColor
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round;

      const startAngle = -math.pi / 2;
      final sweepAngle = 2 * math.pi * progress;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        activePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.activeColor != activeColor ||
        oldDelegate.trackColor != trackColor ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

/// PreBite Pill Score Badge
/// Compact indicator (e.g. "8.5 Good Choice") for product lists & cards.
class PreBiteScoreBadge extends StatelessWidget {
  const PreBiteScoreBadge({
    super.key,
    required this.score,
    this.maxScore = 10.0,
    this.label,
  });

  final double score;
  final double maxScore;
  final String? label;

  Color get _color {
    final normalized = (score / maxScore).clamp(0.0, 1.0);
    if (normalized >= 0.8) return PreBiteColors.scoreExcellent;
    if (normalized >= 0.6) return PreBiteColors.scoreGood;
    if (normalized >= 0.4) return PreBiteColors.scoreModerate;
    return PreBiteColors.scorePoor;
  }

  String get _defaultLabel {
    final normalized = (score / maxScore).clamp(0.0, 1.0);
    if (normalized >= 0.8) return 'Excellent';
    if (normalized >= 0.6) return 'Good Choice';
    if (normalized >= 0.4) return 'Moderate';
    return 'Poor';
  }

  @override
  Widget build(BuildContext context) {
    final isTenScale = maxScore <= 10.0;
    final scoreStr = isTenScale
        ? score.toStringAsFixed(1)
        : score.toInt().toString();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _color.withValues(alpha: 0.12),
        borderRadius: PreBiteRadius.chip,
        border: Border.all(color: _color.withValues(alpha: 0.25), width: 1.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: _color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(
            '$scoreStr • ${label ?? _defaultLabel}',
            style: PreBiteTypography.labelMedium.copyWith(
              color: _color,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
