import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'animation_spec.dart';

part 'overlay_spec.tailor.dart';

/// Shared specification for modal overlay appearance (sheets, dialogs).
///
/// Composes [AnimationSpec] for animation timing.
@TailorMixin()
class OverlaySpec extends ThemeExtension<OverlaySpec>
    with _$OverlaySpecTailorMixin {
  const OverlaySpec({
    required this.scrimColor,
    this.blurStrength = 0.0,
    required this.animation,
  });

  /// Scrim/backdrop color
  @override
  final Color scrimColor;

  /// Blur strength for Glass theme (0 for others)
  @override
  final double blurStrength;

  /// Animation timing for overlay transitions
  @override
  final AnimationSpec animation;

  // --- Static Presets ---

  /// Standard overlay (Flat/Brutal/Neumorphic themes)
  static const standard = OverlaySpec(
    scrimColor: Color(0x8A000000), // black54
    blurStrength: 0.0,
    animation: AnimationSpec.standard,
  );

  /// Glass theme overlay with blur
  static const glass = OverlaySpec(
    scrimColor: Color(0x42000000), // black26
    blurStrength: 10.0,
    animation: AnimationSpec.slow,
  );

  /// Pixel theme overlay (no blur, instant)
  static const pixel = OverlaySpec(
    scrimColor: Color(0xDE000000), // black87
    blurStrength: 0.0,
    animation: AnimationSpec.instant,
  );

  // --- Override Support ---

  /// Create a new instance with specified values overridden.
  /// Unspecified values inherit from this instance.
  OverlaySpec withOverride({
    Color? scrimColor,
    double? blurStrength,
    AnimationSpec? animation,
  }) {
    return OverlaySpec(
      scrimColor: scrimColor ?? this.scrimColor,
      blurStrength: blurStrength ?? this.blurStrength,
      animation: animation ?? this.animation,
    );
  }
}
