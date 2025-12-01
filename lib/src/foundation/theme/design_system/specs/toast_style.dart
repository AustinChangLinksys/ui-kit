import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'toast_style.tailor.dart';

@TailorMixin()
class ToastStyle extends ThemeExtension<ToastStyle> with _$ToastStyleTailorMixin {
  const ToastStyle({
    required this.padding,
    required this.margin,
    required this.borderRadius,
    required this.backgroundColor,
    required this.textStyle,
    required this.displayDuration,
  });

  @override
  final EdgeInsets padding;
  
  @override
  final EdgeInsets margin;
  
  @override
  final BorderRadius borderRadius;
  
  @override
  final Color? backgroundColor;
  
  @override
  final TextStyle textStyle;
  
  @override
  final Duration displayDuration;
}
