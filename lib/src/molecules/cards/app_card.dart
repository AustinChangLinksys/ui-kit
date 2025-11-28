import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    return AppSurface(
      variant: SurfaceVariant.base,
      onTap: onTap,
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.0 * theme.spacingFactor),
      child: child,
    );
  }
}
