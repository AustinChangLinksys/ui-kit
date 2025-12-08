import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'animation_spec.tailor.dart';

/// Shared specification for animation timing across all components.
///
/// Presets align with AppMotion tokens (Constitution 5.1):
/// - [instant] = 0ms (Pixel theme instant snap)
/// - [fast] = 150ms (quick micro-interactions)
/// - [standard] = 300ms (standard animations)
/// - [slow] = 500ms (Glass theme fluid effects)
@TailorMixin()
class AnimationSpec extends ThemeExtension<AnimationSpec>
    with _$AnimationSpecTailorMixin {
  const AnimationSpec({
    required this.duration,
    required this.curve,
  });

  /// Animation duration
  @override
  final Duration duration;

  /// Animation curve
  @override
  final Curve curve;

  // --- Static Presets ---

  /// Instant snap (Pixel theme, 0ms) - maps to motion.instant
  static const instant = AnimationSpec(
    duration: Duration.zero,
    curve: Curves.linear,
  );

  /// Fast micro-interactions (150ms) - maps to motion.fast
  static const fast = AnimationSpec(
    duration: Duration(milliseconds: 150),
    curve: Curves.easeOut,
  );

  /// Standard animations (300ms) - maps to motion.medium
  static const standard = AnimationSpec(
    duration: Duration(milliseconds: 300),
    curve: Curves.easeInOut,
  );

  /// Slow floating effects (500ms, Glass theme) - maps to motion.slow
  static const slow = AnimationSpec(
    duration: Duration(milliseconds: 500),
    curve: Curves.easeOutExpo,
  );

  // --- Override Support ---

  /// Create a new instance with specified values overridden.
  /// Unspecified values inherit from this instance.
  AnimationSpec withOverride({
    Duration? duration,
    Curve? curve,
  }) {
    return AnimationSpec(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }
}
