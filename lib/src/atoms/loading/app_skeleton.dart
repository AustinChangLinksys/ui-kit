import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/skeleton_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A theme-aware loading placeholder.
///
/// It adapts its visual style (Glass, Brutal, Flat) based on the [AppDesignTheme].
class AppSkeleton extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  const AppSkeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
  });

  /// Creates a skeleton tailored for text lines.
  ///
  /// Defaults to a height of 16.0 (standard body text) and a smaller border radius.
  factory AppSkeleton.text({
    double? width,
    double height = 16.0,
    double radius = 4.0, // Text usually has sharper corners than cards
  }) {
    return AppSkeleton(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(radius),
      shape: BoxShape.rectangle,
    );
  }

  /// Creates a circular skeleton (e.g., for Avatars).
  ///
  /// Forces the border radius to be infinite to ensure a perfect circle.
  factory AppSkeleton.circular({
    required double size,
  }) {
    return AppSkeleton(
      width: size,
      height: size,
      borderRadius: BorderRadius.circular(999.0),
      shape: BoxShape.circle,
    );
  }

  factory AppSkeleton.capsule({
    double? width,
    double? height,
  }) {
    return AppSkeleton(
      width: width,
      height: height,
      borderRadius: BorderRadius.circular(999.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    final style = theme.skeletonStyle;

    // 1. get outer radius
    final outerRadiusValue = style.borderRadius;
    final effectiveOuterRadius =
        borderRadius ?? BorderRadius.circular(outerRadiusValue);

    // 2. get border width (from Theme, usually 1.0 or 3.0)
    final borderWidth = theme.surfaceBase.borderWidth;

    // 3. calculate inner radius
    // inner radius = outer radius - border width (to prevent content from drawing under the border or overflow)
    final innerRadius = _subtractRadius(effectiveOuterRadius, borderWidth);

    return AppSurface(
      width: width,
      height: height,
      style: SurfaceStyle(
        backgroundColor: Colors.transparent,
        borderColor: theme.surfaceBase.borderColor.withValues(alpha: 0.2),
        borderWidth: borderWidth,
        borderRadius: effectiveOuterRadius.topLeft.x,
        shadows: const [],
        blurStrength: 0,
        contentColor: Colors.transparent,
      ),
      padding:
          EdgeInsets.zero, // ensure content is tightly against the inner border
      child: ClipRRect(
        borderRadius: innerRadius,
        child: _buildAnimation(style),
      ),
    );
  }

  // helper function: calculate inner radius
  BorderRadius _subtractRadius(BorderRadius radius, double width) {
    return BorderRadius.only(
      topLeft: Radius.circular(math.max(0, radius.topLeft.x - width)),
      topRight: Radius.circular(math.max(0, radius.topRight.x - width)),
      bottomLeft: Radius.circular(math.max(0, radius.bottomLeft.x - width)),
      bottomRight: Radius.circular(math.max(0, radius.bottomRight.x - width)),
    );
  }

  /// Factory to choose the correct animation renderer based on the spec.
  Widget _buildAnimation(SkeletonStyle style) {
    switch (style.animationType) {
      case SkeletonAnimationType.pulse:
        return _PulseAnimation(
          baseColor: style.baseColor,
          highlightColor: style.highlightColor,
        );
      case SkeletonAnimationType.blink:
        return _BlinkAnimation(
          baseColor: style.baseColor,
          highlightColor: style.highlightColor,
        );
      case SkeletonAnimationType.shimmer:
        return _PulseAnimation(
          baseColor: style.baseColor,
          highlightColor: style.highlightColor,
        );
    }
  }
}

// --- Private Animation Renderers ---

class _PulseAnimation extends StatefulWidget {
  final Color baseColor;
  final Color highlightColor;

  const _PulseAnimation({
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  State<_PulseAnimation> createState() => _PulseAnimationState();
}

class _PulseAnimationState extends State<_PulseAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    // Glassmorphism breathes slowly (Pulse)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);

    _colorAnimation = ColorTween(
      begin: widget.baseColor,
      end: widget.highlightColor,
    ).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return Container(color: _colorAnimation.value);
      },
    );
  }
}

class _BlinkAnimation extends StatefulWidget {
  final Color baseColor;
  final Color highlightColor;

  const _BlinkAnimation({
    required this.baseColor,
    required this.highlightColor,
  });

  @override
  State<_BlinkAnimation> createState() => _BlinkAnimationState();
}

class _BlinkAnimationState extends State<_BlinkAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Neo-Brutalism blinks sharply (Hard Cut)
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat();
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
      builder: (context, child) {
        // Step function: 0.0-0.5 = Base, 0.5-1.0 = Highlight
        final color =
            _controller.value < 0.5 ? widget.baseColor : widget.highlightColor;
        return Container(color: color);
      },
    );
  }
}
