import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/state_color_spec.dart';

part 'styled_text_style.tailor.dart';

/// Theme specification for AppStyledText component.
///
/// Follows Constitution 4.6 Shared Specs Architecture by composing
/// [AnimationSpec] and [StateColorSpec] instead of duplicating properties.
///
/// Constitution Compliance:
/// - 4.5: Uses @TailorMixin for theme generation
/// - 4.6: Composes shared specs (AnimationSpec, StateColorSpec)
/// - 4.9: Uses typography tokens instead of hardcoded styles
@TailorMixin()
class StyledTextStyle extends ThemeExtension<StyledTextStyle>
    with _$StyledTextStyleTailorMixin {
  const StyledTextStyle({
    required this.baseTextStyle,
    required this.linkColors,
    required this.linkAnimation,
    required this.largeTextStyle,
    required this.smallTextStyle,
    required this.boldTextStyle,
    required this.italicTextStyle,
    required this.underlineTextStyle,
    required this.colorTextStyle,
    this.linkDecoration = TextDecoration.underline,
    this.linkDecorationThickness = 1.0,
    this.linkShadows,
    this.linkBackgroundColor,
  });

  /// Base text style - uses theme typography tokens
  @override
  final TextStyle baseTextStyle;

  /// Color specification for link states (normal/hover/pressed/disabled)
  @override
  final StateColorSpec linkColors;

  /// Animation specification for link interactions
  @override
  final AnimationSpec linkAnimation;

  /// Typography token for large text variant
  @override
  final TextStyle largeTextStyle;

  /// Typography token for small text variant
  @override
  final TextStyle smallTextStyle;

  /// Typography token for bold text variant
  @override
  final TextStyle boldTextStyle;

  /// Typography token for italic text variant
  @override
  final TextStyle italicTextStyle;

  /// Typography token for underlined text variant
  @override
  final TextStyle underlineTextStyle;

  /// Typography token for colored text variant
  @override
  final TextStyle colorTextStyle;

  /// Link text decoration (underline, none, etc.)
  @override
  final TextDecoration linkDecoration;

  /// Link text decoration thickness
  @override
  final double linkDecorationThickness;

  /// Optional shadows for link text (used in Glass theme)
  @override
  final List<Shadow>? linkShadows;

  /// Optional background color for link text (used in Brutal theme)
  @override
  final Color? linkBackgroundColor;
}