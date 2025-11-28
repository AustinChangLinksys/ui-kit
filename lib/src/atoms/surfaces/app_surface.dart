import 'dart:ui';
import 'package:flutter/material.dart';
import '../../foundation/theme/design_system/app_design_theme.dart';
import '../../foundation/theme/design_system/surface_style.dart';

enum SurfaceVariant { base, elevated, highlight }

class AppSurface extends StatelessWidget {
  final Widget child;
  final SurfaceVariant variant;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final bool interactive;

  const AppSurface({
    super.key,
    required this.child,
    this.variant = SurfaceVariant.base,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.interactive = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    
    if (theme == null) {
       return Container(
         width: width,
         height: height,
         padding: padding,
         child: child,
       );
    }

    final style = _resolveStyle(theme, variant);
    final effectivePadding = padding ?? EdgeInsets.all(16.0 * theme.spacingFactor);

    // Use AnimatedContainer for implicit animations when theme/style changes
    Widget content = AnimatedContainer(
      duration: theme.animation.duration,
      curve: theme.animation.curve,
      width: width,
      height: height,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: style.backgroundColor,
        border: Border.all(
          color: style.borderColor,
          width: style.borderWidth,
        ),
        borderRadius: BorderRadius.circular(style.borderRadius),
        boxShadow: style.shadows,
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: style.contentColor,
          fontFamily: theme.typography.bodyFontFamily,
        ),
        child: child,
      ),
    );

    if (style.blurStrength > 0) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(style.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: style.blurStrength,
            sigmaY: style.blurStrength,
          ),
          child: content,
        ),
      );
    }

    if (onTap != null || interactive) {
      content = GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: content,
      );
    }

    return content;
  }

  SurfaceStyle _resolveStyle(AppDesignTheme theme, SurfaceVariant variant) {
    switch (variant) {
      case SurfaceVariant.base:
        return theme.surfaceBase;
      case SurfaceVariant.elevated:
        return theme.surfaceElevated;
      case SurfaceVariant.highlight:
        return theme.surfaceHighlight;
    }
  }
}
