// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'carousel_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$CarouselStyleTailorMixin on ThemeExtension<CarouselStyle> {
  StateColorSpec get navButtonColors;
  IconData get previousIcon;
  IconData get nextIcon;
  AnimationSpec get animation;
  bool get useSnapScroll;
  double get navButtonSize;
  Duration get animationDuration;
  Curve get animationCurve;
  Color get navButtonColor;
  Color get navButtonHoverColor;

  @override
  CarouselStyle copyWith({
    StateColorSpec? navButtonColors,
    IconData? previousIcon,
    IconData? nextIcon,
    AnimationSpec? animation,
    bool? useSnapScroll,
    double? navButtonSize,
    Duration? animationDuration,
    Curve? animationCurve,
    Color? navButtonColor,
    Color? navButtonHoverColor,
  }) {
    return CarouselStyle(
      navButtonColors: navButtonColors ?? this.navButtonColors,
      previousIcon: previousIcon ?? this.previousIcon,
      nextIcon: nextIcon ?? this.nextIcon,
      animation: animation ?? this.animation,
      useSnapScroll: useSnapScroll ?? this.useSnapScroll,
      navButtonSize: navButtonSize ?? this.navButtonSize,
    );
  }

  @override
  CarouselStyle lerp(covariant ThemeExtension<CarouselStyle>? other, double t) {
    if (other is! CarouselStyle) return this as CarouselStyle;
    return CarouselStyle(
      navButtonColors: navButtonColors.lerp(other.navButtonColors, t),
      previousIcon: t < 0.5 ? previousIcon : other.previousIcon,
      nextIcon: t < 0.5 ? nextIcon : other.nextIcon,
      animation: animation.lerp(other.animation, t),
      useSnapScroll: t < 0.5 ? useSnapScroll : other.useSnapScroll,
      navButtonSize: t < 0.5 ? navButtonSize : other.navButtonSize,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is CarouselStyle &&
            const DeepCollectionEquality()
                .equals(navButtonColors, other.navButtonColors) &&
            const DeepCollectionEquality()
                .equals(previousIcon, other.previousIcon) &&
            const DeepCollectionEquality().equals(nextIcon, other.nextIcon) &&
            const DeepCollectionEquality().equals(animation, other.animation) &&
            const DeepCollectionEquality()
                .equals(useSnapScroll, other.useSnapScroll) &&
            const DeepCollectionEquality()
                .equals(navButtonSize, other.navButtonSize) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration) &&
            const DeepCollectionEquality()
                .equals(animationCurve, other.animationCurve) &&
            const DeepCollectionEquality()
                .equals(navButtonColor, other.navButtonColor) &&
            const DeepCollectionEquality()
                .equals(navButtonHoverColor, other.navButtonHoverColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(navButtonColors),
      const DeepCollectionEquality().hash(previousIcon),
      const DeepCollectionEquality().hash(nextIcon),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(useSnapScroll),
      const DeepCollectionEquality().hash(navButtonSize),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
      const DeepCollectionEquality().hash(navButtonColor),
      const DeepCollectionEquality().hash(navButtonHoverColor),
    );
  }
}

extension CarouselStyleBuildContextProps on BuildContext {
  CarouselStyle get carouselStyle => Theme.of(this).extension<CarouselStyle>()!;

  /// Navigation button colors (inactive/hover states)
  StateColorSpec get navButtonColors => carouselStyle.navButtonColors;

  /// Icon for previous button
  IconData get previousIcon => carouselStyle.previousIcon;

  /// Icon for next button
  IconData get nextIcon => carouselStyle.nextIcon;

  /// Animation timing for item transitions
  AnimationSpec get animation => carouselStyle.animation;

  /// Use snap scroll instead of smooth scroll (Pixel theme)
  bool get useSnapScroll => carouselStyle.useSnapScroll;

  /// Size of navigation buttons (Pixel theme has larger buttons)
  double get navButtonSize => carouselStyle.navButtonSize;
  Duration get animationDuration => carouselStyle.animationDuration;
  Curve get animationCurve => carouselStyle.animationCurve;
  Color get navButtonColor => carouselStyle.navButtonColor;
  Color get navButtonHoverColor => carouselStyle.navButtonHoverColor;
}
