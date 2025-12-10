// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_bar_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BottomBarStyleTailorMixin on ThemeExtension<BottomBarStyle> {
  Color get backgroundColor;
  Color get surfaceColor;
  Color get shadowColor;
  Color get borderColor;
  double get elevation;
  double get height;
  EdgeInsets get padding;
  double get buttonSpacing;
  BorderRadius get borderRadius;
  Border? get border;
  double get buttonHeight;
  double get buttonMinWidth;
  ButtonStyle get primaryButtonStyle;
  ButtonStyle get secondaryButtonStyle;
  ButtonStyle get destructiveButtonStyle;
  ButtonStyle get disabledButtonStyle;

  @override
  BottomBarStyle copyWith({
    Color? backgroundColor,
    Color? surfaceColor,
    Color? shadowColor,
    Color? borderColor,
    double? elevation,
    double? height,
    EdgeInsets? padding,
    double? buttonSpacing,
    BorderRadius? borderRadius,
    Border? border,
    double? buttonHeight,
    double? buttonMinWidth,
    ButtonStyle? primaryButtonStyle,
    ButtonStyle? secondaryButtonStyle,
    ButtonStyle? destructiveButtonStyle,
    ButtonStyle? disabledButtonStyle,
  }) {
    return BottomBarStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      surfaceColor: surfaceColor ?? this.surfaceColor,
      shadowColor: shadowColor ?? this.shadowColor,
      borderColor: borderColor ?? this.borderColor,
      elevation: elevation ?? this.elevation,
      height: height ?? this.height,
      padding: padding ?? this.padding,
      buttonSpacing: buttonSpacing ?? this.buttonSpacing,
      borderRadius: borderRadius ?? this.borderRadius,
      border: border ?? this.border,
      buttonHeight: buttonHeight ?? this.buttonHeight,
      buttonMinWidth: buttonMinWidth ?? this.buttonMinWidth,
      primaryButtonStyle: primaryButtonStyle ?? this.primaryButtonStyle,
      secondaryButtonStyle: secondaryButtonStyle ?? this.secondaryButtonStyle,
      destructiveButtonStyle:
          destructiveButtonStyle ?? this.destructiveButtonStyle,
      disabledButtonStyle: disabledButtonStyle ?? this.disabledButtonStyle,
    );
  }

  @override
  BottomBarStyle lerp(
      covariant ThemeExtension<BottomBarStyle>? other, double t) {
    if (other is! BottomBarStyle) return this as BottomBarStyle;
    return BottomBarStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      surfaceColor: Color.lerp(surfaceColor, other.surfaceColor, t)!,
      shadowColor: Color.lerp(shadowColor, other.shadowColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      elevation: t < 0.5 ? elevation : other.elevation,
      height: t < 0.5 ? height : other.height,
      padding: t < 0.5 ? padding : other.padding,
      buttonSpacing: t < 0.5 ? buttonSpacing : other.buttonSpacing,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      border: t < 0.5 ? border : other.border,
      buttonHeight: t < 0.5 ? buttonHeight : other.buttonHeight,
      buttonMinWidth: t < 0.5 ? buttonMinWidth : other.buttonMinWidth,
      primaryButtonStyle:
          t < 0.5 ? primaryButtonStyle : other.primaryButtonStyle,
      secondaryButtonStyle:
          t < 0.5 ? secondaryButtonStyle : other.secondaryButtonStyle,
      destructiveButtonStyle:
          t < 0.5 ? destructiveButtonStyle : other.destructiveButtonStyle,
      disabledButtonStyle:
          t < 0.5 ? disabledButtonStyle : other.disabledButtonStyle,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BottomBarStyle &&
            const DeepCollectionEquality()
                .equals(backgroundColor, other.backgroundColor) &&
            const DeepCollectionEquality()
                .equals(surfaceColor, other.surfaceColor) &&
            const DeepCollectionEquality()
                .equals(shadowColor, other.shadowColor) &&
            const DeepCollectionEquality()
                .equals(borderColor, other.borderColor) &&
            const DeepCollectionEquality().equals(elevation, other.elevation) &&
            const DeepCollectionEquality().equals(height, other.height) &&
            const DeepCollectionEquality().equals(padding, other.padding) &&
            const DeepCollectionEquality()
                .equals(buttonSpacing, other.buttonSpacing) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality().equals(border, other.border) &&
            const DeepCollectionEquality()
                .equals(buttonHeight, other.buttonHeight) &&
            const DeepCollectionEquality()
                .equals(buttonMinWidth, other.buttonMinWidth) &&
            const DeepCollectionEquality()
                .equals(primaryButtonStyle, other.primaryButtonStyle) &&
            const DeepCollectionEquality()
                .equals(secondaryButtonStyle, other.secondaryButtonStyle) &&
            const DeepCollectionEquality()
                .equals(destructiveButtonStyle, other.destructiveButtonStyle) &&
            const DeepCollectionEquality()
                .equals(disabledButtonStyle, other.disabledButtonStyle));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(surfaceColor),
      const DeepCollectionEquality().hash(shadowColor),
      const DeepCollectionEquality().hash(borderColor),
      const DeepCollectionEquality().hash(elevation),
      const DeepCollectionEquality().hash(height),
      const DeepCollectionEquality().hash(padding),
      const DeepCollectionEquality().hash(buttonSpacing),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(border),
      const DeepCollectionEquality().hash(buttonHeight),
      const DeepCollectionEquality().hash(buttonMinWidth),
      const DeepCollectionEquality().hash(primaryButtonStyle),
      const DeepCollectionEquality().hash(secondaryButtonStyle),
      const DeepCollectionEquality().hash(destructiveButtonStyle),
      const DeepCollectionEquality().hash(disabledButtonStyle),
    );
  }
}

extension BottomBarStyleBuildContextProps on BuildContext {
  BottomBarStyle get bottomBarStyle =>
      Theme.of(this).extension<BottomBarStyle>()!;

  /// Background color of the bottom bar
  Color get backgroundColor => bottomBarStyle.backgroundColor;

  /// Surface color for elevated elements
  Color get surfaceColor => bottomBarStyle.surfaceColor;

  /// Color for drop shadows
  Color get shadowColor => bottomBarStyle.shadowColor;

  /// Color for borders
  Color get borderColor => bottomBarStyle.borderColor;

  /// Elevation (shadow depth) of the bottom bar
  double get elevation => bottomBarStyle.elevation;

  /// Height of the bottom bar
  double get height => bottomBarStyle.height;

  /// Padding around bottom bar content
  EdgeInsets get padding => bottomBarStyle.padding;

  /// Spacing between buttons
  double get buttonSpacing => bottomBarStyle.buttonSpacing;

  /// Border radius for bottom bar corners
  BorderRadius get borderRadius => bottomBarStyle.borderRadius;

  /// Border configuration
  Border? get border => bottomBarStyle.border;

  /// Height of buttons in the bottom bar
  double get buttonHeight => bottomBarStyle.buttonHeight;

  /// Minimum width for buttons
  double get buttonMinWidth => bottomBarStyle.buttonMinWidth;

  /// Style for primary action buttons
  ButtonStyle get primaryButtonStyle => bottomBarStyle.primaryButtonStyle;

  /// Style for secondary action buttons
  ButtonStyle get secondaryButtonStyle => bottomBarStyle.secondaryButtonStyle;

  /// Style for destructive action buttons
  ButtonStyle get destructiveButtonStyle =>
      bottomBarStyle.destructiveButtonStyle;

  /// Style for disabled buttons
  ButtonStyle get disabledButtonStyle => bottomBarStyle.disabledButtonStyle;
}
