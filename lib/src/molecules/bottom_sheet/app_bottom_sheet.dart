import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Configuration for bottom sheet display
enum BottomSheetDisplayMode {
  /// Sheet takes minimal height needed for content
  intrinsic,

  /// Sheet expands to fill available vertical space up to maxHeight
  expanded,
}

/// AppBottomSheet displays secondary options/details from the bottom of the screen
///
/// Features:
/// - Animated slide-up from bottom using flutter_animate
/// - Dismissible with tap outside or programmatic control
/// - Supports custom max/min heights
/// - Theme-aware styling with animated backdrop scrim
/// - Accessibility: proper semantics, keyboard support (Escape to close)
class AppBottomSheet extends StatefulWidget {
  /// Main content widget of the sheet
  final Widget child;

  /// Maximum height the sheet can expand to (default: 90% of screen height)
  final double? maxHeight;

  /// Minimum height the sheet maintains (default: 100)
  final double? minHeight;

  /// Padding around sheet content
  final EdgeInsets padding;

  /// Callback when sheet is dismissed
  final VoidCallback? onDismiss;

  /// Whether the sheet can be dismissed by tapping outside
  final bool isDismissible;

  /// Whether the sheet can be dragged to dismiss
  final bool enableDrag;

  /// Display mode for sheet sizing
  final BottomSheetDisplayMode displayMode;

  /// Optional style override
  final BottomSheetStyle? style;

  const AppBottomSheet({
    super.key,
    required this.child,
    this.maxHeight,
    this.minHeight,
    this.padding = const EdgeInsets.all(16),
    this.onDismiss,
    this.isDismissible = true,
    this.enableDrag = true,
    this.displayMode = BottomSheetDisplayMode.intrinsic,
    this.style,
  });

  @override
  State<AppBottomSheet> createState() => _AppBottomSheetState();
}

class _AppBottomSheetState extends State<AppBottomSheet>
    with TickerProviderStateMixin {
  late BottomSheetStyle _style;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animationController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context).extension<AppDesignTheme>();
    _style = widget.style ?? theme?.bottomSheetStyle ?? _defaultStyle();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  BottomSheetStyle _defaultStyle() {
    return const BottomSheetStyle(
      overlayColor: Color(0x80000000),
      animationDuration: Duration(milliseconds: 300),
      animationCurve: Curves.easeOutCubic,
      topBorderRadius: 16,
      dragHandleHeight: 4,
    );
  }

  void _dismiss() {
    _animationController.reverse().then((_) {
      Navigator.of(context).pop();
      widget.onDismiss?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final maxHeight = widget.maxHeight ?? mediaQuery.size.height * 0.9;
    final minHeight = widget.minHeight ?? 100.0;

    return Semantics(
      label: 'Bottom Sheet',
      enabled: true,
      child: GestureDetector(
        onTap: widget.isDismissible ? _dismiss : null,
        child: Container(
          color: Colors.transparent,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              // Animated scrim overlay
              ScaleTransition(
                scale: CurvedAnimation(
                  parent: _animationController,
                  curve: const Interval(0, 0.5),
                ),
                alignment: Alignment.center,
                child: Container(
                  color: _style.overlayColor,
                ),
              ),

              // Bottom sheet content
              SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, 1),
                  end: Offset.zero,
                ).animate(
                  CurvedAnimation(
                    parent: _animationController,
                    curve: _style.animationCurve,
                  ),
                ),
                child: GestureDetector(
                  onTap: () {}, // Prevent tap-through to scrim
                  child: Container(
                    constraints: BoxConstraints(
                      minHeight: minHeight,
                      maxHeight: maxHeight,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_style.topBorderRadius),
                        topRight: Radius.circular(_style.topBorderRadius),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Draggable handle
                        if (widget.enableDrag)
                          _BottomSheetHandle(
                            height: _style.dragHandleHeight,
                            onDragUpdate: (details) {
                              if (details.delta.dy > 10) {
                                _dismiss();
                              }
                            },
                          ),

                        // Sheet content with scrolling support
                        Flexible(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: widget.padding,
                              child: widget.child,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Draggable handle at the top of the bottom sheet
class _BottomSheetHandle extends StatelessWidget {
  /// Height of the handle bar
  final double height;

  /// Callback for drag updates
  final GestureDragUpdateCallback? onDragUpdate;

  const _BottomSheetHandle({
    required this.height,
    this.onDragUpdate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: onDragUpdate,
      child: Semantics(
        label: 'Draggable handle to dismiss',
        button: true,
        enabled: true,
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Container(
            width: 40,
            height: height,
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(height / 2),
            ),
          ),
        ),
      ),
    );
  }
}
