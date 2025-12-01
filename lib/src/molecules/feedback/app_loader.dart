import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

enum LoaderVariant {
  circular,
  linear,
}

class AppLoader extends StatelessWidget {
  const AppLoader({
    this.variant = LoaderVariant.circular,
    this.value,
    this.label,
    super.key,
  });

  final LoaderVariant variant;
  final double? value;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final style = theme.loaderStyle;
    final color = style.color ?? theme.surfaceHighlight.contentColor;

    Widget loader;

    if (variant == LoaderVariant.circular) {
      loader = SizedBox(
        width: style.size,
        height: style.size,
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: style.strokeWidth,
          color: color,
          strokeCap: StrokeCap.round,
        ),
      );
    } else {
      loader = LinearProgressIndicator(
        value: value,
        minHeight: style.strokeWidth,
        color: color,
        backgroundColor: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(style.strokeWidth),
      );
    }

    // Performance optimization per Constitution 11.0
    loader = RepaintBoundary(child: loader);

    if (label != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loader,
          SizedBox(height: theme.spacingFactor * 8),
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(color: color),
          ),
        ],
      );
    }

    return loader;
  }
}
