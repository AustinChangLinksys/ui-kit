// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'side_sheet_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$SideSheetStyleTailorMixin on ThemeExtension<SideSheetStyle> {
  double get width;
  Color get overlayColor;
  Duration get animationDuration;
  Curve get animationCurve;
  double get blurStrength;
  bool get enableDithering;

  @override
  SideSheetStyle copyWith({
    double? width,
    Color? overlayColor,
    Duration? animationDuration,
    Curve? animationCurve,
    double? blurStrength,
    bool? enableDithering,
  }) {
    return SideSheetStyle(
      width: width ?? this.width,
      overlayColor: overlayColor ?? this.overlayColor,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      blurStrength: blurStrength ?? this.blurStrength,
      enableDithering: enableDithering ?? this.enableDithering,
    );
  }

  @override
  SideSheetStyle lerp(
      covariant ThemeExtension<SideSheetStyle>? other, double t) {
    if (other is! SideSheetStyle) return this as SideSheetStyle;
    return SideSheetStyle(
      width: t < 0.5 ? width : other.width,
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t)!,
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
      blurStrength: t < 0.5 ? blurStrength : other.blurStrength,
      enableDithering: t < 0.5 ? enableDithering : other.enableDithering,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SideSheetStyle &&
            const DeepCollectionEquality().equals(width, other.width) &&
            const DeepCollectionEquality()
                .equals(overlayColor, other.overlayColor) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration) &&
            const DeepCollectionEquality()
                .equals(animationCurve, other.animationCurve) &&
            const DeepCollectionEquality()
                .equals(blurStrength, other.blurStrength) &&
            const DeepCollectionEquality()
                .equals(enableDithering, other.enableDithering));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(overlayColor),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
      const DeepCollectionEquality().hash(blurStrength),
      const DeepCollectionEquality().hash(enableDithering),
    );
  }
}

extension SideSheetStyleBuildContextProps on BuildContext {
  SideSheetStyle get sideSheetStyle =>
      Theme.of(this).extension<SideSheetStyle>()!;

  /// Width of the side sheet (drawer)
  double get width => sideSheetStyle.width;

  /// Scrim overlay color when sheet is open
  Color get overlayColor => sideSheetStyle.overlayColor;

  /// Animation duration for slide in/out
  Duration get animationDuration => sideSheetStyle.animationDuration;

  /// Animation curve for slide transitions
  Curve get animationCurve => sideSheetStyle.animationCurve;

  /// Blur strength for glass effect (0 for non-glass themes)
  double get blurStrength => sideSheetStyle.blurStrength;

  /// Enable dithering texture (Pixel theme)
  bool get enableDithering => sideSheetStyle.enableDithering;
}
