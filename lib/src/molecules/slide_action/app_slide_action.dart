import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppSlideAction extends StatefulWidget {
  final Widget child;
  final List<SlideActionItem> actions;
  final bool enabled;
  final VoidCallback? onOpened;
  final VoidCallback? onClosed;

  /// Whether the slide action should start in the open state.
  /// Useful for testing and previewing the action buttons.
  final bool initiallyOpen;

  const AppSlideAction({
    super.key,
    required this.child,
    required this.actions,
    this.enabled = true,
    this.onOpened,
    this.onClosed,
    this.initiallyOpen = false,
  });

  @override
  State<AppSlideAction> createState() => _AppSlideActionState();
}

class _AppSlideActionState extends State<AppSlideAction>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _maxDragExtent = 0.0;
  static const double _actionWidth = 80.0;

  double _rawDragDelta = 0.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      lowerBound: 0.0,
      upperBound: 1.0,
      value: widget.initiallyOpen ? 1.0 : 0.0,
    )..addListener(() {
        setState(() {});
      });
    if (widget.initiallyOpen) {
      _rawDragDelta = _actionWidth * 2;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maxDragExtent = widget.actions.length * _actionWidth;
    if (widget.initiallyOpen) {
      _rawDragDelta = _maxDragExtent;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleDragUpdate(DragUpdateDetails details) {
    if (!widget.enabled) return;
    setState(() {
      _rawDragDelta -= details.primaryDelta!;
      _controller.value = (_rawDragDelta / _maxDragExtent).clamp(0.0, 1.0);
    });
  }

  void _handleDragEnd(DragEndDetails details) {
    if (!widget.enabled) return;
    final theme = AppDesignTheme.of(context);
    final style = theme.slideActionStyle;
    final velocity = details.primaryVelocity ?? 0.0;

    final bool shouldOpen;
    if (velocity < -500) {
      shouldOpen = true;
    } else if (velocity > 500) {
      shouldOpen = false;
    } else {
      shouldOpen = _controller.value > 0.5;
    }

    _runAnimation(
        shouldOpen ? 1.0 : 0.0, style.animationDuration, style.animationCurve);
    _rawDragDelta = (shouldOpen ? 1.0 : 0.0) * _maxDragExtent;
  }

  void _runAnimation(double targetValue, Duration duration, Curve curve) {
    if (duration == Duration.zero) {
      _controller.value = targetValue;
      _handleAnimationCompletion(targetValue);
    } else {
      _controller
          .animateTo(targetValue, duration: duration, curve: curve)
          .then((_) => _handleAnimationCompletion(targetValue));
    }
  }

  void _handleAnimationCompletion(double finalValue) {
    if (finalValue > 0) {
      widget.onOpened?.call();
      AppFeedback.onInteraction();
    } else {
      widget.onClosed?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppDesignTheme.of(context);
    final style = theme.slideActionStyle;

    return ClipRRect(
      borderRadius: style.borderRadius,
      child: Stack(
        children: [
          // Actions Layer (Behind)
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: widget.actions.map((action) {
                return _buildActionItem(action, style, theme);
              }).toList(),
            ),
          ),
          // Content Layer (Foreground)
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(-_controller.value * _maxDragExtent, 0),
                child: child,
              );
            },
            child: GestureDetector(
              onHorizontalDragUpdate: _handleDragUpdate,
              onHorizontalDragEnd: _handleDragEnd,
              child: widget.child,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionItem(
      SlideActionItem action, SlideActionStyle style, AppDesignTheme theme) {
    final effectiveSurfaceStyle =
        action.variant == SlideActionVariant.destructive
            ? style.destructiveStyle
            : style.standardStyle;

    final icon = IconTheme(
      data: IconThemeData(
        color: effectiveSurfaceStyle.contentColor,
        size: style.iconSize,
      ),
      child: action.icon,
    );

    return GestureDetector(
      onTap: () {
        AppFeedback.onInteraction();
        action.onTap();
        _runAnimation(0.0, style.animationDuration, style.animationCurve);
      },
      child: AppSurface(
        width: _actionWidth,
        height: double.infinity,
        style: effectiveSurfaceStyle,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              icon,
              AppText.bodySmall(action.label,
                  color: effectiveSurfaceStyle.contentColor),
            ],
          ),
        ),
      ),
    );
  }
}
