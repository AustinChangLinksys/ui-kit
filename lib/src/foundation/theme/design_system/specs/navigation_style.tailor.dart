// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'navigation_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$NavigationStyleTailorMixin on ThemeExtension<NavigationStyle> {
  double get height;
  bool get isFloating;
  double get floatingMargin;
  double get itemSpacing;
  AnimationSpec get animation;
  StateColorSpec get itemColors;
  Duration get animationDuration;
  Curve get animationCurve;
  Color get selectedColor;
  Color get unselectedColor;

  @override
  NavigationStyle copyWith({
    double? height,
    bool? isFloating,
    double? floatingMargin,
    double? itemSpacing,
    AnimationSpec? animation,
    StateColorSpec? itemColors,
    Duration? animationDuration,
    Curve? animationCurve,
    Color? selectedColor,
    Color? unselectedColor,
  }) {
    return NavigationStyle(
      height: height ?? this.height,
      isFloating: isFloating ?? this.isFloating,
      floatingMargin: floatingMargin ?? this.floatingMargin,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      animation: animation ?? this.animation,
      itemColors: itemColors ?? this.itemColors,
    );
  }

  @override
  NavigationStyle lerp(
      covariant ThemeExtension<NavigationStyle>? other, double t) {
    if (other is! NavigationStyle) return this as NavigationStyle;
    return NavigationStyle(
      height: t < 0.5 ? height : other.height,
      isFloating: t < 0.5 ? isFloating : other.isFloating,
      floatingMargin: t < 0.5 ? floatingMargin : other.floatingMargin,
      itemSpacing: t < 0.5 ? itemSpacing : other.itemSpacing,
      animation: animation.lerp(other.animation, t),
      itemColors: itemColors.lerp(other.itemColors, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NavigationStyle &&
            const DeepCollectionEquality().equals(height, other.height) &&
            const DeepCollectionEquality()
                .equals(isFloating, other.isFloating) &&
            const DeepCollectionEquality()
                .equals(floatingMargin, other.floatingMargin) &&
            const DeepCollectionEquality()
                .equals(itemSpacing, other.itemSpacing) &&
            const DeepCollectionEquality().equals(animation, other.animation) &&
            const DeepCollectionEquality()
                .equals(itemColors, other.itemColors) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration) &&
            const DeepCollectionEquality()
                .equals(animationCurve, other.animationCurve) &&
            const DeepCollectionEquality()
                .equals(selectedColor, other.selectedColor) &&
            const DeepCollectionEquality()
                .equals(unselectedColor, other.unselectedColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(isFloating),
      const DeepCollectionEquality().hash(floatingMargin),
      const DeepCollectionEquality().hash(itemSpacing),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(itemColors),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
      const DeepCollectionEquality().hash(selectedColor),
      const DeepCollectionEquality().hash(unselectedColor),
    );
  }
}

extension NavigationStyleBuildContextProps on BuildContext {
  NavigationStyle get navigationStyle =>
      Theme.of(this).extension<NavigationStyle>()!;

  /// Height of the navigation bar
  double get height => navigationStyle.height;

  /// Whether the navigation bar floats above content (Glass style)
  bool get isFloating => navigationStyle.isFloating;

  /// Margin around floating navigation bar
  double get floatingMargin => navigationStyle.floatingMargin;

  /// Spacing between navigation items
  double get itemSpacing => navigationStyle.itemSpacing;

  /// Animation timing for navigation transitions
  AnimationSpec get animation => navigationStyle.animation;

  /// Colors for navigation items (selected/unselected states)
  StateColorSpec get itemColors => navigationStyle.itemColors;
  Duration get animationDuration => navigationStyle.animationDuration;
  Curve get animationCurve => navigationStyle.animationCurve;
  Color get selectedColor => navigationStyle.selectedColor;
  Color get unselectedColor => navigationStyle.unselectedColor;
}
