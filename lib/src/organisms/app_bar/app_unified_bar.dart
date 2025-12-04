import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';

/// A theme-aware AppBar that automatically adapts visual appearance
/// based on the active design style (Flat, Glass, Pixel).
///
/// Implements [PreferredSizeWidget] for use in [Scaffold.appBar].
class AppUnifiedBar extends StatelessWidget implements PreferredSizeWidget {
  const AppUnifiedBar({
    super.key,
    required this.title,
    this.titleWidget,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.actions,
    this.bottom,
    this.elevation,
    this.centerTitle = true,
  });

  /// Page title text.
  final String title;

  /// Custom title widget (overrides [title]).
  final Widget? titleWidget;

  /// Leading widget (back button if auto-implied).
  final Widget? leading;

  /// Show back button when Navigator can pop.
  final bool automaticallyImplyLeading;

  /// Right-aligned action widgets.
  final List<Widget>? actions;

  /// Bottom widget (TabBar, etc.).
  final PreferredSizeWidget? bottom;

  /// Override default elevation.
  final double? elevation;

  /// Center the title.
  final bool centerTitle;

  @override
  Size get preferredSize {
    final bottomHeight = bottom?.preferredSize.height ?? 0.0;
    return Size.fromHeight(kToolbarHeight + bottomHeight);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();

    // Graceful fallback if theme is not available
    if (theme == null) {
      return AppBar(
        title: titleWidget ?? Text(title),
        leading: leading,
        automaticallyImplyLeading: automaticallyImplyLeading,
        actions: actions,
        bottom: bottom,
        elevation: elevation,
        centerTitle: centerTitle,
      );
    }

    final appBarStyle = theme.appBarStyle;
    final containerStyle = appBarStyle.containerStyle;

    // Build leading widget
    Widget? effectiveLeading = leading;
    if (effectiveLeading == null && automaticallyImplyLeading) {
      final ModalRoute<dynamic>? parentRoute = ModalRoute.of(context);
      final bool canPop = parentRoute?.canPop ?? false;
      if (canPop) {
        effectiveLeading = IconButton(
          icon: Icon(Icons.arrow_back, color: containerStyle.contentColor),
          onPressed: () => Navigator.maybePop(context),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        );
      }
    }

    // Build title widget
    final effectiveTitle = titleWidget ??
        Text(
          title,
          style: TextStyle(
            color: containerStyle.contentColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        );

    // Build actions with proper styling
    final effectiveActions = actions?.map((action) {
      return IconTheme(
        data: IconThemeData(color: containerStyle.contentColor),
        child: action,
      );
    }).toList();

    return Semantics(
      header: true,
      label: title,
      child: AppSurface(
        style: containerStyle.copyWith(
          borderRadius: 0, // AppBar should have no radius
        ),
        child: SafeArea(
          bottom: false,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: kToolbarHeight,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: NavigationToolbar(
                    leading: effectiveLeading,
                    middle: effectiveTitle,
                    trailing: effectiveActions != null
                        ? Row(
                            mainAxisSize: MainAxisSize.min,
                            children: effectiveActions,
                          )
                        : null,
                    centerMiddle: centerTitle,
                    middleSpacing: NavigationToolbar.kMiddleSpacing,
                  ),
                ),
                if (bottom != null) ...[
                  _buildDivider(context, appBarStyle.dividerStyle),
                  bottom!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDivider(BuildContext context, dividerStyle) {
    // Simple divider using the style
    return Container(
      height: dividerStyle.thickness,
      color: dividerStyle.color,
    );
  }
}
