// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'carousel_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$CarouselStyleTailorMixin on ThemeExtension<CarouselStyle> {
  Color get navButtonColor;
  Color get navButtonHoverColor;
  IconData get previousIcon;
  IconData get nextIcon;
  Duration get animationDuration;
  Curve get animationCurve;

  @override
  CarouselStyle copyWith({
    Color? navButtonColor,
    Color? navButtonHoverColor,
    IconData? previousIcon,
    IconData? nextIcon,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return CarouselStyle(
      navButtonColor: navButtonColor ?? this.navButtonColor,
      navButtonHoverColor: navButtonHoverColor ?? this.navButtonHoverColor,
      previousIcon: previousIcon ?? this.previousIcon,
      nextIcon: nextIcon ?? this.nextIcon,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
    );
  }

  @override
  CarouselStyle lerp(covariant ThemeExtension<CarouselStyle>? other, double t) {
    if (other is! CarouselStyle) return this as CarouselStyle;
    return CarouselStyle(
      navButtonColor: Color.lerp(navButtonColor, other.navButtonColor, t)!,
      navButtonHoverColor:
          Color.lerp(navButtonHoverColor, other.navButtonHoverColor, t)!,
      previousIcon: t < 0.5 ? previousIcon : other.previousIcon,
      nextIcon: t < 0.5 ? nextIcon : other.nextIcon,
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CarouselStyle &&
            const DeepCollectionEquality()
                .equals(navButtonColor, other.navButtonColor) &&
            const DeepCollectionEquality()
                .equals(navButtonHoverColor, other.navButtonHoverColor) &&
            const DeepCollectionEquality()
                .equals(previousIcon, other.previousIcon) &&
            const DeepCollectionEquality().equals(nextIcon, other.nextIcon) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration) &&
            const DeepCollectionEquality()
                .equals(animationCurve, other.animationCurve));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(navButtonColor),
      const DeepCollectionEquality().hash(navButtonHoverColor),
      const DeepCollectionEquality().hash(previousIcon),
      const DeepCollectionEquality().hash(nextIcon),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
    );
  }
}

extension CarouselStyleBuildContextProps on BuildContext {
  CarouselStyle get carouselStyle => Theme.of(this).extension<CarouselStyle>()!;

  /// Color of navigation buttons
  Color get navButtonColor => carouselStyle.navButtonColor;

  /// Color of navigation buttons on hover
  Color get navButtonHoverColor => carouselStyle.navButtonHoverColor;

  /// Icon for previous button
  IconData get previousIcon => carouselStyle.previousIcon;

  /// Icon for next button
  IconData get nextIcon => carouselStyle.nextIcon;

  /// Animation duration for item transitions
  Duration get animationDuration => carouselStyle.animationDuration;

  /// Animation curve for item transitions
  Curve get animationCurve => carouselStyle.animationCurve;
}
