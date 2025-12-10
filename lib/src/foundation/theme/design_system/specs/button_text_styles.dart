import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import '../../app_typography.dart';
import '../../../../molecules/buttons/app_button.dart';

part 'button_text_styles.tailor.dart';

/// Typography specifications for different button sizes.
///
/// This class defines text styling for each button size variant,
/// using Constitutional typography tokens exclusively to maintain
/// consistency with the global design system.
@TailorMixin()
class ButtonTextStyles extends ThemeExtension<ButtonTextStyles>
    with _$ButtonTextStylesTailorMixin {
  const ButtonTextStyles({
    required this.small,
    required this.medium,
    required this.large,
  });

  /// Typography for small size buttons.
  ///
  /// Uses labelMedium token for compact button interfaces
  /// while maintaining readability and accessibility.
  @override
  final TextStyle small;

  /// Typography for medium size buttons.
  ///
  /// Uses labelLarge token as the default button text size,
  /// providing optimal balance between prominence and space efficiency.
  @override
  final TextStyle medium;

  /// Typography for large size buttons.
  ///
  /// Uses titleMedium token for prominent call-to-action buttons
  /// where text emphasis is important for user experience.
  @override
  final TextStyle large;

  /// Returns the appropriate text style for the specified button size.
  ///
  /// [size] - The button size to get typography for
  /// Returns the TextStyle that should be applied to button text
  TextStyle getTextStyle(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return small;
      case AppButtonSize.medium:
        return medium;
      case AppButtonSize.large:
        return large;
    }
  }

  /// Creates default ButtonTextStyles using Constitutional typography tokens.
  ///
  /// This factory constructor ensures all button text styles use
  /// the appTextTheme tokens as required by the Constitution.
  factory ButtonTextStyles.fromAppTextTheme({
    required Color textColor,
  }) {
    return ButtonTextStyles(
      // Constitutional requirement: Use appTextTheme tokens exclusively
      small: appTextTheme.labelMedium!.copyWith(color: textColor),
      medium: appTextTheme.labelLarge!.copyWith(color: textColor),
      large: appTextTheme.titleMedium!.copyWith(color: textColor),
    );
  }
}