import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Configuration for individual breadcrumb items
class BreadcrumbItem {
  /// Label displayed for this item
  final String label;

  /// Optional icon for the item
  final IconData? icon;

  /// Whether this item is tappable (navigation enabled)
  final bool enabled;

  const BreadcrumbItem({
    required this.label,
    this.icon,
    this.enabled = true,
  });
}

/// AppBreadcrumb displays hierarchical navigation path
///
/// Features:
/// - Theme-aware styling with customizable separators
/// - Tappable items for navigation (except current location)
/// - Accessibility: proper semantics for navigation landmarks
/// - Pixel theme: ASCII-style separators option
///
/// Usage:
/// ```dart
/// AppBreadcrumb(
///   items: [
///     BreadcrumbItem(label: 'Home'),
///     BreadcrumbItem(label: 'Products'),
///     BreadcrumbItem(label: 'Electronics'),
///   ],
///   onItemTap: (index) => navigateTo(index),
/// )
/// ```
class AppBreadcrumb extends StatefulWidget {
  /// List of breadcrumb items (path segments)
  final List<BreadcrumbItem> items;

  /// Callback when a breadcrumb item is tapped
  final ValueChanged<int>? onItemTap;

  /// Optional style override
  final BreadcrumbStyle? style;

  /// Whether to show icons (if provided)
  final bool showIcons;

  const AppBreadcrumb({
    super.key,
    required this.items,
    this.onItemTap,
    this.style,
    this.showIcons = true,
  });

  @override
  State<AppBreadcrumb> createState() => _AppBreadcrumbState();
}

class _AppBreadcrumbState extends State<AppBreadcrumb> {
  late BreadcrumbStyle _style;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Constitution 4.1: AppDesignTheme is single source of truth
    final theme = Theme.of(context).extension<AppDesignTheme>();
    assert(
      theme != null,
      'AppBreadcrumb requires DesignSystem initialization. '
      'Call DesignSystem.init() in MaterialApp.builder.',
    );
    _style = widget.style ?? theme!.breadcrumbStyle;
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Breadcrumb navigation',
      child: AppSurface(
        variant: SurfaceVariant.base,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: _buildBreadcrumbItems(),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildBreadcrumbItems() {
    final items = <Widget>[];

    for (int i = 0; i < widget.items.length; i++) {
      final item = widget.items[i];
      final isLast = i == widget.items.length - 1;
      final isClickable = !isLast && item.enabled;

      // Add breadcrumb item
      items.add(_buildItem(item, i, isLast, isClickable));

      // Add separator (except after last item)
      if (!isLast) {
        items.add(_buildSeparator());
      }
    }

    return items;
  }

  Widget _buildItem(
    BreadcrumbItem item,
    int index,
    bool isLast,
    bool isClickable,
  ) {
    final color = isLast ? _style.inactiveLinkColor : _style.activeLinkColor;

    return Semantics(
      label: isLast
          ? 'Current location: ${item.label}'
          : 'Navigate to ${item.label}',
      button: isClickable,
      enabled: isClickable,
      child: GestureDetector(
        onTap: isClickable ? () => widget.onItemTap?.call(index) : null,
        child: MouseRegion(
          cursor:
              isClickable ? SystemMouseCursors.click : SystemMouseCursors.basic,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.showIcons && item.icon != null) ...[
                  Icon(
                    item.icon,
                    size: 16,
                    color: color,
                  ),
                  const SizedBox(width: 4),
                ],
                Text(
                  item.label,
                  style: _style.itemTextStyle.copyWith(
                    color: color,
                    fontWeight: isLast ? FontWeight.bold : FontWeight.normal,
                    decoration:
                        isClickable ? TextDecoration.underline : TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSeparator() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Text(
        _style.separatorText,
        style: _style.itemTextStyle.copyWith(
          color: _style.separatorColor,
        ),
      ),
    );
  }
}
