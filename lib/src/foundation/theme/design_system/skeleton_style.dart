import 'package:flutter/material.dart';

/// Defines the animation behavior for loading skeletons.
enum SkeletonAnimationType {
  /// Standard gradient scan (used in Flat/Material themes).
  shimmer,
  
  /// Smooth opacity breathing (used in Glassmorphism).
  pulse,
  
  /// Hard on/off blinking (used in Neo-Brutalism).
  blink,
}

/// Specification for the Skeleton loading state appearance.
/// This allows the Skeleton to adapt to the active Design Language.
class SkeletonStyle {
  /// The background color of the skeleton shape.
  final Color baseColor;
  
  /// The highlight/active color used in the animation.
  final Color highlightColor;
  
  /// The type of animation to perform.
  final SkeletonAnimationType animationType;
  
  /// Overrides the border radius if needed.
  /// If null, it might default to the Theme's standard radius.
  final double borderRadius;

  const SkeletonStyle({
    required this.baseColor,
    required this.highlightColor,
    this.animationType = SkeletonAnimationType.shimmer,
    this.borderRadius = 8.0,
  });
}