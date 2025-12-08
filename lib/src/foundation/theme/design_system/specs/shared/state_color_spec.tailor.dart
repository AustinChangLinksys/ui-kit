// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'state_color_spec.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$StateColorSpecTailorMixin on ThemeExtension<StateColorSpec> {
  Color get active;
  Color get inactive;
  Color? get hover;
  Color? get pressed;
  Color? get disabled;
  Color? get error;

  @override
  StateColorSpec copyWith({
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

  @override
  StateColorSpec lerp(
      covariant ThemeExtension<StateColorSpec>? other, double t) {
    if (other is! StateColorSpec) return this as StateColorSpec;
    return StateColorSpec(
      active: Color.lerp(active, other.active, t)!,
      inactive: Color.lerp(inactive, other.inactive, t)!,
      hover: Color.lerp(hover, other.hover, t),
      pressed: Color.lerp(pressed, other.pressed, t),
      disabled: Color.lerp(disabled, other.disabled, t),
      error: Color.lerp(error, other.error, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is StateColorSpec &&
            const DeepCollectionEquality().equals(active, other.active) &&
            const DeepCollectionEquality().equals(inactive, other.inactive) &&
            const DeepCollectionEquality().equals(hover, other.hover) &&
            const DeepCollectionEquality().equals(pressed, other.pressed) &&
            const DeepCollectionEquality().equals(disabled, other.disabled) &&
            const DeepCollectionEquality().equals(error, other.error));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(active),
      const DeepCollectionEquality().hash(inactive),
      const DeepCollectionEquality().hash(hover),
      const DeepCollectionEquality().hash(pressed),
      const DeepCollectionEquality().hash(disabled),
      const DeepCollectionEquality().hash(error),
    );
  }
}

extension StateColorSpecBuildContextProps on BuildContext {
  StateColorSpec get stateColorSpec =>
      Theme.of(this).extension<StateColorSpec>()!;

  /// Color when element is active/selected
  Color get active => stateColorSpec.active;

  /// Color when element is inactive/unselected
  Color get inactive => stateColorSpec.inactive;

  /// Color when element is hovered (optional, falls back to active/inactive)
  Color? get hover => stateColorSpec.hover;

  /// Color when element is pressed (optional, falls back to active/inactive)
  Color? get pressed => stateColorSpec.pressed;

  /// Color when element is disabled (optional, falls back to inactive)
  Color? get disabled => stateColorSpec.disabled;

  /// Color when element has error state (optional)
  Color? get error => stateColorSpec.error;
}
