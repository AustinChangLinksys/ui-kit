// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'toast_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$ToastStyleTailorMixin on ThemeExtension<ToastStyle> {
  EdgeInsets get padding;
  EdgeInsets get margin;
  BorderRadius get borderRadius;
  Color? get backgroundColor;
  TextStyle get textStyle;
  Duration get displayDuration;

  @override
  ToastStyle copyWith({
    EdgeInsets? padding,
    EdgeInsets? margin,
    BorderRadius? borderRadius,
    Color? backgroundColor,
    TextStyle? textStyle,
    Duration? displayDuration,
  }) {
    return ToastStyle(
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      borderRadius: borderRadius ?? this.borderRadius,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      textStyle: textStyle ?? this.textStyle,
      displayDuration: displayDuration ?? this.displayDuration,
    );
  }

  @override
  ToastStyle lerp(covariant ThemeExtension<ToastStyle>? other, double t) {
    if (other is! ToastStyle) return this as ToastStyle;
    return ToastStyle(
      padding: t < 0.5 ? padding : other.padding,
      margin: t < 0.5 ? margin : other.margin,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
      displayDuration: t < 0.5 ? displayDuration : other.displayDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is ToastStyle &&
            const DeepCollectionEquality().equals(padding, other.padding) &&
            const DeepCollectionEquality().equals(margin, other.margin) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality()
                .equals(backgroundColor, other.backgroundColor) &&
            const DeepCollectionEquality().equals(textStyle, other.textStyle) &&
            const DeepCollectionEquality()
                .equals(displayDuration, other.displayDuration));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(padding),
      const DeepCollectionEquality().hash(margin),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(textStyle),
      const DeepCollectionEquality().hash(displayDuration),
    );
  }
}

extension ToastStyleBuildContextProps on BuildContext {
  ToastStyle get toastStyle => Theme.of(this).extension<ToastStyle>()!;
  EdgeInsets get padding => toastStyle.padding;
  EdgeInsets get margin => toastStyle.margin;
  BorderRadius get borderRadius => toastStyle.borderRadius;
  Color? get backgroundColor => toastStyle.backgroundColor;
  TextStyle get textStyle => toastStyle.textStyle;
  Duration get displayDuration => toastStyle.displayDuration;
}
