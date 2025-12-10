// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'button_size_spec.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ButtonSizeSpecTailorMixin on ThemeExtension<ButtonSizeSpec> {
  double get smallHeight;
  double get mediumHeight;
  double get largeHeight;
  EdgeInsets get smallPadding;
  EdgeInsets get mediumPadding;
  EdgeInsets get largePadding;
  double get iconSpacing;

  @override
  ButtonSizeSpec copyWith({
    double? smallHeight,
    double? mediumHeight,
    double? largeHeight,
    EdgeInsets? smallPadding,
    EdgeInsets? mediumPadding,
    EdgeInsets? largePadding,
    double? iconSpacing,
  }) {
    return ButtonSizeSpec(
      smallHeight: smallHeight ?? this.smallHeight,
      mediumHeight: mediumHeight ?? this.mediumHeight,
      largeHeight: largeHeight ?? this.largeHeight,
      smallPadding: smallPadding ?? this.smallPadding,
      mediumPadding: mediumPadding ?? this.mediumPadding,
      largePadding: largePadding ?? this.largePadding,
      iconSpacing: iconSpacing ?? this.iconSpacing,
    );
  }

  @override
  ButtonSizeSpec lerp(
      covariant ThemeExtension<ButtonSizeSpec>? other, double t) {
    if (other is! ButtonSizeSpec) return this as ButtonSizeSpec;
    return ButtonSizeSpec(
      smallHeight: t < 0.5 ? smallHeight : other.smallHeight,
      mediumHeight: t < 0.5 ? mediumHeight : other.mediumHeight,
      largeHeight: t < 0.5 ? largeHeight : other.largeHeight,
      smallPadding: t < 0.5 ? smallPadding : other.smallPadding,
      mediumPadding: t < 0.5 ? mediumPadding : other.mediumPadding,
      largePadding: t < 0.5 ? largePadding : other.largePadding,
      iconSpacing: t < 0.5 ? iconSpacing : other.iconSpacing,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonSizeSpec &&
            const DeepCollectionEquality()
                .equals(smallHeight, other.smallHeight) &&
            const DeepCollectionEquality()
                .equals(mediumHeight, other.mediumHeight) &&
            const DeepCollectionEquality()
                .equals(largeHeight, other.largeHeight) &&
            const DeepCollectionEquality()
                .equals(smallPadding, other.smallPadding) &&
            const DeepCollectionEquality()
                .equals(mediumPadding, other.mediumPadding) &&
            const DeepCollectionEquality()
                .equals(largePadding, other.largePadding) &&
            const DeepCollectionEquality()
                .equals(iconSpacing, other.iconSpacing));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(smallHeight),
      const DeepCollectionEquality().hash(mediumHeight),
      const DeepCollectionEquality().hash(largeHeight),
      const DeepCollectionEquality().hash(smallPadding),
      const DeepCollectionEquality().hash(mediumPadding),
      const DeepCollectionEquality().hash(largePadding),
      const DeepCollectionEquality().hash(iconSpacing),
    );
  }
}

extension ButtonSizeSpecBuildContextProps on BuildContext {
  ButtonSizeSpec get buttonSizeSpec =>
      Theme.of(this).extension<ButtonSizeSpec>()!;

  /// Height for small size buttons.
  ///
  /// Should maintain minimum touch target requirements while being
  /// visually appropriate for compact interfaces.
  double get smallHeight => buttonSizeSpec.smallHeight;

  /// Height for medium size buttons.
  ///
  /// This is the default size and should balance visual prominence
  /// with efficient use of screen space.
  double get mediumHeight => buttonSizeSpec.mediumHeight;

  /// Height for large size buttons.
  ///
  /// Used for primary call-to-action buttons and interfaces where
  /// button prominence is important for user experience.
  double get largeHeight => buttonSizeSpec.largeHeight;

  /// Horizontal padding for small buttons.
  ///
  /// Controls the internal spacing around button content for small size.
  EdgeInsets get smallPadding => buttonSizeSpec.smallPadding;

  /// Horizontal padding for medium buttons.
  ///
  /// Controls the internal spacing around button content for medium size.
  EdgeInsets get mediumPadding => buttonSizeSpec.mediumPadding;

  /// Horizontal padding for large buttons.
  ///
  /// Controls the internal spacing around button content for large size.
  EdgeInsets get largePadding => buttonSizeSpec.largePadding;

  /// Space between icon and text in buttons with both elements.
  ///
  /// Applied consistently regardless of icon position (leading/trailing)
  /// to maintain visual balance.
  double get iconSpacing => buttonSizeSpec.iconSpacing;
}
