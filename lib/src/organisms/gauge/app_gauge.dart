import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
import 'gauge_painter.dart';

/// A themed gauge/meter widget that displays a value on an arc.
///
/// This widget replaces the legacy `AnimatedMeter` with full theme support.
/// It displays a circular arc meter representing a normalized value (0.0 - 1.0).
///
/// Features:
/// - Configurable arc geometry (fillRatio controls arc extent)
/// - Optional markers with labels
/// - Theme-driven rendering (gradient, segmented, solid)
/// - Theme-specific caps (round, butt, comet, bead)
/// - Inner glow effect (Glass theme)
/// - Animated value transitions
class AppGauge extends StatefulWidget {
  /// The current value for the meter (0.0 - 1.0)
  final double value;

  /// Size of the gauge widget
  final double size;

  /// Stroke width for the indicator path (overrides theme if set)
  final double? indicatorPathStrokeWidth;

  /// Whether to display marker values as text labels
  final bool? displayIndicatorValues;

  /// Radius of marker dots (overrides theme if set)
  final double? markerRadius;

  /// Builder for center content (receives context and current animated value)
  final Widget Function(BuildContext context, double value) centerBuilder;

  /// Builder for bottom content (receives context and current animated value)
  final Widget Function(BuildContext context, double value)? bottomBuilder;

  /// List of marker values to display (e.g., [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100])
  final List<double> markers;

  const AppGauge({
    super.key,
    required this.value,
    this.size = 200,
    this.markers = const [],
    this.indicatorPathStrokeWidth,
    this.displayIndicatorValues,
    this.markerRadius,
    required this.centerBuilder,
    this.bottomBuilder,
  });

  /// Creates a gauge with default markers at 0, 10, 20, ... 100
  const AppGauge.withDefaultMarkers({
    super.key,
    required this.value,
    this.size = 200,
    this.indicatorPathStrokeWidth,
    this.displayIndicatorValues,
    this.markerRadius,
    required this.centerBuilder,
    this.bottomBuilder,
  }) : markers = const [0, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100];

  @override
  State<AppGauge> createState() => _AppGaugeState();
}

class _AppGaugeState extends State<AppGauge> with TickerProviderStateMixin {
  double _normalizedValue = 0;
  double _maxValue = 100;
  double? _previousValue;

  @override
  Widget build(BuildContext context) {
    final theme = AppDesignTheme.of(context);
    final style = theme.gaugeStyle;

    // Calculate normalized value based on markers (same logic as old AnimatedMeter)
    _maxValue = widget.markers.isEmpty ? 100 : widget.markers.last;
    _normalizedValue = _getIndicatorValue(widget.value, _maxValue, widget.markers);
    final clampedValue = _normalizedValue > 1 ? 1.0 : _normalizedValue;

    // Get effective values (widget override or theme default)
    final effectiveStrokeWidth = widget.indicatorPathStrokeWidth ?? style.strokeWidth;
    final effectiveMarkerRadius = widget.markerRadius ?? style.markerRadius;
    final effectiveDisplayValues = widget.displayIndicatorValues ?? style.displayMarkerValues;

    // Use current value as begin for initial render (no animation from 0)
    // This ensures golden tests capture the correct state
    final beginValue = _previousValue ?? clampedValue;
    _previousValue = clampedValue;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: beginValue, end: clampedValue),
      duration: style.animationDuration,
      curve: style.animationCurve,
      builder: (context, animatedValue, child) => SizedBox(
        width: widget.size,
        height: widget.size,
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            CustomPaint(
              painter: GaugePainter(
                context: context,
                value: animatedValue,
                style: style,
                strokeWidth: effectiveStrokeWidth,
                markerRadius: effectiveMarkerRadius,
                displayMarkerValues: effectiveDisplayValues,
                markers: widget.markers.map((e) => e.toStringAsFixed(0)).toList(),
                trackColor: style.trackColor,
              ),
              size: Size.square(widget.size),
            ),
            widget.centerBuilder(context, widget.value),
            if (widget.bottomBuilder != null)
              Align(
                alignment: Alignment.bottomCenter,
                child: widget.bottomBuilder!(context, animatedValue),
              ),
          ],
        ),
      ),
    );
  }

  /// Calculates the normalized indicator value based on markers.
  /// This replicates the exact logic from the old AnimatedMeter.
  double _getIndicatorValue(double value, double max, List<double> markers) {
    // No markers or value exceeds max
    if (markers.isEmpty || value >= max) return value / max;

    // Find the interval that contains the value
    final intervalLimit = markers.firstWhere(
      (element) => value <= element,
      orElse: () => markers.last,
    );
    final intervalLimitIndex = markers.indexOf(intervalLimit);

    if (intervalLimitIndex < 1) return 0;

    // Get interval lower limit
    final intervalLowerLimitIndex = intervalLimitIndex - 1;
    final intervalLowerLimit = markers[intervalLowerLimitIndex];

    // Calculate indicator value
    final double intervalOffset = 1 / (markers.length - 1);
    final valueInIntervalOffset =
        (value - intervalLowerLimit) / (intervalLimit - intervalLowerLimit);

    return intervalLowerLimitIndex * intervalOffset +
        (valueInIntervalOffset * intervalOffset);
  }
}
