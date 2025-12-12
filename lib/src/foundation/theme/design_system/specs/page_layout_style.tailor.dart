// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'page_layout_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$PageLayoutStyleTailorMixin on ThemeExtension<PageLayoutStyle> {
  Color get backgroundColor;
  Color get surfaceColor;
  EdgeInsets get padding;
  EdgeInsets get contentPadding;
  EdgeInsets get safeAreaPadding;
  BorderRadius get borderRadius;
  double get elevation;
  Color get shadowColor;
  double? get maxContentWidth;
  double? get minContentHeight;
  double get desktopBreakpoint;
  double get tabletBreakpoint;

  @override
  PageLayoutStyle copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    EdgeInsets? padding,
    EdgeInsets? contentPadding,
    EdgeInsets? safeAreaPadding,
    BorderRadius? borderRadius,
    double? elevation,
    Color? shadowColor,
    double? maxContentWidth,
    double? minContentHeight,
    double? desktopBreakpoint,
    double? tabletBreakpoint,
  }) {
    return PageLayoutStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      padding: padding ?? this.padding,
      contentPadding: contentPadding ?? this.contentPadding,
      safeAreaPadding: safeAreaPadding ?? this.safeAreaPadding,
      borderRadius: borderRadius ?? this.borderRadius,
      elevation: elevation ?? this.elevation,
      shadowColor: shadowColor ?? this.shadowColor,
      maxContentWidth: maxContentWidth ?? this.maxContentWidth,
      minContentHeight: minContentHeight ?? this.minContentHeight,
      desktopBreakpoint: desktopBreakpoint ?? this.desktopBreakpoint,
      tabletBreakpoint: tabletBreakpoint ?? this.tabletBreakpoint,
    );
  }

  @override
  PageLayoutStyle lerp(
      covariant ThemeExtension<PageLayoutStyle>? other, double t) {
    if (other is! PageLayoutStyle) return this as PageLayoutStyle;
    return PageLayoutStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      padding: t < 0.5 ? padding : other.padding,
      contentPadding: t < 0.5 ? contentPadding : other.contentPadding,
      safeAreaPadding: t < 0.5 ? safeAreaPadding : other.safeAreaPadding,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      elevation: t < 0.5 ? elevation : other.elevation,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      maxContentWidth: t < 0.5 ? maxContentWidth : other.maxContentWidth,
      minContentHeight: t < 0.5 ? minContentHeight : other.minContentHeight,
      desktopBreakpoint: t < 0.5 ? desktopBreakpoint : other.desktopBreakpoint,
      tabletBreakpoint: t < 0.5 ? tabletBreakpoint : other.tabletBreakpoint,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PageLayoutStyle &&
            const DeepCollectionEquality()
                .equals(backgroundColor, other.backgroundColor) &&
            const DeepCollectionEquality()
                .equals(surfaceColor, other.surfaceColor) &&
            const DeepCollectionEquality().equals(padding, other.padding) &&
            const DeepCollectionEquality()
                .equals(contentPadding, other.contentPadding) &&
            const DeepCollectionEquality()
                .equals(safeAreaPadding, other.safeAreaPadding) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality().equals(elevation, other.elevation) &&
            const DeepCollectionEquality()
                .equals(shadowColor, other.shadowColor) &&
            const DeepCollectionEquality()
                .equals(maxContentWidth, other.maxContentWidth) &&
            const DeepCollectionEquality()
                .equals(minContentHeight, other.minContentHeight) &&
            const DeepCollectionEquality()
                .equals(desktopBreakpoint, other.desktopBreakpoint) &&
            const DeepCollectionEquality()
                .equals(tabletBreakpoint, other.tabletBreakpoint));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(surfaceColor),
      const DeepCollectionEquality().hash(padding),
      const DeepCollectionEquality().hash(contentPadding),
      const DeepCollectionEquality().hash(safeAreaPadding),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(elevation),
      const DeepCollectionEquality().hash(shadowColor),
      const DeepCollectionEquality().hash(maxContentWidth),
      const DeepCollectionEquality().hash(minContentHeight),
      const DeepCollectionEquality().hash(desktopBreakpoint),
      const DeepCollectionEquality().hash(tabletBreakpoint),
    );
  }
}

extension PageLayoutStyleBuildContextProps on BuildContext {
  PageLayoutStyle get pageLayoutStyle =>
      Theme.of(this).extension<PageLayoutStyle>()!;

  /// Background color for the page
  Color get backgroundColor => pageLayoutStyle.backgroundColor;

  /// Surface color for content areas
  Color get surfaceColor => pageLayoutStyle.surfaceColor;

  /// Default padding around the page content
  EdgeInsets get padding => pageLayoutStyle.padding;

  /// Padding for the main content area
  EdgeInsets get contentPadding => pageLayoutStyle.contentPadding;

  /// Additional padding for safe area handling
  EdgeInsets get safeAreaPadding => pageLayoutStyle.safeAreaPadding;

  /// Border radius for page surfaces
  BorderRadius get borderRadius => pageLayoutStyle.borderRadius;

  /// Elevation for page surfaces (shadow depth)
  double get elevation => pageLayoutStyle.elevation;

  /// Color for drop shadows
  Color get shadowColor => pageLayoutStyle.shadowColor;

  /// Maximum width for content area (responsive layout)
  double? get maxContentWidth => pageLayoutStyle.maxContentWidth;

  /// Minimum height for content area
  double? get minContentHeight => pageLayoutStyle.minContentHeight;

  /// Breakpoint for desktop layout (pixels)
  double get desktopBreakpoint => pageLayoutStyle.desktopBreakpoint;

  /// Breakpoint for tablet layout (pixels)
  double get tabletBreakpoint => pageLayoutStyle.tabletBreakpoint;
}
