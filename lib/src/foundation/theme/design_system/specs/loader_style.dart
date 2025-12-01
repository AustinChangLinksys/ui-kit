import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'loader_style.tailor.dart';

@TailorMixin()
class LoaderStyle extends ThemeExtension<LoaderStyle> with _$LoaderStyleTailorMixin {
  const LoaderStyle({
    required this.color,
    required this.strokeWidth,
    required this.size,
    required this.period,
  });

  @override
  final Color? color;
  
  @override
  final double strokeWidth;
  
  @override
  final double size;
  
  @override
  final Duration period;
}
