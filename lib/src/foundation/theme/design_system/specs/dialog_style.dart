import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/overlay_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/surface_style.dart';

part 'dialog_style.tailor.dart';

/// Defines visual properties for modal dialogs.
///
/// Uses @TailorMixin for theme extension generation and composes
/// OverlaySpec for barrier/backdrop properties.
@TailorMixin()
class DialogStyle extends ThemeExtension<DialogStyle>
    with _$DialogStyleTailorMixin {
  /// Dialog box background, border, shadow.
  @override
  final SurfaceStyle containerStyle;

  /// Overlay specification for backdrop (scrim color, blur, animation).
  /// Replaces individual barrierColor and barrierBlur properties.
  @override
  final OverlaySpec overlay;

  /// Maximum dialog width.
  @override
  final double maxWidth;

  /// Internal content padding.
  @override
  final EdgeInsets padding;

  /// Gap between action buttons.
  @override
  final double buttonSpacing;

  /// Button row alignment.
  @override
  final MainAxisAlignment buttonAlignment;

  const DialogStyle({
    required this.containerStyle,
    required this.overlay,
    this.maxWidth = 400.0,
    this.padding = const EdgeInsets.all(24.0),
    this.buttonSpacing = 8.0,
    this.buttonAlignment = MainAxisAlignment.end,
  });

  /// Convenience getter for barrier color (from overlay.scrimColor).
  /// Provided for backward compatibility.
  @override
  Color get barrierColor => overlay.scrimColor;

  /// Convenience getter for barrier blur (from overlay.blurStrength).
  /// Provided for backward compatibility.
  @override
  double get barrierBlur => overlay.blurStrength;

  /// Creates a copy with selective overrides.
  /// Supports both new overlay-based API and legacy individual properties.
  DialogStyle withOverride({
    SurfaceStyle? containerStyle,
    OverlaySpec? overlay,
    double? maxWidth,
    EdgeInsets? padding,
    double? buttonSpacing,
    MainAxisAlignment? buttonAlignment,
    // Legacy parameters for backward compatibility
    Color? barrierColor,
    double? barrierBlur,
  }) {
    // If legacy parameters provided, merge into overlay
    OverlaySpec resolvedOverlay = overlay ?? this.overlay;
    if (barrierColor != null || barrierBlur != null) {
      resolvedOverlay = resolvedOverlay.withOverride(
        scrimColor: barrierColor,
        blurStrength: barrierBlur,
      );
    }

    return DialogStyle(
      containerStyle: containerStyle ?? this.containerStyle,
      overlay: resolvedOverlay,
      maxWidth: maxWidth ?? this.maxWidth,
      padding: padding ?? this.padding,
      buttonSpacing: buttonSpacing ?? this.buttonSpacing,
      buttonAlignment: buttonAlignment ?? this.buttonAlignment,
    );
  }
}
