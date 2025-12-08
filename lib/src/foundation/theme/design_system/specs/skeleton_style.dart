import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'shared/shared_specs.dart';

part 'skeleton_style.tailor.dart';

/// Defines the animation behavior for loading skeletons.
enum SkeletonAnimationType {
  /// Standard gradient scan (used in Flat/Material themes).
  shimmer,

  /// Smooth opacity breathing (used in Glassmorphism).
  pulse,

  /// Hard on/off blinking (used in Neo-Brutalism).
  blink,
}

/// Style specification for skeleton loading components (AppSkeleton).
///
/// Composes [AnimationSpec] for animation timing.
///
/// Example:
/// ```dart
/// SkeletonStyle(
///   baseColor: Colors.grey.shade300,
///   highlightColor: Colors.grey.shade100,
///   animationType: SkeletonAnimationType.shimmer,
///   borderRadius: 8.0,
///   animation: AnimationSpec.standard,
/// )
/// ```
@TailorMixin()
class SkeletonStyle extends ThemeExtension<SkeletonStyle>
    with _$SkeletonStyleTailorMixin {
  const SkeletonStyle({
    required this.baseColor,
    required this.highlightColor,
    required this.animationType,
    required this.borderRadius,
    this.animation = AnimationSpec.standard,
  });

  /// The background color of the skeleton shape.
  @override
  final Color baseColor;

  /// The highlight/active color used in the animation.
  @override
  final Color highlightColor;

  /// The type of animation to perform.
  @override
  final SkeletonAnimationType animationType;

  /// Border radius for skeleton shapes.
  @override
  final double borderRadius;

  /// Animation timing for skeleton effects (shimmer/pulse/blink).
  @override
  final AnimationSpec animation;

  // --- Backward Compatibility Getters ---

  /// @deprecated Use [animation.duration] instead
  @override
  Duration get animationDuration => animation.duration;

  /// @deprecated Use [animation.curve] instead
  @override
  Curve get animationCurve => animation.curve;
}
