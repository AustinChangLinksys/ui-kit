// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_bar_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$AppBarStyleTailorMixin on ThemeExtension<AppBarStyle> {
  SurfaceStyle get containerStyle;
  SurfaceStyle? get bottomContainerStyle;
  DividerStyle get dividerStyle;
  double get height;
  double get collapsedHeight;
  double get expandedHeight;
  double get flexibleSpaceBlur;

  @override
  AppBarStyle copyWith({
    SurfaceStyle? containerStyle,
    SurfaceStyle? bottomContainerStyle,
    DividerStyle? dividerStyle,
    double? height,
    double? collapsedHeight,
    double? expandedHeight,
    double? flexibleSpaceBlur,
  }) {
    return AppBarStyle(
      containerStyle: containerStyle ?? this.containerStyle,
      bottomContainerStyle: bottomContainerStyle ?? this.bottomContainerStyle,
      dividerStyle: dividerStyle ?? this.dividerStyle,
      height: height ?? this.height,
      collapsedHeight: collapsedHeight ?? this.collapsedHeight,
      expandedHeight: expandedHeight ?? this.expandedHeight,
      flexibleSpaceBlur: flexibleSpaceBlur ?? this.flexibleSpaceBlur,
    );
  }

  @override
  AppBarStyle lerp(covariant ThemeExtension<AppBarStyle>? other, double t) {
    if (other is! AppBarStyle) return this as AppBarStyle;
    return AppBarStyle(
      containerStyle: t < 0.5 ? containerStyle : other.containerStyle,
      bottomContainerStyle:
          t < 0.5 ? bottomContainerStyle : other.bottomContainerStyle,
      dividerStyle: dividerStyle.lerp(other.dividerStyle, t),
      height: t < 0.5 ? height : other.height,
      collapsedHeight: t < 0.5 ? collapsedHeight : other.collapsedHeight,
      expandedHeight: t < 0.5 ? expandedHeight : other.expandedHeight,
      flexibleSpaceBlur: t < 0.5 ? flexibleSpaceBlur : other.flexibleSpaceBlur,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppBarStyle &&
            const DeepCollectionEquality()
                .equals(containerStyle, other.containerStyle) &&
            const DeepCollectionEquality()
                .equals(bottomContainerStyle, other.bottomContainerStyle) &&
            const DeepCollectionEquality()
                .equals(dividerStyle, other.dividerStyle) &&
            const DeepCollectionEquality().equals(height, other.height) &&
            const DeepCollectionEquality()
                .equals(collapsedHeight, other.collapsedHeight) &&
            const DeepCollectionEquality()
                .equals(expandedHeight, other.expandedHeight) &&
            const DeepCollectionEquality()
                .equals(flexibleSpaceBlur, other.flexibleSpaceBlur));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(containerStyle),
      const DeepCollectionEquality().hash(bottomContainerStyle),
      const DeepCollectionEquality().hash(dividerStyle),
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(collapsedHeight),
      const DeepCollectionEquality().hash(expandedHeight),
      const DeepCollectionEquality().hash(flexibleSpaceBlur),
    );
  }
}

extension AppBarStyleBuildContextProps on BuildContext {
  AppBarStyle get appBarStyle => Theme.of(this).extension<AppBarStyle>()!;

  /// Background, border, shadow for main AppBar container.
  SurfaceStyle get containerStyle => appBarStyle.containerStyle;

  /// Style for bottom area (TabBar container).
  SurfaceStyle? get bottomContainerStyle => appBarStyle.bottomContainerStyle;

  /// Bottom divider (hairline for Flat, thick for Pixel).
  DividerStyle get dividerStyle => appBarStyle.dividerStyle;

  /// Standard AppBar height.
  double get height => appBarStyle.height;

  /// Minimum height when SliverAppBar collapsed.
  double get collapsedHeight => appBarStyle.collapsedHeight;

  /// Maximum height when SliverAppBar expanded.
  double get expandedHeight => appBarStyle.expandedHeight;

  /// Blur sigma for Glass mode flexibleSpace overlay (0 for non-Glass).
  double get flexibleSpaceBlur => appBarStyle.flexibleSpaceBlur;
}
