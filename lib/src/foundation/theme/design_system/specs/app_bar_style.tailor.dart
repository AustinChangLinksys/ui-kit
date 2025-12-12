// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bar_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppBarStyleTailorMixin on ThemeExtension<AppBarStyle> {
  Color get backgroundColor;
  Color get foregroundColor;
  Color get surfaceColor;
  Color get shadowColor;
  double get elevation;
  double get height;
  TextStyle get titleTextStyle;
  double get actionIconSize;
  double get leadingIconSize;
  EdgeInsets get contentPadding;
  double get actionSpacing;
  BorderRadius get borderRadius;
  Border? get border;
  bool get centerTitle;
  double get titleSpacing;
  double get collapsedHeight;
  double get expandedHeight;
  double get flexibleSpaceBlur;
  BoxDecoration get containerStyle;
  BoxDecoration? get dividerStyle;

  @override
  AppBarStyle copyWith({
    Color? backgroundColor,
    Color? foregroundColor,
    Color? surfaceColor,
    Color? shadowColor,
    double? elevation,
    double? height,
    TextStyle? titleTextStyle,
    double? actionIconSize,
    double? leadingIconSize,
    EdgeInsets? contentPadding,
    double? actionSpacing,
    BorderRadius? borderRadius,
    Border? border,
    bool? centerTitle,
    double? titleSpacing,
    double? collapsedHeight,
    double? expandedHeight,
    double? flexibleSpaceBlur,
    BoxDecoration? containerStyle,
    BoxDecoration? dividerStyle,
  }) {
    return AppBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      foregroundColor: foregroundColor ?? this.foregroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      shadowColor: shadowColor ?? this.shadowColor,
      elevation: elevation ?? this.elevation,
      height: height ?? this.height,
      titleTextStyle: titleTextStyle ?? this.titleTextStyle,
      actionIconSize: actionIconSize ?? this.actionIconSize,
      leadingIconSize: leadingIconSize ?? this.leadingIconSize,
      contentPadding: contentPadding ?? this.contentPadding,
      actionSpacing: actionSpacing ?? this.actionSpacing,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      centerTitle: centerTitle ?? this.centerTitle,
      titleSpacing: titleSpacing ?? this.titleSpacing,
      collapsedHeight: collapsedHeight ?? this.collapsedHeight,
      expandedHeight: expandedHeight ?? this.expandedHeight,
      flexibleSpaceBlur: flexibleSpaceBlur ?? this.flexibleSpaceBlur,
      containerStyle: containerStyle ?? this.containerStyle,
      dividerStyle: dividerStyle ?? this.dividerStyle,
    );
  }

  @override
  AppBarStyle lerp(covariant ThemeExtension<AppBarStyle>? other, double t) {
    if (other is! AppBarStyle) return this as AppBarStyle;
    return AppBarStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      foregroundColor: Color.lerp(foregroundColor, other.foregroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      elevation: t < 0.5 ? elevation : other.elevation,
      height: t < 0.5 ? height : other.height,
      titleTextStyle: TextStyle.lerp(titleTextStyle, other.titleTextStyle, t)!,
      actionIconSize: t < 0.5 ? actionIconSize : other.actionIconSize,
      leadingIconSize: t < 0.5 ? leadingIconSize : other.leadingIconSize,
      contentPadding: t < 0.5 ? contentPadding : other.contentPadding,
      actionSpacing: t < 0.5 ? actionSpacing : other.actionSpacing,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      border: t < 0.5 ? border : other.border,
      centerTitle: t < 0.5 ? centerTitle : other.centerTitle,
      titleSpacing: t < 0.5 ? titleSpacing : other.titleSpacing,
      collapsedHeight: t < 0.5 ? collapsedHeight : other.collapsedHeight,
      expandedHeight: t < 0.5 ? expandedHeight : other.expandedHeight,
      flexibleSpaceBlur: t < 0.5 ? flexibleSpaceBlur : other.flexibleSpaceBlur,
      containerStyle: t < 0.5 ? containerStyle : other.containerStyle,
      dividerStyle: t < 0.5 ? dividerStyle : other.dividerStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppBarStyle &&
            const DeepCollectionEquality()
                .equals(backgroundColor, other.backgroundColor) &&
            const DeepCollectionEquality()
                .equals(foregroundColor, other.foregroundColor) &&
            const DeepCollectionEquality()
                .equals(surfaceColor, other.surfaceColor) &&
            const DeepCollectionEquality()
                .equals(shadowColor, other.shadowColor) &&
            const DeepCollectionEquality().equals(elevation, other.elevation) &&
            const DeepCollectionEquality().equals(height, other.height) &&
            const DeepCollectionEquality()
                .equals(titleTextStyle, other.titleTextStyle) &&
            const DeepCollectionEquality()
                .equals(actionIconSize, other.actionIconSize) &&
            const DeepCollectionEquality()
                .equals(leadingIconSize, other.leadingIconSize) &&
            const DeepCollectionEquality()
                .equals(contentPadding, other.contentPadding) &&
            const DeepCollectionEquality()
                .equals(actionSpacing, other.actionSpacing) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality().equals(border, other.border) &&
            const DeepCollectionEquality()
                .equals(centerTitle, other.centerTitle) &&
            const DeepCollectionEquality()
                .equals(titleSpacing, other.titleSpacing) &&
            const DeepCollectionEquality()
                .equals(collapsedHeight, other.collapsedHeight) &&
            const DeepCollectionEquality()
                .equals(expandedHeight, other.expandedHeight) &&
            const DeepCollectionEquality()
                .equals(flexibleSpaceBlur, other.flexibleSpaceBlur) &&
            const DeepCollectionEquality()
                .equals(containerStyle, other.containerStyle) &&
            const DeepCollectionEquality()
                .equals(dividerStyle, other.dividerStyle));
  }

  @override
  int get hashCode {
    return Object.hashAll([
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(foregroundColor),
      const DeepCollectionEquality().hash(surfaceColor),
      const DeepCollectionEquality().hash(shadowColor),
      const DeepCollectionEquality().hash(elevation),
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(titleTextStyle),
      const DeepCollectionEquality().hash(actionIconSize),
      const DeepCollectionEquality().hash(leadingIconSize),
      const DeepCollectionEquality().hash(contentPadding),
      const DeepCollectionEquality().hash(actionSpacing),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(border),
      const DeepCollectionEquality().hash(centerTitle),
      const DeepCollectionEquality().hash(titleSpacing),
      const DeepCollectionEquality().hash(collapsedHeight),
      const DeepCollectionEquality().hash(expandedHeight),
      const DeepCollectionEquality().hash(flexibleSpaceBlur),
      const DeepCollectionEquality().hash(containerStyle),
      const DeepCollectionEquality().hash(dividerStyle),
    ]);
  }
}

extension AppBarStyleBuildContextProps on BuildContext {
  AppBarStyle get appBarStyle => Theme.of(this).extension<AppBarStyle>()!;

  /// Background color of the app bar
  Color get backgroundColor => appBarStyle.backgroundColor;

  /// Foreground color for text and icons
  Color get foregroundColor => appBarStyle.foregroundColor;

  /// Surface color for elevated elements
  Color get surfaceColor => appBarStyle.surfaceColor;

  /// Color for drop shadows
  Color get shadowColor => appBarStyle.shadowColor;

  /// Elevation (shadow depth) of the app bar
  double get elevation => appBarStyle.elevation;

  /// Height of the app bar
  double get height => appBarStyle.height;

  /// Text style for the title
  TextStyle get titleTextStyle => appBarStyle.titleTextStyle;

  /// Size of action icons
  double get actionIconSize => appBarStyle.actionIconSize;

  /// Size of leading icon (back button, menu, etc.)
  double get leadingIconSize => appBarStyle.leadingIconSize;

  /// Padding around app bar content
  EdgeInsets get contentPadding => appBarStyle.contentPadding;

  /// Spacing between action items
  double get actionSpacing => appBarStyle.actionSpacing;

  /// Border radius for app bar corners
  BorderRadius get borderRadius => appBarStyle.borderRadius;

  /// Border configuration
  Border? get border => appBarStyle.border;

  /// Whether to center the title
  bool get centerTitle => appBarStyle.centerTitle;

  /// Spacing around the title
  double get titleSpacing => appBarStyle.titleSpacing;

  /// Height of the app bar when collapsed (for sliver app bars)
  double get collapsedHeight => appBarStyle.collapsedHeight;

  /// Height of the app bar when expanded (for sliver app bars)
  double get expandedHeight => appBarStyle.expandedHeight;

  /// Blur radius for flexible space background
  double get flexibleSpaceBlur => appBarStyle.flexibleSpaceBlur;

  /// Style configuration for the app bar container
  BoxDecoration get containerStyle => appBarStyle.containerStyle;

  /// Style configuration for divider elements
  BoxDecoration? get dividerStyle => appBarStyle.dividerStyle;
}
