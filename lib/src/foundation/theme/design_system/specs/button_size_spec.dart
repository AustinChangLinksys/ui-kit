import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import '../../../../molecules/buttons/app_button.dart';

part 'button_size_spec.tailor.dart';

/// Size specifications for consistent button dimensions across variants.
///
/// This class defines the sizing properties for all button sizes,
/// ensuring consistent dimensions and spacing across all button types
/// and themes while maintaining accessibility requirements.
@TailorMixin()
class ButtonSizeSpec extends ThemeExtension<ButtonSizeSpec>
    with _$ButtonSizeSpecTailorMixin {
  const ButtonSizeSpec({
    required this.smallHeight,
    required this.mediumHeight,
    required this.largeHeight,
    required this.smallPadding,
    required this.mediumPadding,
    required this.largePadding,
    required this.iconSpacing,
  });

  /// Height for small size buttons.
  ///
  /// Should maintain minimum touch target requirements while being
  /// visually appropriate for compact interfaces.
  @override
  final double smallHeight;

  /// Height for medium size buttons.
  ///
  /// This is the default size and should balance visual prominence
  /// with efficient use of screen space.
  @override
  final double mediumHeight;

  /// Height for large size buttons.
  ///
  /// Used for primary call-to-action buttons and interfaces where
  /// button prominence is important for user experience.
  @override
  final double largeHeight;

  /// Horizontal padding for small buttons.
  ///
  /// Controls the internal spacing around button content for small size.
  @override
  final EdgeInsets smallPadding;

  /// Horizontal padding for medium buttons.
  ///
  /// Controls the internal spacing around button content for medium size.
  @override
  final EdgeInsets mediumPadding;

  /// Horizontal padding for large buttons.
  ///
  /// Controls the internal spacing around button content for large size.
  @override
  final EdgeInsets largePadding;

  /// Space between icon and text in buttons with both elements.
  ///
  /// Applied consistently regardless of icon position (leading/trailing)
  /// to maintain visual balance.
  @override
  final double iconSpacing;

  /// Returns the height for the specified button size.
  ///
  /// [size] - The button size to get height for
  /// Returns the height value in logical pixels
  double getHeight(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return smallHeight;
      case AppButtonSize.medium:
        return mediumHeight;
      case AppButtonSize.large:
        return largeHeight;
    }
  }

  /// Returns the padding for the specified button size.
  ///
  /// [size] - The button size to get padding for
  /// Returns the EdgeInsets value for internal content padding
  EdgeInsets getPadding(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return smallPadding;
      case AppButtonSize.medium:
        return mediumPadding;
      case AppButtonSize.large:
        return largePadding;
    }
  }
}