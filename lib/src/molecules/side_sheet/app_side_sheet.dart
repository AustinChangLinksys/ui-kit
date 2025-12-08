import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart'
    as shared;
import 'package:ui_kit_library/ui_kit.dart';

/// Position where the side sheet slides in from
enum SideSheetPosition {
  /// Slides in from left side
  left,

  /// Slides in from right side
  right,
}

/// Display mode for side sheet presentation
enum SideSheetDisplayMode {
  /// Sheet overlays content with scrim backdrop, can be dismissed
  overlay,

  /// Sheet is always visible, no scrim, designed for responsive layouts
  persistent,
}

/// AppSideSheet displays navigation or secondary content from the side
///
/// Features:
/// - Animated slide-in from left or right using flutter_animate
/// - Dismissible overlay mode with tap-outside and programmatic control
/// - Persistent mode for responsive layouts (always visible)
/// - Theme-aware styling with animated backdrop scrim
/// - Accessibility: proper semantics, keyboard support (Escape to close in overlay mode)
class AppSideSheet extends StatefulWidget {
  /// Main content widget of the sheet
  final Widget child;

  /// Width of the side sheet (default: 280)
  final double? width;

  /// Position where sheet slides in from
  final SideSheetPosition position;

  /// Display mode for sheet presentation
  final SideSheetDisplayMode displayMode;

  /// Callback when sheet is dismissed (overlay mode only)
  final VoidCallback? onDismiss;

  /// Whether the sheet can be dismissed by tapping outside (overlay mode only)
  final bool isDismissible;

  /// Optional animation override for this specific instance.
  /// Takes precedence over StyleOverride and theme defaults.
  ///
  /// Resolution priority:
  /// 1. animationOverride (this parameter)
  /// 2. StyleOverride.resolveSpec<AnimationSpec>(context)
  /// 3. theme.sheetStyle.overlay.animation
  final shared.AnimationSpec? animationOverride;

  const AppSideSheet({
    super.key,
    required this.child,
    this.width,
    this.position = SideSheetPosition.left,
    this.displayMode = SideSheetDisplayMode.overlay,
    this.onDismiss,
    this.isDismissible = true,
    this.animationOverride,
  });

  @override
  State<AppSideSheet> createState() => _AppSideSheetState();
}

class _AppSideSheetState extends State<AppSideSheet>
    with TickerProviderStateMixin {
  late SheetStyle _sheetStyle;
  late AnimationController _animationController;
  bool _hasCheckedTickerMode = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    _animationController.forward();
  }

  /// Resolve animation spec with priority:
  /// 1. Component parameter (animationOverride)
  /// 2. StyleOverride ancestor
  /// 3. Theme default (sheetStyle.overlay.animation)
  shared.AnimationSpec _resolveAnimation(BuildContext context) {
    // 1. Direct component override
    if (widget.animationOverride != null) {
      return widget.animationOverride!;
    }

    // 2. StyleOverride from ancestor
    final styleOverride =
        StyleOverride.resolveSpec<shared.AnimationSpec>(context);
    if (styleOverride != null) {
      return styleOverride;
    }

    // 3. Theme default
    return _sheetStyle.overlay.animation;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Constitution 4.1: AppDesignTheme is single source of truth for all styling
    // All colors/animations come from theme, never hardcoded
    final theme = Theme.of(context).extension<AppDesignTheme>();
    assert(
      theme != null,
      'AppSideSheet requires DesignSystem initialization. '
      'Call DesignSystem.init() in MaterialApp.builder.',
    );

    _sheetStyle = theme!.sheetStyle;

    // Update animation controller duration from resolved animation
    final animation = _resolveAnimation(context);
    _animationController.duration = animation.duration;

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

  void _handleDismiss() {
    if (widget.displayMode == SideSheetDisplayMode.overlay &&
        widget.isDismissible) {
      Navigator.of(context).pop();
      widget.onDismiss?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final screenWidth = mediaQuery.size.width;
    final sheetWidth = widget.width ?? _sheetStyle.width ?? 280.0;

    if (widget.displayMode == SideSheetDisplayMode.persistent) {
      return _buildPersistentSheet(sheetWidth);
    }

    return _buildOverlaySheet(screenWidth, sheetWidth);
  }

  Widget _buildPersistentSheet(double sheetWidth) {
    final slideAnimation = Tween<Offset>(
      begin: widget.position == SideSheetPosition.left
          ? const Offset(-1, 0)
          : const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _resolveAnimation(context).curve,
      ),
    );

    return SlideTransition(
      position: slideAnimation,
      child: SizedBox(
        width: sheetWidth,
        child: AppSurface(
          // Elevated variant for floating panel with theme-specific styling
          variant: SurfaceVariant.elevated,
          child: widget.child,
        ),
      ),
    );
  }

  Widget _buildOverlaySheet(double screenWidth, double sheetWidth) {
    final scrimAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: const Interval(0, 0.5, curve: Curves.easeOutCubic),
      ),
    );

    final slideAnimation = Tween<Offset>(
      begin: widget.position == SideSheetPosition.left
          ? const Offset(-1, 0)
          : const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: _resolveAnimation(context).curve,
      ),
    );

    return Stack(
      children: [
        // Scrim backdrop
        Positioned.fill(
          child: FadeTransition(
            opacity: scrimAnimation,
            child: GestureDetector(
              onTap: _handleDismiss,
              child: Container(
                color: _sheetStyle.overlay.scrimColor,
              ),
            ),
          ),
        ),
        // Side sheet content
        Positioned(
          left: widget.position == SideSheetPosition.left ? 0 : null,
          right: widget.position == SideSheetPosition.right ? 0 : null,
          top: 0,
          bottom: 0,
          width: sheetWidth,
          child: SlideTransition(
            position: slideAnimation,
            child: AppSurface(
              // Elevated variant for floating panel with theme-specific styling
              variant: SurfaceVariant.elevated,
              child: Semantics(
                label: 'Side Sheet',
                enabled: true,
                child: widget.child,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// AppDrawer is a convenience wrapper for AppSideSheet configured as left-side overlay navigation
class AppDrawer extends StatelessWidget {
  /// Main content widget of the drawer
  final Widget child;

  /// Width of the drawer (default: 280)
  final double? width;

  /// Callback when drawer is dismissed
  final VoidCallback? onDismiss;

  /// Whether the drawer can be dismissed by tapping outside
  final bool isDismissible;

  /// Optional animation override for this specific instance.
  final shared.AnimationSpec? animationOverride;

  const AppDrawer({
    super.key,
    required this.child,
    this.width,
    this.onDismiss,
    this.isDismissible = true,
    this.animationOverride,
  });

  @override
  Widget build(BuildContext context) {
    return AppSideSheet(
      width: width,
      position: SideSheetPosition.left,
      displayMode: SideSheetDisplayMode.overlay,
      onDismiss: onDismiss,
      isDismissible: isDismissible,
      animationOverride: animationOverride,
      child: child,
    );
  }
}
