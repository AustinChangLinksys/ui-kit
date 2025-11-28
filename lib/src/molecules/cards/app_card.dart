import 'package:flutter/material.dart';
import '../../atoms/surfaces/app_surface.dart';

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
    return AppSurface(
      variant: SurfaceVariant.base,
      onTap: onTap,
      width: width,
      height: height,
      padding: padding,
      child: child,
    );
  }
}
