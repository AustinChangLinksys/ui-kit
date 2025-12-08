import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'divider_style.tailor.dart';

/// Pattern for divider lines.
enum DividerPattern {
  solid,
  dashed,
  jagged,
}

/// Style specification for divider components.
///
/// Example:
/// ```dart
/// DividerStyle(
///   color: Colors.grey,
///   thickness: 1.0,
///   pattern: DividerPattern.solid,
/// )
/// ```
@TailorMixin()
class DividerStyle extends ThemeExtension<DividerStyle>
    with _$DividerStyleTailorMixin {
  const DividerStyle({
    required this.color,
    this.secondaryColor,
    required this.thickness,
    this.indent = 0.0,
    this.endIndent = 0.0,
    this.glowStrength = 0.0,
    required this.pattern,
  });

  /// Primary divider color.
  @override
  final Color color;

  /// Secondary color for gradient or pattern effects.
  @override
  final Color? secondaryColor;

  /// Divider line thickness.
  @override
  final double thickness;

  /// Left/start indent.
  @override
  final double indent;

  /// Right/end indent.
  @override
  final double endIndent;

  /// Glow effect strength (0 for none).
  @override
  final double glowStrength;

  /// Divider line pattern (solid, dashed, jagged).
  @override
  final DividerPattern pattern;
}
