import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';

/// A theme-aware SliverAppBar that automatically adapts visual appearance
/// based on the active design style (Flat, Glass, Pixel).
///
/// Supports pinned, floating, and snap behaviors.
class AppUnifiedSliverBar extends StatelessWidget {
  const AppUnifiedSliverBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.actions,
    this.pinned = true,
    this.floating = false,
    this.snap = false,
    this.expandedHeight,
    this.flexibleSpace,
    this.leading,
    this.automaticallyImplyLeading = true,
  });

  /// Page title text.
  final String title;

  /// Custom title widget.
  final Widget? titleWidget;

  /// Right-aligned action widgets.
  final List<Widget>? actions;

  /// Keep visible when scrolled.
  final bool pinned;

  /// Appear on scroll up.
  final bool floating;

  /// Snap to full height.
  final bool snap;

  /// Maximum height when expanded.
  final double? expandedHeight;

  /// Background content (hero image, etc.).
  final Widget? flexibleSpace;

  /// Leading widget.
  final Widget? leading;

  /// Auto back button.
  final bool automaticallyImplyLeading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();

    // Graceful fallback if theme is not available
    if (theme == null) {
      return SliverAppBar(
        title: titleWidget ?? Text(title),
        actions: actions,
        pinned: pinned,
        floating: floating,
        snap: snap,
        expandedHeight: expandedHeight,
        flexibleSpace: flexibleSpace != null
            ? FlexibleSpaceBar(background: flexibleSpace)
            : null,
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
      );
    }

    final appBarStyle = theme.appBarStyle;
    final effectiveExpandedHeight =
        expandedHeight ?? appBarStyle.expandedHeight;

    // Build title widget with proper styling
    final effectiveTitle = titleWidget ??
        Text(
          title,
          style: TextStyle(
            color: appBarStyle.foregroundColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        );

    // Build actions with proper styling
    final effectiveActions = actions?.map((action) {
      return IconTheme(
        data: IconThemeData(color: appBarStyle.foregroundColor),
        child: action,
      );
    }).toList();

    // Build flexible space with style-aware overlay
    Widget? effectiveFlexibleSpace;
    if (flexibleSpace != null) {
      effectiveFlexibleSpace = _buildFlexibleSpace(
        context,
        theme,
        flexibleSpace!,
        effectiveExpandedHeight,
      );
    }

    return SliverAppBar(
      title: effectiveTitle,
      actions: effectiveActions,
      pinned: pinned,
      floating: floating,
      snap: snap,
      expandedHeight: effectiveExpandedHeight,
      collapsedHeight: appBarStyle.collapsedHeight,
      backgroundColor: appBarStyle.backgroundColor,
      foregroundColor: appBarStyle.foregroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: effectiveFlexibleSpace,
      leading: leading,
      automaticallyImplyLeading: automaticallyImplyLeading,
    );
  }

  Widget _buildFlexibleSpace(
    BuildContext context,
    AppDesignTheme theme,
    Widget background,
    double expandedHeight,
  ) {
    final appBarStyle = theme.appBarStyle;
    final blurStrength = appBarStyle.flexibleSpaceBlur;

    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate collapse progress (0 = expanded, 1 = collapsed)
        final settings =
            context.dependOnInheritedWidgetOfExactType<FlexibleSpaceBarSettings>();
        final currentExtent = settings?.currentExtent ?? expandedHeight;
        final minExtent = settings?.minExtent ?? appBarStyle.collapsedHeight;
        final maxExtent = settings?.maxExtent ?? expandedHeight;

        final progress = maxExtent > minExtent
            ? ((maxExtent - currentExtent) / (maxExtent - minExtent)).clamp(0.0, 1.0)
            : 0.0;

        return Stack(
          fit: StackFit.expand,
          children: [
            // Background image
            Positioned.fill(
              child: background,
            ),

            // Glass mode: frosted overlay when expanded
            if (blurStrength > 0)
              Positioned.fill(
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: blurStrength * (1 - progress * 0.5),
                      sigmaY: blurStrength * (1 - progress * 0.5),
                    ),
                    child: Container(
                      color: appBarStyle.backgroundColor
                          .withValues(alpha: 0.3 + progress * 0.4),
                    ),
                  ),
                ),
              ),

            // Non-glass modes: gradient overlay for text readability
            if (blurStrength == 0)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        appBarStyle.backgroundColor
                            .withValues(alpha: 0.0),
                        appBarStyle.backgroundColor
                            .withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
