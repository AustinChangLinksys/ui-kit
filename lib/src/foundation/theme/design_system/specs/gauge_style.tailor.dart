// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'gauge_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$GaugeStyleTailorMixin on ThemeExtension<GaugeStyle> {
  GaugeRenderType get type;
  GaugeCapType get cap;
  Color get trackColor;
  Color get indicatorColor;
  bool get showTicks;
  int? get tickCount;
  double? get tickInterval;
  double get strokeWidth;
  bool get enableGlow;
  double get fillRatio;
  double get offsetAngle;
  double get markerRadius;
  bool get displayMarkerValues;
  Color get markerColor;
  double get innerGlowWidth;
  double get innerGlowOpacity;
  AnimationSpec get animation;
  Duration get animationDuration;
  Curve get animationCurve;

  @override
  GaugeStyle copyWith({
    GaugeRenderType? type,
    GaugeCapType? cap,
    Color? trackColor,
    Color? indicatorColor,
    bool? showTicks,
    int? tickCount,
    double? tickInterval,
    double? strokeWidth,
    bool? enableGlow,
    double? fillRatio,
    double? offsetAngle,
    double? markerRadius,
    bool? displayMarkerValues,
    Color? markerColor,
    double? innerGlowWidth,
    double? innerGlowOpacity,
    AnimationSpec? animation,
    Duration? animationDuration,
    Curve? animationCurve,
  }) {
    return GaugeStyle(
      type: type ?? this.type,
      cap: cap ?? this.cap,
      trackColor: trackColor ?? this.trackColor,
      indicatorColor: indicatorColor ?? this.indicatorColor,
      showTicks: showTicks ?? this.showTicks,
      tickCount: tickCount ?? this.tickCount,
      tickInterval: tickInterval ?? this.tickInterval,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      enableGlow: enableGlow ?? this.enableGlow,
      fillRatio: fillRatio ?? this.fillRatio,
      offsetAngle: offsetAngle ?? this.offsetAngle,
      markerRadius: markerRadius ?? this.markerRadius,
      displayMarkerValues: displayMarkerValues ?? this.displayMarkerValues,
      markerColor: markerColor ?? this.markerColor,
      innerGlowWidth: innerGlowWidth ?? this.innerGlowWidth,
      innerGlowOpacity: innerGlowOpacity ?? this.innerGlowOpacity,
      animation: animation ?? this.animation,
    );
  }

  @override
  GaugeStyle lerp(covariant ThemeExtension<GaugeStyle>? other, double t) {
    if (other is! GaugeStyle) return this as GaugeStyle;
    return GaugeStyle(
      type: t < 0.5 ? type : other.type,
      cap: t < 0.5 ? cap : other.cap,
      trackColor: Color.lerp(trackColor, other.trackColor, t)!,
      indicatorColor: Color.lerp(indicatorColor, other.indicatorColor, t)!,
      showTicks: t < 0.5 ? showTicks : other.showTicks,
      tickCount: t < 0.5 ? tickCount : other.tickCount,
      tickInterval: t < 0.5 ? tickInterval : other.tickInterval,
      strokeWidth: t < 0.5 ? strokeWidth : other.strokeWidth,
      enableGlow: t < 0.5 ? enableGlow : other.enableGlow,
      fillRatio: t < 0.5 ? fillRatio : other.fillRatio,
      offsetAngle: t < 0.5 ? offsetAngle : other.offsetAngle,
      markerRadius: t < 0.5 ? markerRadius : other.markerRadius,
      displayMarkerValues:
          t < 0.5 ? displayMarkerValues : other.displayMarkerValues,
      markerColor: Color.lerp(markerColor, other.markerColor, t)!,
      innerGlowWidth: t < 0.5 ? innerGlowWidth : other.innerGlowWidth,
      innerGlowOpacity: t < 0.5 ? innerGlowOpacity : other.innerGlowOpacity,
      animation: animation.lerp(other.animation, t),
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GaugeStyle &&
            const DeepCollectionEquality().equals(type, other.type) &&
            const DeepCollectionEquality().equals(cap, other.cap) &&
            const DeepCollectionEquality()
                .equals(trackColor, other.trackColor) &&
            const DeepCollectionEquality()
                .equals(indicatorColor, other.indicatorColor) &&
            const DeepCollectionEquality().equals(showTicks, other.showTicks) &&
            const DeepCollectionEquality().equals(tickCount, other.tickCount) &&
            const DeepCollectionEquality()
                .equals(tickInterval, other.tickInterval) &&
            const DeepCollectionEquality()
                .equals(strokeWidth, other.strokeWidth) &&
            const DeepCollectionEquality()
                .equals(enableGlow, other.enableGlow) &&
            const DeepCollectionEquality().equals(fillRatio, other.fillRatio) &&
            const DeepCollectionEquality()
                .equals(offsetAngle, other.offsetAngle) &&
            const DeepCollectionEquality()
                .equals(markerRadius, other.markerRadius) &&
            const DeepCollectionEquality()
                .equals(displayMarkerValues, other.displayMarkerValues) &&
            const DeepCollectionEquality()
                .equals(markerColor, other.markerColor) &&
            const DeepCollectionEquality()
                .equals(innerGlowWidth, other.innerGlowWidth) &&
            const DeepCollectionEquality()
                .equals(innerGlowOpacity, other.innerGlowOpacity) &&
            const DeepCollectionEquality().equals(animation, other.animation) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration) &&
            const DeepCollectionEquality()
                .equals(animationCurve, other.animationCurve));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(cap),
      const DeepCollectionEquality().hash(trackColor),
      const DeepCollectionEquality().hash(indicatorColor),
      const DeepCollectionEquality().hash(showTicks),
      const DeepCollectionEquality().hash(tickCount),
      const DeepCollectionEquality().hash(tickInterval),
      const DeepCollectionEquality().hash(strokeWidth),
      const DeepCollectionEquality().hash(enableGlow),
      const DeepCollectionEquality().hash(fillRatio),
      const DeepCollectionEquality().hash(offsetAngle),
      const DeepCollectionEquality().hash(markerRadius),
      const DeepCollectionEquality().hash(displayMarkerValues),
      const DeepCollectionEquality().hash(markerColor),
      const DeepCollectionEquality().hash(innerGlowWidth),
      const DeepCollectionEquality().hash(innerGlowOpacity),
      const DeepCollectionEquality().hash(animation),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
    );
  }
}

extension GaugeStyleBuildContextProps on BuildContext {
  GaugeStyle get gaugeStyle => Theme.of(this).extension<GaugeStyle>()!;
  GaugeRenderType get type => gaugeStyle.type;
  GaugeCapType get cap => gaugeStyle.cap;
  Color get trackColor => gaugeStyle.trackColor;

  /// Primary indicator color for the progress arc
  Color get indicatorColor => gaugeStyle.indicatorColor;
  bool get showTicks => gaugeStyle.showTicks;
  int? get tickCount => gaugeStyle.tickCount;
  double? get tickInterval => gaugeStyle.tickInterval;
  double get strokeWidth => gaugeStyle.strokeWidth;
  bool get enableGlow => gaugeStyle.enableGlow;

  /// 0.8 = 288 degrees (like old AnimatedMeter)
  double get fillRatio => gaugeStyle.fillRatio;

  /// Starting offset angle
  double get offsetAngle => gaugeStyle.offsetAngle;
  double get markerRadius => gaugeStyle.markerRadius;
  bool get displayMarkerValues => gaugeStyle.displayMarkerValues;
  Color get markerColor => gaugeStyle.markerColor;
  double get innerGlowWidth => gaugeStyle.innerGlowWidth;
  double get innerGlowOpacity => gaugeStyle.innerGlowOpacity;

  /// Animation timing for gauge transitions
  AnimationSpec get animation => gaugeStyle.animation;
  Duration get animationDuration => gaugeStyle.animationDuration;
  Curve get animationCurve => gaugeStyle.animationCurve;
}
