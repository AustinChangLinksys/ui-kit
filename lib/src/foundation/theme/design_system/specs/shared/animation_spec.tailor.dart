// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'animation_spec.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AnimationSpecTailorMixin on ThemeExtension<AnimationSpec> {
  Duration get duration;
  Curve get curve;

  @override
  AnimationSpec copyWith({
    Duration? duration,
    Curve? curve,
  }) {
    return AnimationSpec(
      duration: duration ?? this.duration,
      curve: curve ?? this.curve,
    );
  }

  @override
  AnimationSpec lerp(covariant ThemeExtension<AnimationSpec>? other, double t) {
    if (other is! AnimationSpec) return this as AnimationSpec;
    return AnimationSpec(
      duration: t < 0.5 ? duration : other.duration,
      curve: t < 0.5 ? curve : other.curve,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AnimationSpec &&
            const DeepCollectionEquality().equals(duration, other.duration) &&
            const DeepCollectionEquality().equals(curve, other.curve));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(duration),
      const DeepCollectionEquality().hash(curve),
    );
  }
}

extension AnimationSpecBuildContextProps on BuildContext {
  AnimationSpec get animationSpec => Theme.of(this).extension<AnimationSpec>()!;

  /// Animation duration
  Duration get duration => animationSpec.duration;

  /// Animation curve
  Curve get curve => animationSpec.curve;
}
