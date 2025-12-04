import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/surface_style.dart';

/// Defines visual properties for modal dialogs.
class DialogStyle extends Equatable {
  /// Dialog box background, border, shadow.
  final SurfaceStyle containerStyle;

  /// Semi-transparent backdrop color.
  final Color barrierColor;

  /// Backdrop blur for Glass mode (0 for others).
  final double barrierBlur;

  /// Maximum dialog width.
  final double maxWidth;

  /// Internal content padding.
  final EdgeInsets padding;

  /// Gap between action buttons.
  final double buttonSpacing;

  /// Button row alignment.
  final MainAxisAlignment buttonAlignment;

  const DialogStyle({
    required this.containerStyle,
    this.barrierColor = const Color(0x80000000),
    this.barrierBlur = 0.0,
    this.maxWidth = 400.0,
    this.padding = const EdgeInsets.all(24.0),
    this.buttonSpacing = 8.0,
    this.buttonAlignment = MainAxisAlignment.end,
  });

  DialogStyle copyWith({
    SurfaceStyle? containerStyle,
    Color? barrierColor,
    double? barrierBlur,
    double? maxWidth,
    EdgeInsets? padding,
    double? buttonSpacing,
    MainAxisAlignment? buttonAlignment,
  }) {
    return DialogStyle(
      containerStyle: containerStyle ?? this.containerStyle,
      barrierColor: barrierColor ?? this.barrierColor,
      barrierBlur: barrierBlur ?? this.barrierBlur,
      maxWidth: maxWidth ?? this.maxWidth,
      padding: padding ?? this.padding,
      buttonSpacing: buttonSpacing ?? this.buttonSpacing,
      buttonAlignment: buttonAlignment ?? this.buttonAlignment,
    );
  }

  static DialogStyle lerp(DialogStyle a, DialogStyle b, double t) {
    return DialogStyle(
      containerStyle: a.containerStyle,
      barrierColor: Color.lerp(a.barrierColor, b.barrierColor, t) ?? a.barrierColor,
      barrierBlur: _lerpDouble(a.barrierBlur, b.barrierBlur, t),
      maxWidth: _lerpDouble(a.maxWidth, b.maxWidth, t),
      padding: EdgeInsets.lerp(a.padding, b.padding, t) ?? a.padding,
      buttonSpacing: _lerpDouble(a.buttonSpacing, b.buttonSpacing, t),
      buttonAlignment: t < 0.5 ? a.buttonAlignment : b.buttonAlignment,
    );
  }

  @override
  List<Object?> get props => [
        containerStyle,
        barrierColor,
        barrierBlur,
        maxWidth,
        padding,
        buttonSpacing,
        buttonAlignment,
      ];
}

double _lerpDouble(double a, double b, double t) {
  return a + (b - a) * t;
}
