import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'button_surface_states.dart';
import 'button_size_spec.dart';
import 'button_text_styles.dart';
import 'interaction_spec.dart';
import 'shared/state_color_spec.dart';
import '../../../../molecules/buttons/enums/button_style_variant.dart';
import '../../../../molecules/buttons/app_button.dart';
import 'surface_style.dart';

part 'button_style.tailor.dart';

/// Unified theme extension containing all button styling information for all variants.
///
/// This class consolidates AppButtonStyle, IconAppButtonStyle, and TextAppButtonStyle
/// into a single system that supports three style variants (filled, outline, text)
/// with consistent state management and theming across all button types.
@TailorMixin()
class AppButtonStyle extends ThemeExtension<AppButtonStyle>
    with _$AppButtonStyleTailorMixin {
  const AppButtonStyle({
    required this.filledSurfaces,
    required this.filledContentColors,
    required this.outlineSurfaces,
    required this.outlineContentColors,
    required this.textSurfaces,
    required this.textContentColors,
    required this.textStyles,
    required this.sizeSpec,
    required this.interaction,
  });

  // Filled variant styles
  /// Surface states for filled variant buttons.
  ///
  /// Defines how filled buttons (solid background) appear in different
  /// interaction states (enabled, disabled, hovered, pressed).
  @override
  final ButtonSurfaceStates filledSurfaces;

  /// Content colors for filled variant buttons.
  ///
  /// Defines text and icon colors for filled buttons across all states
  /// using StateColorSpec for consistent state management.
  @override
  final StateColorSpec filledContentColors;

  // Outline variant styles
  /// Surface states for outline variant buttons.
  ///
  /// Defines how outline buttons (transparent background, visible border)
  /// appear in different interaction states.
  @override
  final ButtonSurfaceStates outlineSurfaces;

  /// Content colors for outline variant buttons.
  ///
  /// Defines text and icon colors for outline buttons across all states
  /// using StateColorSpec for consistent state management.
  @override
  final StateColorSpec outlineContentColors;

  // Text variant styles
  /// Surface states for text variant buttons.
  ///
  /// Defines how text buttons (no background or border) appear in
  /// different interaction states.
  @override
  final ButtonSurfaceStates textSurfaces;

  /// Content colors for text variant buttons.
  ///
  /// Defines text and icon colors for text-only buttons across all states
  /// using StateColorSpec for consistent state management.
  @override
  final StateColorSpec textContentColors;

  // Shared properties
  /// Typography definitions for all button sizes.
  ///
  /// Provides consistent text styling across all button variants
  /// using Constitutional appTextTheme tokens.
  @override
  final ButtonTextStyles textStyles;

  /// Size specifications for all button dimensions.
  ///
  /// Defines heights, padding, and spacing for small, medium, and large
  /// button sizes across all variants.
  @override
  final ButtonSizeSpec sizeSpec;

  /// Interaction specifications for button animations and feedback.
  ///
  /// Defines how buttons respond to user interactions with consistent
  /// animation timing and visual feedback across the design system.
  @override
  final InteractionSpec interaction;

  /// Resolves the appropriate surface style for the specified variant and state.
  ///
  /// [variant] - The button style variant (filled, outline, text)
  /// [isEnabled] - Whether the button is enabled (has onTap callback)
  /// [isHovered] - Whether the button is currently being hovered
  /// [isPressed] - Whether the button is currently being pressed
  ///
  /// Returns the [SurfaceStyle] that should be applied for the current state.
  SurfaceStyle getSurface(
    ButtonStyleVariant variant, {
    required bool isEnabled,
    bool isHovered = false,
    bool isPressed = false,
  }) {
    final surfaces = _getSurfacesForVariant(variant);
    return surfaces.resolve(
      isEnabled: isEnabled,
      isHovered: isHovered,
      isPressed: isPressed,
    );
  }

  /// Resolves the appropriate content color for the specified variant and state.
  ///
  /// [variant] - The button style variant (filled, outline, text)
  /// [isEnabled] - Whether the button is enabled
  /// [isHovered] - Whether the button is currently being hovered
  /// [isPressed] - Whether the button is currently being pressed
  /// [hasError] - Whether the button is in an error state
  /// [isActive] - Whether the button represents an active/selected state
  ///
  /// Returns the [Color] that should be applied to text and icons.
  Color getContentColor(
    ButtonStyleVariant variant, {
    required bool isEnabled,
    bool isHovered = false,
    bool isPressed = false,
    bool hasError = false,
    bool isActive = false,
  }) {
    final colors = _getContentColorsForVariant(variant);
    return colors.resolve(
      isActive: isActive,
      isDisabled: !isEnabled,
      hasError: hasError,
      isHovered: isHovered,
      isPressed: isPressed,
    );
  }

  /// Returns the appropriate text style for the specified button size.
  ///
  /// [size] - The button size to get typography for
  /// Returns the [TextStyle] that should be applied to button text
  TextStyle getTextStyle(AppButtonSize size) {
    return textStyles.getTextStyle(size);
  }

  /// Gets the ButtonSurfaceStates for the specified variant.
  ButtonSurfaceStates _getSurfacesForVariant(ButtonStyleVariant variant) {
    switch (variant) {
      case ButtonStyleVariant.filled:
        return filledSurfaces;
      case ButtonStyleVariant.outline:
        return outlineSurfaces;
      case ButtonStyleVariant.text:
        return textSurfaces;
    }
  }

  /// Gets the StateColorSpec for the specified variant.
  StateColorSpec _getContentColorsForVariant(ButtonStyleVariant variant) {
    switch (variant) {
      case ButtonStyleVariant.filled:
        return filledContentColors;
      case ButtonStyleVariant.outline:
        return outlineContentColors;
      case ButtonStyleVariant.text:
        return textContentColors;
    }
  }
}