import 'package:flutter/widgets.dart';

enum SlideActionVariant {
  standard,
  destructive,
  neutral,
}

class SlideActionItem {
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final SlideActionVariant variant;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const SlideActionItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.variant = SlideActionVariant.standard,
    this.foregroundColor,
    this.backgroundColor,
  });
}
