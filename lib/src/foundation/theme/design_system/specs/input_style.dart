import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import 'surface_style.dart';

part 'input_style.tailor.dart';

/// Defines four basic variants and state modifiers for input fields.
///
/// Example:
/// ```dart
/// InputStyle(
///   outlineStyle: SurfaceStyle(...),
///   underlineStyle: SurfaceStyle(...),
///   filledStyle: SurfaceStyle(...),
///   focusModifier: SurfaceStyle(...),
///   errorModifier: SurfaceStyle(...),
/// )
/// ```
@TailorMixin()
class InputStyle extends ThemeExtension<InputStyle>
    with _$InputStyleTailorMixin {
  const InputStyle({
    required this.outlineStyle,
    required this.underlineStyle,
    required this.filledStyle,
    required this.focusModifier,
    required this.errorModifier,
  });

  // Basic variants (determined by AppTextField.variant)
  /// Outline style variant for input fields.
  @override
  final SurfaceStyle outlineStyle;

  /// Underline style variant for input fields.
  @override
  final SurfaceStyle underlineStyle;

  /// Filled style variant for input fields.
  @override
  final SurfaceStyle filledStyle;

  // State modifiers (determined by AppTextField internal state, overlaid when Focused)
  /// Style modifier applied when input is focused.
  @override
  final SurfaceStyle focusModifier;

  /// Style modifier applied when input has an error.
  @override
  final SurfaceStyle errorModifier;
}
