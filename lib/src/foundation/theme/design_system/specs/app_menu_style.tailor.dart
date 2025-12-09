// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_menu_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppMenuStyleTailorMixin on ThemeExtension<AppMenuStyle> {
  SurfaceStyle get containerStyle;
  SurfaceStyle get itemStyle;
  SurfaceStyle get itemHoverStyle;
  SurfaceStyle get destructiveItemStyle;
  double get itemHeight;
  double get itemHorizontalPadding;
  double get iconSize;
  double get iconLabelSpacing;

  @override
  AppMenuStyle copyWith({
    SurfaceStyle? containerStyle,
    SurfaceStyle? itemStyle,
    SurfaceStyle? itemHoverStyle,
    SurfaceStyle? destructiveItemStyle,
    double? itemHeight,
    double? itemHorizontalPadding,
    double? iconSize,
    double? iconLabelSpacing,
  }) {
    return AppMenuStyle(
      containerStyle: containerStyle ?? this.containerStyle,
      itemStyle: itemStyle ?? this.itemStyle,
      itemHoverStyle: itemHoverStyle ?? this.itemHoverStyle,
      destructiveItemStyle: destructiveItemStyle ?? this.destructiveItemStyle,
      itemHeight: itemHeight ?? this.itemHeight,
      itemHorizontalPadding:
          itemHorizontalPadding ?? this.itemHorizontalPadding,
      iconSize: iconSize ?? this.iconSize,
      iconLabelSpacing: iconLabelSpacing ?? this.iconLabelSpacing,
    );
  }

  @override
  AppMenuStyle lerp(covariant ThemeExtension<AppMenuStyle>? other, double t) {
    if (other is! AppMenuStyle) return this as AppMenuStyle;
    return AppMenuStyle(
      containerStyle: t < 0.5 ? containerStyle : other.containerStyle,
      itemStyle: t < 0.5 ? itemStyle : other.itemStyle,
      itemHoverStyle: t < 0.5 ? itemHoverStyle : other.itemHoverStyle,
      destructiveItemStyle:
          t < 0.5 ? destructiveItemStyle : other.destructiveItemStyle,
      itemHeight: t < 0.5 ? itemHeight : other.itemHeight,
      itemHorizontalPadding:
          t < 0.5 ? itemHorizontalPadding : other.itemHorizontalPadding,
      iconSize: t < 0.5 ? iconSize : other.iconSize,
      iconLabelSpacing: t < 0.5 ? iconLabelSpacing : other.iconLabelSpacing,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppMenuStyle &&
            const DeepCollectionEquality()
                .equals(containerStyle, other.containerStyle) &&
            const DeepCollectionEquality().equals(itemStyle, other.itemStyle) &&
            const DeepCollectionEquality()
                .equals(itemHoverStyle, other.itemHoverStyle) &&
            const DeepCollectionEquality()
                .equals(destructiveItemStyle, other.destructiveItemStyle) &&
            const DeepCollectionEquality()
                .equals(itemHeight, other.itemHeight) &&
            const DeepCollectionEquality()
                .equals(itemHorizontalPadding, other.itemHorizontalPadding) &&
            const DeepCollectionEquality().equals(iconSize, other.iconSize) &&
            const DeepCollectionEquality()
                .equals(iconLabelSpacing, other.iconLabelSpacing));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(containerStyle),
      const DeepCollectionEquality().hash(itemStyle),
      const DeepCollectionEquality().hash(itemHoverStyle),
      const DeepCollectionEquality().hash(destructiveItemStyle),
      const DeepCollectionEquality().hash(itemHeight),
      const DeepCollectionEquality().hash(itemHorizontalPadding),
      const DeepCollectionEquality().hash(iconSize),
      const DeepCollectionEquality().hash(iconLabelSpacing),
    );
  }
}

extension AppMenuStyleBuildContextProps on BuildContext {
  AppMenuStyle get appMenuStyle => Theme.of(this).extension<AppMenuStyle>()!;

  /// Popup container background, border, shadow.
  SurfaceStyle get containerStyle => appMenuStyle.containerStyle;

  /// Default menu item appearance.
  SurfaceStyle get itemStyle => appMenuStyle.itemStyle;

  /// Hovered/focused item appearance.
  SurfaceStyle get itemHoverStyle => appMenuStyle.itemHoverStyle;

  /// Destructive action item (error color).
  SurfaceStyle get destructiveItemStyle => appMenuStyle.destructiveItemStyle;

  /// Minimum item height (48.0 for a11y).
  double get itemHeight => appMenuStyle.itemHeight;

  /// Horizontal padding inside items.
  double get itemHorizontalPadding => appMenuStyle.itemHorizontalPadding;

  /// Leading icon size.
  double get iconSize => appMenuStyle.iconSize;

  /// Gap between icon and label.
  double get iconLabelSpacing => appMenuStyle.iconLabelSpacing;
}
