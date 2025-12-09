import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'state_color_spec.tailor.dart';

/// Shared specification for state-based colors (active/inactive/hover/pressed/disabled/error).
///
/// Use [resolve] to get the appropriate color based on current state.
///
/// Example:
/// ```dart
/// final color = stateColors.resolve(isActive: isSelected);
/// final color = stateColors.resolve(isActive: false, isHovered: true);
/// final color = stateColors.resolve(isActive: true, isPressed: true);
/// ```
@TailorMixin()
class StateColorSpec extends ThemeExtension<StateColorSpec>
    with _$StateColorSpecTailorMixin {
  const StateColorSpec({
    required this.active,
    required this.inactive,
    this.hover,
    this.pressed,
    this.disabled,
    this.error,
  });

  /// Color when element is active/selected
  @override
  final Color active;

  /// Color when element is inactive/unselected
  @override
  final Color inactive;

  /// Color when element is hovered (optional, falls back to active/inactive)
  @override
  final Color? hover;

  /// Color when element is pressed (optional, falls back to active/inactive)
  @override
  final Color? pressed;

  /// Color when element is disabled (optional, falls back to inactive)
  @override
  final Color? disabled;

  /// Color when element has error state (optional)
  @override
  final Color? error;

  // --- State Resolution ---

  /// Resolve the appropriate color based on current state.
  ///
  /// Priority: error > disabled > pressed > hover > active/inactive
  ///
  /// Example:
  /// ```dart
  /// final color = stateColors.resolve(isActive: isSelected);
  /// final color = stateColors.resolve(isActive: false, isHovered: true);
  /// final color = stateColors.resolve(isActive: true, isPressed: true);
  /// final color = stateColors.resolve(isActive: false, isDisabled: true);
  /// ```
  Color resolve({
    required bool isActive,
    bool isHovered = false,
    bool isPressed = false,
    bool isDisabled = false,
    bool hasError = false,
  }) {
    if (hasError && error != null) return error!;
    if (isDisabled) return disabled ?? inactive;
    if (isPressed && pressed != null) return pressed!;
    if (isHovered && hover != null) return hover!;
    return isActive ? active : inactive;
  }

  // --- Override Support ---

  /// Create a new instance with specified values overridden.
  /// Unspecified values inherit from this instance.
  StateColorSpec withOverride({
    Color? active,
    Color? inactive,
    Color? hover,
    Color? pressed,
    Color? disabled,
    Color? error,
  }) {
    return StateColorSpec(
      active: active ?? this.active,
      inactive: inactive ?? this.inactive,
      hover: hover ?? this.hover,
      pressed: pressed ?? this.pressed,
      disabled: disabled ?? this.disabled,
      error: error ?? this.error,
    );
  }
}
