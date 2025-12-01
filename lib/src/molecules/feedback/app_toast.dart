import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ui_kit_library/ui_kit.dart';

enum ToastType {
  success,
  error,
  info,
  warning,
}

class AppToast extends StatelessWidget {
  const AppToast({
    required this.type,
    required this.title,
    this.description,
    this.onDismiss,
    super.key,
  });

  final ToastType type;
  final String title;
  final String? description;
  final VoidCallback? onDismiss;

  static void show(
    BuildContext context, {
    required ToastType type,
    required String title,
    String? description,
    Duration? duration,
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry entry;

    entry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 16,
        left: 16,
        right: 16,
        child: Material(
          color: Colors.transparent,
          child: AppToast(
            type: type,
            title: title,
            description: description,
            onDismiss: () {
              if (entry.mounted) entry.remove();
            },
          ),
        ),
      ),
    );

    overlay.insert(entry);

    final displayDuration =
        duration ?? AppTheme.of(context).toastStyle.displayDuration;
    Future.delayed(displayDuration, () {
      if (entry.mounted) entry.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final style = theme.toastStyle;
    final colorScheme = Theme.of(context).colorScheme;

    Color accentColor;
    IconData iconData;
    switch (type) {
      case ToastType.success:
        accentColor = Colors.green;
        iconData = Icons.check_circle;
        break;
      case ToastType.error:
        accentColor = colorScheme.error;
        iconData = Icons.error;
        break;
      case ToastType.info:
        accentColor = colorScheme.primary;
        iconData = Icons.info;
        break;
      case ToastType.warning:
        accentColor = Colors.orange;
        iconData = Icons.warning;
        break;
    }

    final radius =
        style.borderRadius.resolve(Directionality.of(context)).topLeft.x;

    return Padding(
      padding: style.margin,
      child: AppSurface(
        style: theme.surfaceElevated.copyWith(
          backgroundColor: style.backgroundColor,
          borderRadius: radius,
          contentColor:
              style.textStyle.color ?? theme.surfaceElevated.contentColor,
        ),
        padding: style.padding,
        child: Row(
          children: [
            Icon(iconData, color: accentColor),
            SizedBox(width: theme.spacingFactor * 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: style.textStyle.copyWith(fontWeight: FontWeight.bold),
                  ),
                  if (description != null) ...[
                    SizedBox(height: theme.spacingFactor * 4),
                    Text(
                      description!,
                      style: style.textStyle.copyWith(
                        fontSize: (style.textStyle.fontSize ?? 14) * 0.9,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            if (onDismiss != null)
              IconButton(
                icon: const Icon(Icons.close),
                color: style.textStyle.color?.withValues(alpha: 0.5) ??
                    theme.surfaceElevated.contentColor.withValues(alpha: 0.5),
                onPressed: onDismiss,
              ),
          ],
        ),
      ),
    ).animate().fade().slideY(
        begin: -0.5, end: 0, duration: 300.ms, curve: Curves.easeOut);
  }
}
