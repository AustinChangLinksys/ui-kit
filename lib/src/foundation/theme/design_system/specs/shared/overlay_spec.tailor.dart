// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'overlay_spec.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$OverlaySpecTailorMixin on ThemeExtension<OverlaySpec> {
  Color get scrimColor;
  double get blurStrength;
  AnimationSpec get animation;

  @override
  OverlaySpec copyWith({
    Color? scrimColor,
    double? blurStrength,
    AnimationSpec? animation,
  }) {
    return OverlaySpec(
      scrimColor: scrimColor ?? this.scrimColor,
      blurStrength: blurStrength ?? this.blurStrength,
      animation: animation ?? this.animation,
    );
  }

  @override
  OverlaySpec lerp(covariant ThemeExtension<OverlaySpec>? other, double t) {
    if (other is! OverlaySpec) return this as OverlaySpec;
    return OverlaySpec(
      scrimColor: Color.lerp(scrimColor, other.scrimColor, t)!,
      blurStrength: t < 0.5 ? blurStrength : other.blurStrength,
      animation: animation.lerp(other.animation, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is OverlaySpec &&
            const DeepCollectionEquality()
                .equals(scrimColor, other.scrimColor) &&
            const DeepCollectionEquality()
                .equals(blurStrength, other.blurStrength) &&
            const DeepCollectionEquality().equals(animation, other.animation));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(scrimColor),
      const DeepCollectionEquality().hash(blurStrength),
      const DeepCollectionEquality().hash(animation),
    );
  }
}

extension OverlaySpecBuildContextProps on BuildContext {
  OverlaySpec get overlaySpec => Theme.of(this).extension<OverlaySpec>()!;

  /// Scrim/backdrop color
  Color get scrimColor => overlaySpec.scrimColor;

  /// Blur strength for Glass theme (0 for others)
  double get blurStrength => overlaySpec.blurStrength;

  /// Animation timing for overlay transitions
  AnimationSpec get animation => overlaySpec.animation;
}
