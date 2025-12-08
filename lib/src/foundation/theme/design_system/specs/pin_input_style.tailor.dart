// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pin_input_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$PinInputStyleTailorMixin on ThemeExtension<PinInputStyle> {
  PinCellShape get cellShape;
  bool get fillOnInput;
  bool get glowOnActive;
  TextStyle get textStyle;
  double get cellSpacing;
  double get cellSize;

  @override
  PinInputStyle copyWith({
    PinCellShape? cellShape,
    bool? fillOnInput,
    bool? glowOnActive,
    TextStyle? textStyle,
    double? cellSpacing,
    double? cellSize,
  }) {
    return PinInputStyle(
      cellShape: cellShape ?? this.cellShape,
      fillOnInput: fillOnInput ?? this.fillOnInput,
      glowOnActive: glowOnActive ?? this.glowOnActive,
      textStyle: textStyle ?? this.textStyle,
      cellSpacing: cellSpacing ?? this.cellSpacing,
      cellSize: cellSize ?? this.cellSize,
    );
  }

  @override
  PinInputStyle lerp(covariant ThemeExtension<PinInputStyle>? other, double t) {
    if (other is! PinInputStyle) return this as PinInputStyle;
    return PinInputStyle(
      cellShape: t < 0.5 ? cellShape : other.cellShape,
      fillOnInput: t < 0.5 ? fillOnInput : other.fillOnInput,
      glowOnActive: t < 0.5 ? glowOnActive : other.glowOnActive,
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      cellSpacing: t < 0.5 ? cellSpacing : other.cellSpacing,
      cellSize: t < 0.5 ? cellSize : other.cellSize,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PinInputStyle &&
            const DeepCollectionEquality().equals(cellShape, other.cellShape) &&
            const DeepCollectionEquality()
                .equals(fillOnInput, other.fillOnInput) &&
            const DeepCollectionEquality()
                .equals(glowOnActive, other.glowOnActive) &&
            const DeepCollectionEquality().equals(textStyle, other.textStyle) &&
            const DeepCollectionEquality()
                .equals(cellSpacing, other.cellSpacing) &&
            const DeepCollectionEquality().equals(cellSize, other.cellSize));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(cellShape),
      const DeepCollectionEquality().hash(fillOnInput),
      const DeepCollectionEquality().hash(glowOnActive),
      const DeepCollectionEquality().hash(textStyle),
      const DeepCollectionEquality().hash(cellSpacing),
      const DeepCollectionEquality().hash(cellSize),
    );
  }
}

extension PinInputStyleBuildContextProps on BuildContext {
  PinInputStyle get pinInputStyle => Theme.of(this).extension<PinInputStyle>()!;
  PinCellShape get cellShape => pinInputStyle.cellShape;
  bool get fillOnInput => pinInputStyle.fillOnInput;
  bool get glowOnActive => pinInputStyle.glowOnActive;
  TextStyle get textStyle => pinInputStyle.textStyle;
  double get cellSpacing => pinInputStyle.cellSpacing;
  double get cellSize => pinInputStyle.cellSize;
}
