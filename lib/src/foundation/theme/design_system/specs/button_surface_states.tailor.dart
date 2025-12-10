// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'button_surface_states.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ButtonSurfaceStatesTailorMixin on ThemeExtension<ButtonSurfaceStates> {
  SurfaceStyle get enabled;
  SurfaceStyle get disabled;
  SurfaceStyle get hovered;
  SurfaceStyle get pressed;

  @override
  ButtonSurfaceStates copyWith({
    SurfaceStyle? enabled,
    SurfaceStyle? disabled,
    SurfaceStyle? hovered,
    SurfaceStyle? pressed,
  }) {
    return ButtonSurfaceStates(
      enabled: enabled ?? this.enabled,
      disabled: disabled ?? this.disabled,
      hovered: hovered ?? this.hovered,
      pressed: pressed ?? this.pressed,
    );
  }

  @override
  ButtonSurfaceStates lerp(
      covariant ThemeExtension<ButtonSurfaceStates>? other, double t) {
    if (other is! ButtonSurfaceStates) return this as ButtonSurfaceStates;
    return ButtonSurfaceStates(
      enabled: t < 0.5 ? enabled : other.enabled,
      disabled: t < 0.5 ? disabled : other.disabled,
      hovered: t < 0.5 ? hovered : other.hovered,
      pressed: t < 0.5 ? pressed : other.pressed,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonSurfaceStates &&
            const DeepCollectionEquality().equals(enabled, other.enabled) &&
            const DeepCollectionEquality().equals(disabled, other.disabled) &&
            const DeepCollectionEquality().equals(hovered, other.hovered) &&
            const DeepCollectionEquality().equals(pressed, other.pressed));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(enabled),
      const DeepCollectionEquality().hash(disabled),
      const DeepCollectionEquality().hash(hovered),
      const DeepCollectionEquality().hash(pressed),
    );
  }
}

extension ButtonSurfaceStatesBuildContextProps on BuildContext {
  ButtonSurfaceStates get buttonSurfaceStates =>
      Theme.of(this).extension<ButtonSurfaceStates>()!;

  /// Default interactive state for enabled buttons.
  ///
  /// This surface style is applied when the button is enabled and
  /// not currently being interacted with.
  SurfaceStyle get enabled => buttonSurfaceStates.enabled;

  /// Non-interactive state for disabled buttons.
  ///
  /// This surface style is applied when the button's onTap callback
  /// is null or the button is otherwise marked as disabled.
  SurfaceStyle get disabled => buttonSurfaceStates.disabled;

  /// Mouse hover state for enabled buttons.
  ///
  /// This surface style is applied when the user's cursor is hovering
  /// over an enabled button on platforms that support hover interactions.
  SurfaceStyle get hovered => buttonSurfaceStates.hovered;

  /// Active press state for enabled buttons.
  ///
  /// This surface style is applied when the user is actively pressing
  /// down on an enabled button, typically during the tap interaction.
  SurfaceStyle get pressed => buttonSurfaceStates.pressed;
}
