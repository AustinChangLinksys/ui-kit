// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'loader_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$LoaderStyleTailorMixin on ThemeExtension<LoaderStyle> {
  LoaderType get type;
  Color? get backgroundColor;
  List<BoxShadow> get shadows;
  double get borderRadius;
  Color? get color;
  double get strokeWidth;
  double get size;
  Duration get period;

  @override
  LoaderStyle copyWith({
    LoaderType? type,
    Color? backgroundColor,
    List<BoxShadow>? shadows,
    double? borderRadius,
    Color? color,
    double? strokeWidth,
    double? size,
    Duration? period,
  }) {
    return LoaderStyle(
      type: type ?? this.type,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      shadows: shadows ?? this.shadows,
      borderRadius: borderRadius ?? this.borderRadius,
      color: color ?? this.color,
      strokeWidth: strokeWidth ?? this.strokeWidth,
      size: size ?? this.size,
      period: period ?? this.period,
    );
  }

  @override
  LoaderStyle lerp(covariant ThemeExtension<LoaderStyle>? other, double t) {
    if (other is! LoaderStyle) return this as LoaderStyle;
    return LoaderStyle(
      type: t < 0.5 ? type : other.type,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      shadows: t < 0.5 ? shadows : other.shadows,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      color: Color.lerp(color, other.color, t),
      strokeWidth: t < 0.5 ? strokeWidth : other.strokeWidth,
      size: t < 0.5 ? size : other.size,
      period: t < 0.5 ? period : other.period,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LoaderStyle &&
            const DeepCollectionEquality().equals(type, other.type) &&
            const DeepCollectionEquality()
                .equals(backgroundColor, other.backgroundColor) &&
            const DeepCollectionEquality().equals(shadows, other.shadows) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality().equals(color, other.color) &&
            const DeepCollectionEquality()
                .equals(strokeWidth, other.strokeWidth) &&
            const DeepCollectionEquality().equals(size, other.size) &&
            const DeepCollectionEquality().equals(period, other.period));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(type),
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(shadows),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(strokeWidth),
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(period),
    );
  }
}

extension LoaderStyleBuildContextProps on BuildContext {
  LoaderStyle get loaderStyle => Theme.of(this).extension<LoaderStyle>()!;
  LoaderType get type => loaderStyle.type;
  Color? get backgroundColor => loaderStyle.backgroundColor;
  List<BoxShadow> get shadows => loaderStyle.shadows;
  double get borderRadius => loaderStyle.borderRadius;
  Color? get color => loaderStyle.color;
  double get strokeWidth => loaderStyle.strokeWidth;
  double get size => loaderStyle.size;
  Duration get period => loaderStyle.period;
}
