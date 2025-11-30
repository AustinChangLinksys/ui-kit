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
  final SurfaceStyle? style; // ✨ 新增：直接傳入樣式 (優先權最高)
  final BoxShape shape;

  const AppSurface({
    super.key,
    required this.child,
    this.variant = SurfaceVariant.base,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.interactive = false,
    this.shape = BoxShape.rectangle,
    this.style,
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

    final effectiveStyle = style ?? _resolveStyle(theme, variant);
    final effectivePadding = padding ?? EdgeInsets.zero;

    // Use AnimatedContainer for implicit animations when theme/style changes
    Widget content = AnimatedContainer(
      duration: theme.animation.duration,
      curve: theme.animation.curve,
      width: width,
      height: height,
      padding: effectivePadding,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        border: effectiveStyle.customBorder ??
            Border.all(
              color: effectiveStyle.borderColor,
              width: effectiveStyle.borderWidth,
            ),
        borderRadius: shape == BoxShape.circle
            ? null
            : BorderRadius.circular(effectiveStyle.borderRadius),
        boxShadow: effectiveStyle.shadows,
        // ✨ Apply shape
        shape: shape,
      ),
      child: DefaultTextStyle.merge(
        style: TextStyle(
          color: effectiveStyle.contentColor,
          fontFamily: theme.typography.bodyFontFamily,
        ),
        child: child,
      ),
    );

    if (effectiveStyle.blurStrength > 0) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(effectiveStyle.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: effectiveStyle.blurStrength,
            sigmaY: effectiveStyle.blurStrength,
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
