// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'expandable_fab_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ExpandableFabStyleTailorMixin on ThemeExtension<ExpandableFabStyle> {
  BoxShape get shape;
  double get distance;
  FabAnimationType get type;
  OverlaySpec get overlay;
  bool get showDitherPattern;
  bool get glowEffect;
  bool get highContrastBorder;
  Color get overlayColor;
  bool get enableBlur;

  @override
  ExpandableFabStyle copyWith({
    BoxShape? shape,
    double? distance,
    FabAnimationType? type,
    OverlaySpec? overlay,
    bool? showDitherPattern,
    bool? glowEffect,
    bool? highContrastBorder,
    Color? overlayColor,
    bool? enableBlur,
  }) {
    return ExpandableFabStyle(
      shape: shape ?? this.shape,
      distance: distance ?? this.distance,
      type: type ?? this.type,
      overlay: overlay ?? this.overlay,
      showDitherPattern: showDitherPattern ?? this.showDitherPattern,
      glowEffect: glowEffect ?? this.glowEffect,
      highContrastBorder: highContrastBorder ?? this.highContrastBorder,
    );
  }

  @override
  ExpandableFabStyle lerp(
      covariant ThemeExtension<ExpandableFabStyle>? other, double t) {
    if (other is! ExpandableFabStyle) return this as ExpandableFabStyle;
    return ExpandableFabStyle(
      shape: t < 0.5 ? shape : other.shape,
      distance: t < 0.5 ? distance : other.distance,
      type: t < 0.5 ? type : other.type,
      overlay: overlay.lerp(other.overlay, t),
      showDitherPattern: t < 0.5 ? showDitherPattern : other.showDitherPattern,
      glowEffect: t < 0.5 ? glowEffect : other.glowEffect,
      highContrastBorder:
          t < 0.5 ? highContrastBorder : other.highContrastBorder,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ExpandableFabStyle &&
            const DeepCollectionEquality().equals(shape, other.shape) &&
            const DeepCollectionEquality().equals(distance, other.distance) &&
            const DeepCollectionEquality().equals(type, other.type) &&
            const DeepCollectionEquality().equals(overlay, other.overlay) &&
            const DeepCollectionEquality()
                .equals(showDitherPattern, other.showDitherPattern) &&
            const DeepCollectionEquality()
                .equals(glowEffect, other.glowEffect) &&
            const DeepCollectionEquality()
                .equals(highContrastBorder, other.highContrastBorder) &&
            const DeepCollectionEquality()
                .equals(overlayColor, other.overlayColor) &&
            const DeepCollectionEquality()
                .equals(enableBlur, other.enableBlur));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(shape),
      const DeepCollectionEquality().hash(distance),
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(overlay),
      const DeepCollectionEquality().hash(showDitherPattern),
      const DeepCollectionEquality().hash(glowEffect),
      const DeepCollectionEquality().hash(highContrastBorder),
      const DeepCollectionEquality().hash(overlayColor),
      const DeepCollectionEquality().hash(enableBlur),
    );
  }
}

extension ExpandableFabStyleBuildContextProps on BuildContext {
  ExpandableFabStyle get expandableFabStyle =>
      Theme.of(this).extension<ExpandableFabStyle>()!;

  /// Shape & Geometry - Circle vs Square
  BoxShape get shape => expandableFabStyle.shape;

  /// Distance of satellite actions
  double get distance => expandableFabStyle.distance;

  /// Animation strategy
  FabAnimationType get type => expandableFabStyle.type;

  /// Overlay appearance (scrim, blur, animation)
  OverlaySpec get overlay => expandableFabStyle.overlay;

  /// Pixel theme dither pattern
  bool get showDitherPattern => expandableFabStyle.showDitherPattern;

  /// Glass theme glow effect
  bool get glowEffect => expandableFabStyle.glowEffect;

  /// Pixel/Brutal high contrast border
  bool get highContrastBorder => expandableFabStyle.highContrastBorder;
  Color get overlayColor => expandableFabStyle.overlayColor;
  bool get enableBlur => expandableFabStyle.enableBlur;
}
