// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'menu_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppMenuThemeStyleTailorMixin on ThemeExtension<AppMenuThemeStyle> {
  Color get backgroundColor;
  Color get surfaceColor;
  Color get selectedColor;
  Color get hoverColor;
  Color get shadowColor;
  Color get borderColor;
  double get elevation;
  BorderRadius get borderRadius;
  Border? get border;
  EdgeInsets get padding;
  EdgeInsets get itemPadding;
  double get itemSpacing;
  double get itemHeight;
  double get iconSize;
  TextStyle get titleTextStyle;
  TextStyle get itemTextStyle;
  TextStyle get selectedItemTextStyle;
  double? get maxWidth;
  double? get minWidth;
  Color get dividerColor;
  double get dividerThickness;

  @override
  AppMenuThemeStyle copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    Color? selectedColor,
    Color? hoverColor,
    Color? shadowColor,
    Color? borderColor,
    double? elevation,
    BorderRadius? borderRadius,
    Border? border,
    EdgeInsets? padding,
    EdgeInsets? itemPadding,
    double? itemSpacing,
    double? itemHeight,
    double? iconSize,
    TextStyle? titleTextStyle,
    TextStyle? itemTextStyle,
    TextStyle? selectedItemTextStyle,
    double? maxWidth,
    double? minWidth,
    Color? dividerColor,
    double? dividerThickness,
  }) {
    return AppMenuThemeStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      selectedColor: selectedColor ?? this.selectedColor,
      hoverColor: hoverColor ?? this.hoverColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderColor: borderColor ?? this.borderColor,
      elevation: elevation ?? this.elevation,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      padding: padding ?? this.padding,
      itemPadding: itemPadding ?? this.itemPadding,
      itemSpacing: itemSpacing ?? this.itemSpacing,
      itemHeight: itemHeight ?? this.itemHeight,
      iconSize: iconSize ?? this.iconSize,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      itemTextStyle: itemTextStyle ?? this.itemTextStyle,
      selectedItemTextStyle:
          selectedItemTextStyle ?? this.selectedItemTextStyle,
      maxWidth: maxWidth ?? this.maxWidth,
      minWidth: minWidth ?? this.minWidth,
      dividerColor: dividerColor ?? this.dividerColor,
      dividerThickness: dividerThickness ?? this.dividerThickness,
    );
  }

  @override
  AppMenuThemeStyle lerp(
      covariant ThemeExtension<AppMenuThemeStyle>? other, double t) {
    if (other is! AppMenuThemeStyle) return this as AppMenuThemeStyle;
    return AppMenuThemeStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      selectedColor: Color.lerp(selectedColor, other.selectedColor, t)!,
      hoverColor: Color.lerp(hoverColor, other.hoverColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      elevation: t < 0.5 ? elevation : other.elevation,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      border: t < 0.5 ? border : other.border,
      padding: t < 0.5 ? padding : other.padding,
      itemPadding: t < 0.5 ? itemPadding : other.itemPadding,
      itemSpacing: t < 0.5 ? itemSpacing : other.itemSpacing,
      itemHeight: t < 0.5 ? itemHeight : other.itemHeight,
      iconSize: t < 0.5 ? iconSize : other.iconSize,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      itemTextStyle: TextStyle.lerp(itemTextStyle, other.itemTextStyle, t)!,
      selectedItemTextStyle: TextStyle.lerp(
          selectedItemTextStyle, other.selectedItemTextStyle, t)!,
      maxWidth: t < 0.5 ? maxWidth : other.maxWidth,
      minWidth: t < 0.5 ? minWidth : other.minWidth,
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t)!,
      dividerThickness: t < 0.5 ? dividerThickness : other.dividerThickness,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppMenuThemeStyle &&
            const DeepCollectionEquality()
                .equals(backgroundColor, other.backgroundColor) &&
            const DeepCollectionEquality()
                .equals(surfaceColor, other.surfaceColor) &&
            const DeepCollectionEquality()
                .equals(selectedColor, other.selectedColor) &&
            const DeepCollectionEquality()
                .equals(hoverColor, other.hoverColor) &&
            const DeepCollectionEquality()
                .equals(shadowColor, other.shadowColor) &&
            const DeepCollectionEquality()
                .equals(borderColor, other.borderColor) &&
            const DeepCollectionEquality().equals(elevation, other.elevation) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality().equals(border, other.border) &&
            const DeepCollectionEquality().equals(padding, other.padding) &&
            const DeepCollectionEquality()
                .equals(itemPadding, other.itemPadding) &&
            const DeepCollectionEquality()
                .equals(itemSpacing, other.itemSpacing) &&
            const DeepCollectionEquality()
                .equals(itemHeight, other.itemHeight) &&
            const DeepCollectionEquality().equals(iconSize, other.iconSize) &&
            const DeepCollectionEquality()
                .equals(titleTextStyle, other.titleTextStyle) &&
            const DeepCollectionEquality()
                .equals(itemTextStyle, other.itemTextStyle) &&
            const DeepCollectionEquality()
                .equals(selectedItemTextStyle, other.selectedItemTextStyle) &&
            const DeepCollectionEquality().equals(maxWidth, other.maxWidth) &&
            const DeepCollectionEquality().equals(minWidth, other.minWidth) &&
            const DeepCollectionEquality()
                .equals(dividerColor, other.dividerColor) &&
            const DeepCollectionEquality()
                .equals(dividerThickness, other.dividerThickness));
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(surfaceColor),
      const DeepCollectionEquality().hash(selectedColor),
      const DeepCollectionEquality().hash(hoverColor),
      const DeepCollectionEquality().hash(shadowColor),
      const DeepCollectionEquality().hash(borderColor),
      const DeepCollectionEquality().hash(elevation),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(border),
      const DeepCollectionEquality().hash(padding),
      const DeepCollectionEquality().hash(itemPadding),
      const DeepCollectionEquality().hash(itemSpacing),
      const DeepCollectionEquality().hash(itemHeight),
      const DeepCollectionEquality().hash(iconSize),
      const DeepCollectionEquality().hash(titleTextStyle),
      const DeepCollectionEquality().hash(itemTextStyle),
      const DeepCollectionEquality().hash(selectedItemTextStyle),
      const DeepCollectionEquality().hash(maxWidth),
      const DeepCollectionEquality().hash(minWidth),
      const DeepCollectionEquality().hash(dividerColor),
      const DeepCollectionEquality().hash(dividerThickness),
    ]);
  }
}

extension AppMenuThemeStyleBuildContextProps on BuildContext {
  AppMenuThemeStyle get appMenuThemeStyle =>
      Theme.of(this).extension<AppMenuThemeStyle>()!;

  /// Background color of the menu
  Color get backgroundColor => appMenuThemeStyle.backgroundColor;

  /// Surface color for menu items
  Color get surfaceColor => appMenuThemeStyle.surfaceColor;

  /// Color for selected menu items
  Color get selectedColor => appMenuThemeStyle.selectedColor;

  /// Color for hovered menu items
  Color get hoverColor => appMenuThemeStyle.hoverColor;

  /// Color for drop shadows
  Color get shadowColor => appMenuThemeStyle.shadowColor;

  /// Color for borders
  Color get borderColor => appMenuThemeStyle.borderColor;

  /// Elevation (shadow depth) of the menu
  double get elevation => appMenuThemeStyle.elevation;

  /// Border radius for menu corners
  BorderRadius get borderRadius => appMenuThemeStyle.borderRadius;

  /// Border configuration
  Border? get border => appMenuThemeStyle.border;

  /// Padding around menu content
  EdgeInsets get padding => appMenuThemeStyle.padding;

  /// Padding for individual menu items
  EdgeInsets get itemPadding => appMenuThemeStyle.itemPadding;

  /// Spacing between menu items
  double get itemSpacing => appMenuThemeStyle.itemSpacing;

  /// Height of menu items
  double get itemHeight => appMenuThemeStyle.itemHeight;

  /// Size of menu item icons
  double get iconSize => appMenuThemeStyle.iconSize;

  /// Text style for menu title
  TextStyle get titleTextStyle => appMenuThemeStyle.titleTextStyle;

  /// Text style for menu items
  TextStyle get itemTextStyle => appMenuThemeStyle.itemTextStyle;

  /// Text style for selected menu items
  TextStyle get selectedItemTextStyle =>
      appMenuThemeStyle.selectedItemTextStyle;

  /// Maximum width of the menu
  double? get maxWidth => appMenuThemeStyle.maxWidth;

  /// Minimum width of the menu
  double? get minWidth => appMenuThemeStyle.minWidth;

  /// Color for menu dividers
  Color get dividerColor => appMenuThemeStyle.dividerColor;

  /// Thickness of menu dividers
  double get dividerThickness => appMenuThemeStyle.dividerThickness;
}
