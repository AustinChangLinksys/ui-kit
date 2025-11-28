import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Defines the visual appearance of a container.
class SurfaceStyle extends Equatable {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final List<BoxShadow> shadows;
  final double blurStrength; // Sigma for BackdropFilter (0 for non-glass)
  final Color contentColor; // Default text/icon color on this surface

  const SurfaceStyle({
    required this.backgroundColor,
    required this.borderColor,
    this.borderWidth = 0.0,
    this.borderRadius = 0.0,
    this.shadows = const [],
    this.blurStrength = 0.0,
    required this.contentColor,
  });

  @override
  List<Object?> get props => [
        backgroundColor,
        borderColor,
        borderWidth,
        borderRadius,
        shadows,
        blurStrength,
        contentColor,
      ];
}

/// Defines motion physics.
class AnimationSpec extends Equatable {
  final Duration duration;
  final Curve curve;

  const AnimationSpec({
    required this.duration,
    required this.curve,
  });

  @override
  List<Object?> get props => [duration, curve];
}

/// Defines font choices.
class TypographySpec extends Equatable {
  final String? bodyFontFamily;
  final String? displayFontFamily;

  const TypographySpec({
    this.bodyFontFamily,
    this.displayFontFamily,
  });

  @override
  List<Object?> get props => [bodyFontFamily, displayFontFamily];
}
