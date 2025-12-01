import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppListTile extends StatelessWidget {
  const AppListTile({
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.selected = false,
    super.key,
  });

  final Widget title;
  final Widget? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final backgroundColor =
        selected ? theme.surfaceHighlight.backgroundColor : Colors.transparent;

    return AppSurface(
      style: theme.surfaceBase.copyWith(
        backgroundColor: backgroundColor,
        borderWidth: 0,
        borderRadius: 8.0,
        shadows: [],
        contentColor: selected
            ? theme.surfaceHighlight.contentColor
            : theme.surfaceBase.contentColor,
      ),
      interactive: true,
      onTap: onTap,
      padding: EdgeInsets.symmetric(
        horizontal: theme.spacingFactor * 16,
        vertical: theme.spacingFactor * 12,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            IconTheme(
              data: IconThemeData(
                size: 24,
                color: selected
                    ? theme.surfaceHighlight.contentColor
                    : theme.surfaceBase.contentColor,
              ),
              child: leading!,
            ),
            SizedBox(width: theme.spacingFactor * 16),
          ],
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: selected
                        ? theme.surfaceHighlight.contentColor
                        : theme.surfaceBase.contentColor,
                  ),
                  child: title,
                ),
                if (subtitle != null) ...[
                  SizedBox(height: theme.spacingFactor * 4),
                  DefaultTextStyle(
                    style: Theme.of(context).textTheme.labelMedium!.copyWith(
                      color: (selected
                              ? theme.surfaceHighlight.contentColor
                              : theme.surfaceBase.contentColor)
                          .withValues(alpha: 0.7),
                    ),
                    child: subtitle!,
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) ...[
            SizedBox(width: theme.spacingFactor * 16),
            IconTheme(
              data: IconThemeData(
                size: 20,
                color: (selected
                        ? theme.surfaceHighlight.contentColor
                        : theme.surfaceBase.contentColor)
                    .withValues(alpha: 0.5),
              ),
              child: trailing!,
            ),
          ],
        ],
      ),
    );
  }
}
