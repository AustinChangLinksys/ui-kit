import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A themed expandable floating action button that reveals satellite actions.
///
/// When tapped, the FAB expands to show a list of child action widgets.
/// The expansion animation and styling are driven by the active theme.
///
/// Uses [flutter_portal] to keep expanded content in the widget tree,
/// enabling proper golden testing and theme context propagation.
class AppExpandableFab extends StatefulWidget {
  /// The child action widgets to display when expanded.
  final List<Widget> children;

  /// Custom icon for the closed state. Defaults to [Icons.add].
  final Widget? icon;

  /// Custom icon for the open state. Defaults to [Icons.close].
  final Widget? activeIcon;

  /// Whether the FAB should start in the open state.
  final bool initiallyOpen;

  /// Callback when the FAB is toggled.
  final VoidCallback? onToggle;

  const AppExpandableFab({
    super.key,
    required this.children,
    this.icon,
    this.activeIcon,
    this.initiallyOpen = false,
    this.onToggle,
  });

  @override
  State<AppExpandableFab> createState() => _AppExpandableFabState();
}

class _AppExpandableFabState extends State<AppExpandableFab>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  late Animation<double> _rotateAnimation;
  bool _isOpen = false;

  @override
  void initState() {
    super.initState();
    _isOpen = widget.initiallyOpen;
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );
    _rotateAnimation = Tween<double>(begin: 0.0, end: 0.25).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    if (_isOpen) {
      _controller.value = 1.0;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggle() {
    AppFeedback.onInteraction();
    setState(() {
      _isOpen = !_isOpen;
      if (_isOpen) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onToggle?.call();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppDesignTheme.of(context);
    final style = theme.expandableFabStyle;

    return PortalTarget(
      visible: _isOpen,
      closeDuration: const Duration(milliseconds: 250),
      anchor: const Aligned(
        follower: Alignment.bottomRight,
        target: Alignment.topRight,
        offset: Offset(0, -16),
      ),
      portalFollower: _buildExpandedContent(style, theme),
      child: _buildMainFab(theme, style),
    );
  }

  Widget _buildMainFab(AppDesignTheme theme, ExpandableFabStyle style) {
    return FloatingActionButton(
      onPressed: _toggle,
      backgroundColor: theme.surfaceHighlight.backgroundColor,
      foregroundColor: theme.surfaceHighlight.contentColor,
      shape: style.shape == BoxShape.circle
          ? const CircleBorder()
          : const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: RotationTransition(
        turns: _rotateAnimation,
        child: _isOpen
            ? (widget.activeIcon ?? const Icon(Icons.close))
            : (widget.icon ?? const Icon(Icons.add)),
      ),
    );
  }

  Widget _buildExpandedContent(ExpandableFabStyle style, AppDesignTheme theme) {
    return AnimatedBuilder(
      animation: _expandAnimation,
      builder: (context, child) {
        return Opacity(
          opacity: _expandAnimation.value,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              for (int i = 0; i < widget.children.length; i++) ...[
                ScaleTransition(
                  scale: _expandAnimation,
                  child: _wrapChildAction(widget.children[i], style, theme),
                ),
                if (i < widget.children.length - 1)
                  SizedBox(height: style.distance),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _wrapChildAction(
      Widget child, ExpandableFabStyle style, AppDesignTheme theme) {
    // If child is already a FAB, use it directly
    if (child is FloatingActionButton) {
      return child;
    }

    // Wrap other widgets in a mini FAB style container
    return FloatingActionButton(
      mini: true,
      onPressed: () {
        _toggle(); // Close after selection
      },
      backgroundColor: theme.surfaceSecondary.backgroundColor,
      foregroundColor: theme.surfaceSecondary.contentColor,
      shape: style.shape == BoxShape.circle
          ? const CircleBorder()
          : const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: child,
    );
  }
}

/// A wrapper widget that provides the Portal scope required for AppExpandableFab.
///
/// This should wrap the area where AppExpandableFab will be used if Portal
/// is not already provided higher in the widget tree.
class AppExpandableFabScope extends StatelessWidget {
  final Widget child;

  const AppExpandableFabScope({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Portal(child: child);
  }
}
