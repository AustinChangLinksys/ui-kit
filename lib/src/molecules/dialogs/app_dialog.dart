import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_portal/flutter_portal.dart';
import '../../atoms/surfaces/app_surface.dart';
import '../../foundation/theme/design_system/app_design_theme.dart';

/// A theme-aware dialog that automatically adapts visual appearance
/// based on the active design style (Flat, Glass, Pixel).
///
/// Supports backdrop blur for Glass mode and style-specific borders/shadows.
class AppDialog extends StatelessWidget {
  const AppDialog({
    super.key,
    this.title,
    this.titleText,
    required this.content,
    this.actions,
    this.semanticLabel,
    this.scrollable = false,
    this.icon,
  });

  /// Optional title widget for custom styling.
  final Widget? title;

  /// Simple title text (alternative to title widget).
  final String? titleText;

  /// Dialog content (required).
  final Widget content;

  /// Action buttons displayed at bottom.
  final List<Widget>? actions;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Whether content should be scrollable.
  final bool scrollable;

  /// Optional icon displayed above title.
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final dialogStyle = theme?.dialogStyle;

    // Build title widget
    Widget? titleWidget;
    if (title != null) {
      titleWidget = title;
    } else if (titleText != null) {
      titleWidget = Text(
        titleText!,
        style: TextStyle(
          color: dialogStyle?.containerStyle.contentColor ??
              Theme.of(context).textTheme.titleLarge?.color,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      );
    }

    // Build content with optional scrolling
    Widget contentWidget = content;
    if (scrollable) {
      contentWidget = SingleChildScrollView(child: content);
    }

    // Build action row
    Widget? actionsWidget;
    if (actions != null && actions!.isNotEmpty) {
      actionsWidget = Row(
        mainAxisAlignment:
            dialogStyle?.buttonAlignment ?? MainAxisAlignment.end,
        children: actions!.asMap().entries.map((entry) {
          final index = entry.key;
          final action = entry.value;
          return Padding(
            padding: EdgeInsets.only(
              left: index > 0 ? (dialogStyle?.buttonSpacing ?? 8.0) : 0,
            ),
            child: action,
          );
        }).toList(),
      );
    }

    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: dialogStyle?.maxWidth ?? 400.0,
        ),
        child: Semantics(
          label: semanticLabel ?? titleText,
          container: true,
          child: AppSurface(
            style: dialogStyle?.containerStyle,
            variant: SurfaceVariant.elevated,
            padding: dialogStyle?.padding ?? const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (icon != null) ...[
                  Icon(
                    icon,
                    size: 48,
                    color: dialogStyle?.containerStyle.contentColor,
                  ),
                  const SizedBox(height: 16),
                ],
                if (titleWidget != null) ...[
                  titleWidget,
                  const SizedBox(height: 16),
                ],
                contentWidget,
                if (actionsWidget != null) ...[
                  const SizedBox(height: 24),
                  actionsWidget,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Shows a theme-aware dialog with optional backdrop blur for Glass mode.
///
/// Returns a [Future] that completes with the value passed to [Navigator.pop]
/// when the dialog is dismissed.
Future<T?> showAppDialog<T>({
  required BuildContext context,
  required WidgetBuilder builder,
  bool barrierDismissible = true,
  String? barrierLabel,
  bool useRootNavigator = true,
  RouteSettings? routeSettings,
  Offset? anchorPoint,
}) {
  // Capture the full theme data to propagate to the dialog
  final themeData = Theme.of(context);
  final theme = themeData.extension<AppDesignTheme>();
  final dialogStyle = theme?.dialogStyle;
  final barrierBlur = dialogStyle?.barrierBlur ?? 0.0;
  final barrierColor = dialogStyle?.barrierColor ?? const Color(0x80000000);

  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: barrierLabel ?? MaterialLocalizations.of(context).modalBarrierDismissLabel,
    barrierColor: barrierBlur > 0 ? Colors.transparent : barrierColor,
    useRootNavigator: useRootNavigator,
    routeSettings: routeSettings,
    anchorPoint: anchorPoint,
    transitionDuration: theme?.animation.duration ?? const Duration(milliseconds: 200),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curvedAnimation = CurvedAnimation(
        parent: animation,
        curve: theme?.animation.curve ?? Curves.easeOut,
      );

      Widget content = FadeTransition(
        opacity: curvedAnimation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.9, end: 1.0).animate(curvedAnimation),
          child: child,
        ),
      );

      // Apply backdrop blur for Glass mode
      if (barrierBlur > 0) {
        content = Stack(
          children: [
            // Blurred backdrop
            Positioned.fill(
              child: GestureDetector(
                onTap: barrierDismissible
                    ? () => Navigator.of(context).pop()
                    : null,
                child: AnimatedBuilder(
                  animation: animation,
                  builder: (context, child) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: barrierBlur * animation.value,
                        sigmaY: barrierBlur * animation.value,
                      ),
                      child: Container(
                        color: barrierColor.withValues(
                          alpha: barrierColor.a * animation.value,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Dialog content
            content,
          ],
        );
      }

      return content;
    },
    pageBuilder: (dialogContext, animation, secondaryAnimation) {
      // Wrap with Theme, Portal, and Material to:
      // - Propagate design theme
      // - Provide Portal ancestor for components like AppDropdown
      // - Provide Material ancestor for TextField
      return Theme(
        data: themeData,
        child: Portal(
          child: Material(
            type: MaterialType.transparency,
            child: builder(dialogContext),
          ),
        ),
      );
    },
  );
}

/// Shows a confirmation dialog with title, message, and confirm/cancel buttons.
///
/// Returns `true` if confirmed, `false` if cancelled, `null` if dismissed.
Future<bool?> showAppConfirmDialog({
  required BuildContext context,
  required String title,
  required String message,
  String? confirmLabel,
  String? cancelLabel,
  bool isDestructive = false,
  IconData? icon,
}) {
  return showAppDialog<bool>(
    context: context,
    builder: (dialogContext) {
      // Get theme from dialogContext which now has the propagated theme
      final theme = Theme.of(dialogContext).extension<AppDesignTheme>();

      return AppDialog(
        icon: icon,
        titleText: title,
        content: Text(
          message,
          style: TextStyle(
            color: theme?.dialogStyle.containerStyle.contentColor,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelLabel ?? 'Cancel'),
          ),
          TextButton(
            style: isDestructive
                ? TextButton.styleFrom(
                    foregroundColor: Theme.of(dialogContext).colorScheme.error,
                  )
                : null,
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(confirmLabel ?? 'Confirm'),
          ),
        ],
      );
    },
  );
}
