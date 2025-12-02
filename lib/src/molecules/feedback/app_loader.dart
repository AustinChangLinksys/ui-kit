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

    Widget loaderWidget;

    if (variant == LoaderVariant.linear) {
      loaderWidget = _buildLinear(context, style, color);
    } else {
      switch (style.type) {
        case LoaderType.block:
          loaderWidget = _BrutalSpinner(
            color: color,
            size: style.size,
            duration: style.period,
          );
          break;
        case LoaderType.pulse:
          loaderWidget = _PulseSpinner(
            color: color,
            size: style.size,
            shadows: style.shadows,
          );
          break;
        case LoaderType.circular:
          loaderWidget = SizedBox(
            width: style.size,
            height: style.size,
            child: CircularProgressIndicator(
              value: value,
              strokeWidth: style.strokeWidth,
              color: color,
              backgroundColor: style.backgroundColor,
              strokeCap: StrokeCap.round,
            ),
          );
          break;
      }
    }

    loaderWidget = RepaintBoundary(child: loaderWidget);

    if (label != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          loaderWidget,
          SizedBox(height: theme.spacingFactor * 8),
          Text(
            label!,
            style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      );
    }

    return loaderWidget;
  }

  Widget _buildLinear(BuildContext context, LoaderStyle style, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(style.strokeWidth),
      child: LinearProgressIndicator(
        value: value,
        minHeight: style.strokeWidth,
        color: color,
        backgroundColor: style.backgroundColor ?? color.withValues(alpha: 0.2),
      ),
    );
  }
}

// --- Private Renderers (Visual Tuned) ---

class _BrutalSpinner extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const _BrutalSpinner({
    required this.color,
    required this.size,
    required this.duration,
  });

  @override
  State<_BrutalSpinner> createState() => _BrutalSpinnerState();
}

class _BrutalSpinnerState extends State<_BrutalSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)
      ..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final step = (_controller.value * 4).floor();
        final angle = step * (3.14159 / 2);

        return Transform.rotate(
          angle: angle,
          child: AppSurface(
            width: widget.size,
            height: widget.size,
            style: SurfaceStyle(
              backgroundColor: widget.color,
              borderColor: Colors.black,
              borderWidth: 2.0,
              borderRadius: 0,
              shadows: [],
              blurStrength: 0,
              contentColor: Colors.transparent,
            ),
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                width: widget.size / 2.5,
                height: widget.size / 2.5,
                color: Colors.black,
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PulseSpinner extends StatefulWidget {
  final Color color;
  final double size;
  final List<BoxShadow> shadows;

  const _PulseSpinner({
    required this.color,
    required this.size,
    this.shadows = const [],
  });

  @override
  State<_PulseSpinner> createState() => _PulseSpinnerState();
}

class _PulseSpinnerState extends State<_PulseSpinner>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        final scale = 0.8 + (_controller.value * 0.4);

        return Stack(
          alignment: Alignment.center,
          children: [
            Transform.scale(
              scale: scale,
              child: Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.color
                      .withValues(alpha: 0.2 * (1 - _controller.value)),
                  boxShadow: widget.shadows,
                ),
              ),
            ),
            SizedBox(
              width: widget.size * 0.6,
              height: widget.size * 0.6,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: widget.color,
              ),
            ),
          ],
        );
      },
    );
  }
}
