import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'loader_style.tailor.dart';

enum LoaderType {
  circular, 
  block,    
  pulse,    
}

@TailorMixin()
class LoaderStyle extends ThemeExtension<LoaderStyle> with _$LoaderStyleTailorMixin {
  const LoaderStyle({
    required this.type,
    required this.color,
    this.backgroundColor,
    required this.strokeWidth,
    required this.size,
    required this.period,
    this.shadows = const [],
    this.borderRadius = 0.0,
  });

  @override
  final LoaderType type;

  @override
  final Color? backgroundColor;

  @override
  final List<BoxShadow> shadows;

  @override
  final double borderRadius;

  @override
  final Color? color;
  
  @override
  final double strokeWidth;
  
  @override
  final double size;
  
  @override
  final Duration period;
}
