// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'button_text_styles.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ButtonTextStylesTailorMixin on ThemeExtension<ButtonTextStyles> {
  TextStyle get small;
  TextStyle get medium;
  TextStyle get large;

  @override
  ButtonTextStyles copyWith({
    TextStyle? small,
    TextStyle? medium,
    TextStyle? large,
  }) {
    return ButtonTextStyles(
      small: small ?? this.small,
      medium: medium ?? this.medium,
      large: large ?? this.large,
    );
  }

  @override
  ButtonTextStyles lerp(
      covariant ThemeExtension<ButtonTextStyles>? other, double t) {
    if (other is! ButtonTextStyles) return this as ButtonTextStyles;
    return ButtonTextStyles(
      small: TextStyle.lerp(small, other.small, t)!,
      medium: TextStyle.lerp(medium, other.medium, t)!,
      large: TextStyle.lerp(large, other.large, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ButtonTextStyles &&
            const DeepCollectionEquality().equals(small, other.small) &&
            const DeepCollectionEquality().equals(medium, other.medium) &&
            const DeepCollectionEquality().equals(large, other.large));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(small),
      const DeepCollectionEquality().hash(medium),
      const DeepCollectionEquality().hash(large),
    );
  }
}

extension ButtonTextStylesBuildContextProps on BuildContext {
  ButtonTextStyles get buttonTextStyles =>
      Theme.of(this).extension<ButtonTextStyles>()!;

  /// Typography for small size buttons.
  ///
  /// Uses labelMedium token for compact button interfaces
  /// while maintaining readability and accessibility.
  TextStyle get small => buttonTextStyles.small;

  /// Typography for medium size buttons.
  ///
  /// Uses labelLarge token as the default button text size,
  /// providing optimal balance between prominence and space efficiency.
  TextStyle get medium => buttonTextStyles.medium;

  /// Typography for large size buttons.
  ///
  /// Uses titleMedium token for prominent call-to-action buttons
  /// where text emphasis is important for user experience.
  TextStyle get large => buttonTextStyles.large;
}
