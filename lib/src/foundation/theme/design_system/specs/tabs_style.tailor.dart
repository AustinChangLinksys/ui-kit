// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tabs_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$TabsStyleTailorMixin on ThemeExtension<TabsStyle> {
  Color get activeTextColor;
  Color get inactiveTextColor;
  Color get indicatorColor;
  Color get tabBackgroundColor;
  Duration get animationDuration;
  double get indicatorThickness;

  @override
  TabsStyle copyWith({
    Color? activeTextColor,
    Color? inactiveTextColor,
    Color? indicatorColor,
    Color? tabBackgroundColor,
    Duration? animationDuration,
    double? indicatorThickness,
  }) {
    return TabsStyle(
      activeTextColor: activeTextColor ?? this.activeTextColor,
      inactiveTextColor: inactiveTextColor ?? this.inactiveTextColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      tabBackgroundColor: tabBackgroundColor ?? this.tabBackgroundColor,
      animationDuration: animationDuration ?? this.animationDuration,
      indicatorThickness: indicatorThickness ?? this.indicatorThickness,
    );
  }

  @override
  TabsStyle lerp(covariant ThemeExtension<TabsStyle>? other, double t) {
    if (other is! TabsStyle) return this as TabsStyle;
    return TabsStyle(
      activeTextColor: Color.lerp(activeTextColor, other.activeTextColor, t)!,
      inactiveTextColor:
          Color.lerp(inactiveTextColor, other.inactiveTextColor, t)!,
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t)!,
      tabBackgroundColor:
          Color.lerp(tabBackgroundColor, other.tabBackgroundColor, t)!,
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      indicatorThickness:
          t < 0.5 ? indicatorThickness : other.indicatorThickness,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TabsStyle &&
            const DeepCollectionEquality()
                .equals(activeTextColor, other.activeTextColor) &&
            const DeepCollectionEquality()
                .equals(inactiveTextColor, other.inactiveTextColor) &&
            const DeepCollectionEquality()
                .equals(indicatorColor, other.indicatorColor) &&
            const DeepCollectionEquality()
                .equals(tabBackgroundColor, other.tabBackgroundColor) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration) &&
            const DeepCollectionEquality()
                .equals(indicatorThickness, other.indicatorThickness));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(activeTextColor),
      const DeepCollectionEquality().hash(inactiveTextColor),
      const DeepCollectionEquality().hash(indicatorColor),
      const DeepCollectionEquality().hash(tabBackgroundColor),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(indicatorThickness),
    );
  }
}

extension TabsStyleBuildContextProps on BuildContext {
  TabsStyle get tabsStyle => Theme.of(this).extension<TabsStyle>()!;

  /// Text color for active tab
  Color get activeTextColor => tabsStyle.activeTextColor;

  /// Text color for inactive tabs
  Color get inactiveTextColor => tabsStyle.inactiveTextColor;

  /// Color of the active indicator (underline or background)
  Color get indicatorColor => tabsStyle.indicatorColor;

  /// Background color of tab buttons
  Color get tabBackgroundColor => tabsStyle.tabBackgroundColor;

  /// Animation duration for indicator transitions
  Duration get animationDuration => tabsStyle.animationDuration;

  /// Thickness of the indicator line
  double get indicatorThickness => tabsStyle.indicatorThickness;
}
