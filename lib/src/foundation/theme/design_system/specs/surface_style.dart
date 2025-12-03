import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';

/// Defines the visual appearance of a container.
class SurfaceStyle extends Equatable {
  final Color backgroundColor;
  final Color borderColor;
  final double borderWidth;
  final double borderRadius;
  final List<BoxShadow> shadows;
  final double blurStrength; // Sigma for BackdropFilter (0 for non-glass)
  final Color contentColor; // Default text/icon color on this surface
  final InteractionSpec? interaction;
  final BoxBorder? customBorder;
  final ImageProvider? texture;
  final double textureOpacity;

  const SurfaceStyle({
    required this.backgroundColor,
    required this.borderColor,
    this.borderWidth = 0.0,
    this.borderRadius = 0.0,
    this.shadows = const [],
    this.blurStrength = 0.0,
    required this.contentColor,
    this.interaction,
    this.customBorder,
    this.texture,
    this.textureOpacity = 1.0,
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
        interaction,
        customBorder,
        texture,
        textureOpacity,
      ];

  SurfaceStyle copyWith({
    double? borderRadius,
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    List<BoxShadow>? shadows,
    double? blurStrength,
    Color? contentColor,
    InteractionSpec? interaction,
    BoxBorder? customBorder,
    ImageProvider? texture,
    double? textureOpacity,
  }) {
    return SurfaceStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      shadows: shadows ?? this.shadows,
      blurStrength: blurStrength ?? this.blurStrength,
      contentColor: contentColor ?? this.contentColor,
      interaction: interaction ?? this.interaction,
      customBorder: customBorder ?? this.customBorder,
      texture: texture ?? this.texture,
      textureOpacity: textureOpacity ?? this.textureOpacity,
    );
  }
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
    this.bodyFontFamily = 'NeueHaasGrotTextRound',
    this.displayFontFamily = 'NeueHaasGrotTextRound',
  });

  @override
  List<Object?> get props => [bodyFontFamily, displayFontFamily];
}
