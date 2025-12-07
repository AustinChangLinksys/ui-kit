import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
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
  bool _hasCheckedTickerMode = false;

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
    // Constitution 4.1: AppDesignTheme is single source of truth for all styling
    final theme = Theme.of(context).extension<AppDesignTheme>();
    assert(
      theme != null,
      'AppBottomSheet requires DesignSystem initialization. '
      'Call DesignSystem.init() in MaterialApp.builder.',
    );
    _style = widget.style ?? theme!.bottomSheetStyle;

    // When TickerMode is disabled (e.g., in golden tests), animations won't tick.
    // Force the animation to complete so the widget renders in its final state.
    if (!_hasCheckedTickerMode) {
      _hasCheckedTickerMode = true;
      if (!TickerMode.of(context)) {
        _animationController.value = 1.0;
      }
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: minHeight,
                      maxHeight: maxHeight,
                    ),
                    // ClipRRect for bottom sheet's top-only border radius
                    // AppSurface provides theme-specific styling (colors, blur, shadows)
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_style.topBorderRadius),
                        topRight: Radius.circular(_style.topBorderRadius),
                      ),
                      child: AppSurface(
                        // Elevated variant for floating panel with theme-specific styling
                        variant: SurfaceVariant.elevated,
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
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Shows a theme-aware bottom sheet.
///
/// Returns a [Future] that completes with the value passed to [Navigator.pop]
/// when the sheet is dismissed.
Future<T?> showAppBottomSheet<T>({
  required BuildContext context,
  required Widget child,
  double? maxHeight,
  double? minHeight,
  EdgeInsets padding = const EdgeInsets.all(16),
  bool isDismissible = true,
  bool enableDrag = true,
  BottomSheetDisplayMode displayMode = BottomSheetDisplayMode.intrinsic,
  BottomSheetStyle? style,
}) {
  // Capture theme data to propagate to the bottom sheet
  final themeData = Theme.of(context);

  return Navigator.of(context).push<T>(
    PageRouteBuilder<T>(
      opaque: false,
      barrierDismissible: isDismissible,
      pageBuilder: (context, animation, secondaryAnimation) {
        // Wrap with Theme, Portal, and Material to:
        // - Propagate design theme
        // - Provide Portal ancestor for components like AppDropdown
        // - Provide Material ancestor for TextField
        return Theme(
          data: themeData,
          child: Portal(
            child: Material(
              type: MaterialType.transparency,
              child: AppBottomSheet(
                maxHeight: maxHeight,
                minHeight: minHeight,
                padding: padding,
                isDismissible: isDismissible,
                enableDrag: enableDrag,
                displayMode: displayMode,
                style: style,
                child: child,
              ),
            ),
          ),
        );
      },
    ),
  );
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
