import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'surface_style.dart';

part 'button_surface_states.tailor.dart';

/// State-aware surface definitions for button appearances.
///
/// This class defines how button surfaces should appear in different
/// interaction states, providing the foundation for consistent button
/// styling across all variants and themes.
@TailorMixin()
class ButtonSurfaceStates extends ThemeExtension<ButtonSurfaceStates>
    with _$ButtonSurfaceStatesTailorMixin {
  const ButtonSurfaceStates({
    required this.enabled,
    required this.disabled,
    required this.hovered,
    required this.pressed,
  });

  /// Default interactive state for enabled buttons.
  ///
  /// This surface style is applied when the button is enabled and
  /// not currently being interacted with.
  @override
  final SurfaceStyle enabled;

  /// Non-interactive state for disabled buttons.
  ///
  /// This surface style is applied when the button's onTap callback
  /// is null or the button is otherwise marked as disabled.
  @override
  final SurfaceStyle disabled;

  /// Mouse hover state for enabled buttons.
  ///
  /// This surface style is applied when the user's cursor is hovering
  /// over an enabled button on platforms that support hover interactions.
  @override
  final SurfaceStyle hovered;

  /// Active press state for enabled buttons.
  ///
  /// This surface style is applied when the user is actively pressing
  /// down on an enabled button, typically during the tap interaction.
  @override
  final SurfaceStyle pressed;

  /// Resolves the appropriate surface style based on current button state.
  ///
  /// The resolution follows priority order: disabled → pressed → hovered → enabled
  ///
  /// [isEnabled] - Whether the button is enabled (has onTap callback)
  /// [isHovered] - Whether the button is currently being hovered (desktop/web)
  /// [isPressed] - Whether the button is currently being pressed
  ///
  /// Returns the [SurfaceStyle] that should be applied for the current state.
  SurfaceStyle resolve({
    required bool isEnabled,
    bool isHovered = false,
    bool isPressed = false,
  }) {
    if (!isEnabled) return disabled;
    if (isPressed) return pressed;
    if (isHovered) return hovered;
    return enabled;
  }
}