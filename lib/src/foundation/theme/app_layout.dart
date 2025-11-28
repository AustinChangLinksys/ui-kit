import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_layout.tailor.dart';

@TailorMixin()
class AppLayout extends ThemeExtension<AppLayout> with _$AppLayoutTailorMixin {
  // 1. 定義欄位 (Fields)
  @override
  final double breakpointMobile;
  @override
  final double breakpointTablet;
  @override
  final double breakpointDesktop;
  @override
  final int maxColumns;
  @override
  final double gutter;
  @override
  final double margin;

  // 2. 標準建構子 (Constructor)
  const AppLayout({
    required this.breakpointMobile,
    required this.breakpointTablet,
    required this.breakpointDesktop,
    required this.maxColumns,
    required this.gutter,
    required this.margin,
  });

  // 3. 定義實例 (Instances)
  static const regular = AppLayout(
    breakpointMobile: 600,
    breakpointTablet: 900,
    breakpointDesktop: 1200,
    maxColumns: 12,
    gutter: 16.0,
    margin: 24.0,
  );
}