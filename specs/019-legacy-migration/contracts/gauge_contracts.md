# Gauge Contracts

```dart
import 'package:flutter/widgets.dart';
import 'package:theme_tailor/theme_tailor.dart';

part 'gauge_style.tailor.dart';

enum GaugeRenderType {
  gradient,
  segmented,
  solid,
}

enum GaugeCapType {
  round,
  butt,
  comet,
  bead,
}

/// Theme Extension for Gauge
@TailorMixin()
class GaugeStyle extends ThemeExtension<GaugeStyle> with _$GaugeStyleTailorMixin {
  // Rendering Strategy
  final GaugeRenderType type;
  final GaugeCapType cap;
  
  // Colors & visual props
  final Color trackColor;
  final bool showTicks;         // Pixel/Brutal (replaces solid track)
  final int? tickCount;         // Number of ticks for Ruler effect
  final double? tickInterval;   // Interval between ticks for Ruler effect
  final double strokeWidth;
  final bool enableGlow;        // Glass

  GaugeStyle({
    required this.type,
    required this.cap,
    required this.trackColor,
    required this.showTicks,
    this.tickCount,
    this.tickInterval,
    required this.strokeWidth,
    required this.enableGlow,
  });
}

/// Main Widget
class AppGauge extends StatelessWidget {
  /// Normalized value (0.0 - 1.0)
  final double value;
  
  /// Widget displayed in the center (e.g. Text)
  final Widget? center;
  
  /// Widget displayed below the gauge (e.g. Label)
  final Widget? label;
  
  /// Optional custom markers (0.0 - 1.0)
  final List<double>? customMarkers;

  const AppGauge({
    super.key,
    required this.value,
    this.center,
    this.label,
    this.customMarkers,
  });
}
```
