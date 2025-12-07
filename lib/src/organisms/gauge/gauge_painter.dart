import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/gauge_style.dart';

/// Custom painter for the AppGauge widget.
///
/// This painter replicates the visual style of the legacy AnimatedMeter
/// while adding theme-driven rendering modes.
class GaugePainter extends CustomPainter {
  final BuildContext context;
  final double value;
  final GaugeStyle style;
  final double strokeWidth;
  final double markerRadius;
  final bool displayMarkerValues;
  final List<String> markers;
  final Color trackColor;

  /// The indicator color is now taken from style.indicatorColor
  Color get indicatorColor => style.indicatorColor;

  GaugePainter({
    required this.context,
    required this.value,
    required this.style,
    required this.strokeWidth,
    required this.markerRadius,
    required this.displayMarkerValues,
    required this.markers,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 20;
    final outsideIndicatorRadius = math.min(size.width, size.height) / 2;

    // Arc geometry from style (defaults match old AnimatedMeter)
    final fillRatio = style.fillRatio; // 0.8 = 288 degrees
    final offsetAngle = style.offsetAngle; // ~54 degrees offset

    final sweepAngle = 2 * math.pi * fillRatio;
    final startAngle = math.pi - offsetAngle;

    // 1. Draw inner glow/shadow background (80px wide semi-transparent arc)
    if (style.enableGlow || style.innerGlowOpacity > 0) {
      final backgroundGlowPaint = Paint()
        ..color = trackColor.withValues(alpha: style.innerGlowOpacity)
        ..strokeWidth = style.innerGlowWidth
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 40),
        startAngle,
        2 * math.pi, // Full circle for background
        false,
        backgroundGlowPaint,
      );
    }

    // 2. Draw track (background arc)
    final trackPaint = Paint()
      ..color = trackColor
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    if (style.type == GaugeRenderType.segmented && style.showTicks) {
      _drawSegmentedArc(canvas, center, radius, startAngle, sweepAngle, trackPaint);
    } else {
      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        trackPaint,
      );
    }

    // 3. Draw indicator progress (inner glow portion)
    final indicatorSweepAngle = sweepAngle * value;

    if (style.enableGlow && value > 0) {
      final indicatorGlowPaint = Paint()
        ..shader = LinearGradient(
          colors: [
            trackColor.withValues(alpha: 0.2),
            indicatorColor.withValues(alpha: 0.2),
          ],
          stops: [0.0, value],
        ).createShader(Rect.fromCircle(center: center, radius: radius))
        ..strokeWidth = style.innerGlowWidth
        ..style = PaintingStyle.stroke;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius - 40),
        startAngle,
        indicatorSweepAngle,
        false,
        indicatorGlowPaint,
      );
    }

    // 4. Draw indicator progress (main arc)
    if (value > 0) {
      final effectiveIndicatorColor = indicatorColor;

      final indicatorPaint = Paint()
        ..color = effectiveIndicatorColor // Set color first
        ..strokeWidth = strokeWidth
        ..strokeCap = _getStrokeCap()
        ..style = PaintingStyle.stroke;

      // Apply shader based on render type (shader overrides color)
      if (style.type == GaugeRenderType.gradient) {
        // Use SweepGradient for proper arc coloring
        indicatorPaint.shader = SweepGradient(
          startAngle: startAngle,
          endAngle: startAngle + indicatorSweepAngle,
          colors: [
            effectiveIndicatorColor.withValues(alpha: 0.3),
            effectiveIndicatorColor,
          ],
          stops: const [0.0, 1.0],
        ).createShader(Rect.fromCircle(center: center, radius: radius));
      }
      // For non-gradient types, the color is already set above

      if (style.type == GaugeRenderType.segmented && style.showTicks) {
        _drawSegmentedArc(canvas, center, radius, startAngle, indicatorSweepAngle, indicatorPaint);
      } else {
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          indicatorSweepAngle,
          false,
          indicatorPaint,
        );
      }

      // 5. Draw comet tail effect (for Glass theme)
      if (style.cap == GaugeCapType.comet && style.enableGlow) {
        _drawCometTail(canvas, center, outsideIndicatorRadius, startAngle, indicatorSweepAngle);
      }

      // 6. Draw bead cap (circular tip at end of arc)
      if (style.cap == GaugeCapType.bead) {
        final tipAngle = startAngle + indicatorSweepAngle;
        final tipX = center.dx + radius * math.cos(tipAngle);
        final tipY = center.dy + radius * math.sin(tipAngle);
        canvas.drawCircle(
          Offset(tipX, tipY),
          strokeWidth / 1.5,
          Paint()..color = indicatorColor,
        );
      }
    }

    // 7. Draw markers (dots and text labels)
    if (markers.isNotEmpty) {
      _drawMarkers(canvas, center, radius, startAngle, sweepAngle);
    }
  }

  void _drawSegmentedArc(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
    Paint paint,
  ) {
    final tickCount = style.tickCount ?? 20;
    final interval = sweepAngle / tickCount;

    for (int i = 0; i < tickCount; i++) {
      final angle = startAngle + (i * interval);
      if (angle > startAngle + sweepAngle) break;

      // Draw tick mark
      final p1 = Offset(
        center.dx + (radius - 5) * math.cos(angle),
        center.dy + (radius - 5) * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + (radius + 5) * math.cos(angle),
        center.dy + (radius + 5) * math.sin(angle),
      );
      canvas.drawLine(p1, p2, paint..strokeWidth = 2);
    }
  }

  void _drawCometTail(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double indicatorSweepAngle,
  ) {
    const cometLength = 2 * math.pi * 0.333;
    final cometStartAngle = startAngle + indicatorSweepAngle - (cometLength / 2);

    final cometPaint = Paint()
      ..shader = SweepGradient(
        colors: [
          Colors.white.withValues(alpha: 0.1),
          trackColor,
          indicatorColor,
          trackColor,
          Colors.white.withValues(alpha: 0.1),
        ],
        stops: const [0.0, 0.3, 0.5, 0.7, 1.0],
        startAngle: cometStartAngle,
        endAngle: cometStartAngle + cometLength,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = 4.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      cometStartAngle,
      cometLength,
      false,
      cometPaint,
    );
  }

  void _drawMarkers(
    Canvas canvas,
    Offset center,
    double radius,
    double startAngle,
    double sweepAngle,
  ) {
    final numMarkers = markers.length;
    final markerAngleStep = sweepAngle / (numMarkers - 1);

    final markerPaint = Paint()
      ..color = style.markerColor
      ..style = PaintingStyle.fill;

    for (int i = 0; i < numMarkers; i++) {
      final angle = startAngle + i * markerAngleStep;
      final markerX = center.dx + radius * math.cos(angle);
      final markerY = center.dy + radius * math.sin(angle);

      // Draw marker dot
      canvas.drawCircle(Offset(markerX, markerY), markerRadius, markerPaint);

      // Draw text label
      if (displayMarkerValues) {
        final markerTextRadius = radius - 24;
        final textPainter = TextPainter(
          text: TextSpan(
            text: markers[i],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout(minWidth: 0, maxWidth: double.infinity);

        final markerTextX = center.dx + markerTextRadius * math.cos(angle);
        final markerTextY = center.dy + markerTextRadius * math.sin(angle);
        final textOffset = Offset(
          markerTextX - textPainter.width / 2,
          markerTextY - textPainter.height / 2,
        );
        textPainter.paint(canvas, textOffset);
      }
    }
  }

  StrokeCap _getStrokeCap() {
    switch (style.cap) {
      case GaugeCapType.round:
        return StrokeCap.round;
      case GaugeCapType.butt:
      case GaugeCapType.comet:
      case GaugeCapType.bead:
        return StrokeCap.butt;
    }
  }

  @override
  bool shouldRepaint(covariant GaugePainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.style != style ||
        oldDelegate.strokeWidth != strokeWidth ||
        oldDelegate.markerRadius != markerRadius ||
        oldDelegate.displayMarkerValues != displayMarkerValues ||
        oldDelegate.markers != markers;
  }
}
