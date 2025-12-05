// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'bottom_sheet_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$BottomSheetStyleTailorMixin on ThemeExtension<BottomSheetStyle> {
  Color get overlayColor;
  Duration get animationDuration;
  Curve get animationCurve;
  double get topBorderRadius;
  double get dragHandleHeight;

  @override
  BottomSheetStyle copyWith({
    Color? overlayColor,
    Duration? animationDuration,
    Curve? animationCurve,
    double? topBorderRadius,
    double? dragHandleHeight,
  }) {
    return BottomSheetStyle(
      overlayColor: overlayColor ?? this.overlayColor,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      topBorderRadius: topBorderRadius ?? this.topBorderRadius,
      dragHandleHeight: dragHandleHeight ?? this.dragHandleHeight,
    );
  }

  @override
  BottomSheetStyle lerp(
      covariant ThemeExtension<BottomSheetStyle>? other, double t) {
    if (other is! BottomSheetStyle) return this as BottomSheetStyle;
    return BottomSheetStyle(
      overlayColor: Color.lerp(overlayColor, other.overlayColor, t)!,
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
      animationCurve: t < 0.5 ? animationCurve : other.animationCurve,
      topBorderRadius: t < 0.5 ? topBorderRadius : other.topBorderRadius,
      dragHandleHeight: t < 0.5 ? dragHandleHeight : other.dragHandleHeight,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is BottomSheetStyle &&
            const DeepCollectionEquality()
                .equals(overlayColor, other.overlayColor) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration) &&
            const DeepCollectionEquality()
                .equals(animationCurve, other.animationCurve) &&
            const DeepCollectionEquality()
                .equals(topBorderRadius, other.topBorderRadius) &&
            const DeepCollectionEquality()
                .equals(dragHandleHeight, other.dragHandleHeight));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(overlayColor),
      const DeepCollectionEquality().hash(animationDuration),
      const DeepCollectionEquality().hash(animationCurve),
      const DeepCollectionEquality().hash(topBorderRadius),
      const DeepCollectionEquality().hash(dragHandleHeight),
    );
  }
}

extension BottomSheetStyleBuildContextProps on BuildContext {
  BottomSheetStyle get bottomSheetStyle =>
      Theme.of(this).extension<BottomSheetStyle>()!;

  /// Scrim color when sheet is open
  Color get overlayColor => bottomSheetStyle.overlayColor;

  /// Animation duration for open/close transitions
  Duration get animationDuration => bottomSheetStyle.animationDuration;

  /// Animation curve for open/close transitions
  Curve get animationCurve => bottomSheetStyle.animationCurve;

  /// Border radius for top corners of sheet
  double get topBorderRadius => bottomSheetStyle.topBorderRadius;

  /// Height of the draggable handle indicator
  double get dragHandleHeight => bottomSheetStyle.dragHandleHeight;
}
