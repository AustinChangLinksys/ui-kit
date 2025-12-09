import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/surface_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';

part 'text_button_style.tailor.dart';

/// Style specification for AppTextButton component
///
/// Defines visual properties for text buttons including surface styles,
/// typography, and color specifications for different button states.
///
/// Follows Constitution 4.5: Uses @TailorMixin for automatic theme generation
/// Follows Constitution 4.6: Shared specs architecture for cross-theme consistency
/// Follows Constitution 3.1: IoC pattern - themes provide concrete implementations
@TailorMixin()
class TextButtonStyle extends ThemeExtension<TextButtonStyle> with _$TextButtonStyleTailorMixin {
  /// Creates a TextButtonStyle
  const TextButtonStyle({
    required this.enabledStyle,
    required this.disabledStyle,
    required this.hoverStyle,
    required this.pressedStyle,
    required this.enabledContentColor,
    required this.disabledContentColor,
    required this.smallTextStyle,
    required this.mediumTextStyle,
    required this.largeTextStyle,
    required this.interaction,
  });

  /// Surface style for enabled state
  /// Constitution 6.1: Uses SurfaceStyle for AppSurface integration
  @override
  final SurfaceStyle enabledStyle;

  /// Surface style for disabled state
  @override
  final SurfaceStyle disabledStyle;

  /// Surface style for hover state (web/desktop)
  @override
  final SurfaceStyle hoverStyle;

  /// Surface style for pressed state
  @override
  final SurfaceStyle pressedStyle;

  /// Content color for enabled state (text and icons)
  @override
  final Color enabledContentColor;

  /// Content color for disabled state (text and icons)
  @override
  final Color disabledContentColor;

  /// Text style for small buttons
  @override
  final TextStyle smallTextStyle;

  /// Text style for medium buttons
  @override
  final TextStyle mediumTextStyle;

  /// Text style for large buttons
  @override
  final TextStyle largeTextStyle;

  /// Interaction specifications for animations and feedback
  @override
  final InteractionSpec interaction;
}