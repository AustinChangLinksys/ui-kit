import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/app_menu_style.dart';
import 'package:ui_kit_library/src/molecules/menu/app_popup_menu_item.dart';

/// A theme-aware popup menu that automatically adapts visual appearance
/// based on the active design style (Flat, Glass, Pixel).
///
/// Uses an overlay to display menu items when the trigger is tapped.
class AppPopupMenu<T> extends StatefulWidget {
  const AppPopupMenu({
    super.key,
    required this.items,
    required this.onSelected,
    this.child,
    this.icon,
    this.iconSize = 24.0,
    this.offset = Offset.zero,
    this.menuOffset = 4.0,
    this.enabled = true,
    this.tooltip,
    this.elevation,
    this.semanticLabel,
    this.constraints,
  });

  /// List of menu items to display.
  final List<AppPopupMenuItem<T>> items;

  /// Callback when a menu item is selected.
  final ValueChanged<T> onSelected;

  /// Custom trigger widget. If not provided, displays an icon button.
  final Widget? child;

  /// Icon to display when [child] is not provided.
  final IconData? icon;

  /// Size of the default icon trigger.
  final double iconSize;

  /// Offset from the trigger button position (horizontal, vertical).
  final Offset offset;

  /// Vertical gap between trigger and menu. Defaults to 4.0.
  final double menuOffset;

  /// Whether the menu is enabled.
  final bool enabled;

  /// Tooltip text for the trigger button.
  final String? tooltip;

  /// Shadow elevation for the menu.
  final double? elevation;

  /// Semantic label for accessibility.
  final String? semanticLabel;

  /// Optional constraints for the menu.
  final BoxConstraints? constraints;

  @override
  State<AppPopupMenu<T>> createState() => _AppPopupMenuState<T>();
}

class _AppPopupMenuState<T> extends State<AppPopupMenu<T>> {
  final GlobalKey _triggerKey = GlobalKey();

  void _showMenu() {
    if (!widget.enabled || widget.items.isEmpty) return;

    final RenderBox? renderBox =
        _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset position = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    final screenSize = MediaQuery.of(context).size;

    final theme = Theme.of(context).extension<AppDesignTheme>();
    final menuStyle = theme?.menuStyle;

    // Calculate menu position - anchor to bottom-left of trigger with small gap
    final menuTop = position.dy + size.height + widget.menuOffset + widget.offset.dy;
    final menuLeft = position.dx + widget.offset.dx;

    showMenu<T>(
      context: context,
      position: RelativeRect.fromLTRB(
        menuLeft,
        menuTop,
        screenSize.width - menuLeft,
        screenSize.height - menuTop,
      ),
      constraints: widget.constraints,
      items: widget.items.map((item) {
        return PopupMenuItem<T>(
          value: item.value,
          enabled: item.enabled,
          height: menuStyle?.itemHeight ?? 48.0,
          padding: EdgeInsets.zero,
          child: _MenuItemContent<T>(
            item: item,
            menuStyle: menuStyle,
          ),
        );
      }).toList(),
      elevation: widget.elevation ?? 8,
      color: menuStyle?.containerStyle.backgroundColor,
      surfaceTintColor: Colors.transparent,
      shadowColor: menuStyle?.containerStyle.shadows.firstOrNull?.color ?? Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          menuStyle?.containerStyle.borderRadius ?? 8.0,
        ),
        side: BorderSide(
          color: menuStyle?.containerStyle.borderColor ?? Colors.transparent,
          width: menuStyle?.containerStyle.borderWidth ?? 0,
        ),
      ),
      semanticLabel: widget.semanticLabel,
    ).then((value) {
      if (value != null) {
        widget.onSelected(value);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();

    Widget trigger;
    if (widget.child != null) {
      trigger = GestureDetector(
        key: _triggerKey,
        onTap: widget.enabled ? _showMenu : null,
        child: widget.child,
      );
    } else {
      final iconColor = theme?.menuStyle.itemStyle.contentColor ??
          Theme.of(context).iconTheme.color;

      trigger = IconButton(
        key: _triggerKey,
        icon: Icon(
          widget.icon ?? Icons.more_vert,
          size: widget.iconSize,
          color: widget.enabled
              ? iconColor
              : iconColor?.withValues(alpha: 0.38),
        ),
        onPressed: widget.enabled ? _showMenu : null,
        tooltip: widget.tooltip ?? MaterialLocalizations.of(context).showMenuTooltip,
      );
    }

    return Semantics(
      button: true,
      label: widget.semanticLabel ?? 'Menu',
      enabled: widget.enabled,
      child: trigger,
    );
  }
}

/// Internal widget for rendering a single menu item.
class _MenuItemContent<T> extends StatefulWidget {
  const _MenuItemContent({
    required this.item,
    required this.menuStyle,
  });

  final AppPopupMenuItem<T> item;
  final AppMenuStyle? menuStyle;

  @override
  State<_MenuItemContent<T>> createState() => _MenuItemContentState<T>();
}

class _MenuItemContentState<T> extends State<_MenuItemContent<T>> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final menuStyle = widget.menuStyle ?? theme?.menuStyle;
    final item = widget.item;

    // Resolve the appropriate style based on state
    final baseStyle = item.isDestructive
        ? menuStyle?.destructiveItemStyle
        : menuStyle?.itemStyle;

    final effectiveStyle = (_isHovered && item.enabled)
        ? menuStyle?.itemHoverStyle
        : baseStyle;

    final contentColor = item.isDestructive
        ? menuStyle?.destructiveItemStyle.contentColor
        : effectiveStyle?.contentColor;

    final disabledColor = contentColor?.withValues(alpha: 0.38);
    final effectiveContentColor = item.enabled ? contentColor : disabledColor;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: theme?.animation.duration ?? const Duration(milliseconds: 200),
        curve: theme?.animation.curve ?? Curves.easeInOut,
        height: menuStyle?.itemHeight ?? 48.0,
        padding: EdgeInsets.symmetric(
          horizontal: menuStyle?.itemHorizontalPadding ?? 16.0,
        ),
        decoration: BoxDecoration(
          color: effectiveStyle?.backgroundColor ?? Colors.transparent,
          borderRadius: BorderRadius.circular(
            effectiveStyle?.borderRadius ?? 0,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (item.icon != null) ...[
              Icon(
                item.icon,
                size: menuStyle?.iconSize ?? 24.0,
                color: effectiveContentColor,
              ),
              SizedBox(width: menuStyle?.iconLabelSpacing ?? 12.0),
            ],
            Flexible(
              child: Text(
                item.label,
                style: TextStyle(
                  color: effectiveContentColor,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shows an AppPopupMenu as a modal popup.
///
/// This is an alternative to using [AppPopupMenu] widget directly,
/// allowing programmatic display of the menu at a specific position.
Future<T?> showAppPopupMenu<T>({
  required BuildContext context,
  required List<AppPopupMenuItem<T>> items,
  required Offset position,
  String? semanticLabel,
}) {
  final theme = Theme.of(context).extension<AppDesignTheme>();
  final menuStyle = theme?.menuStyle;

  return showMenu<T>(
    context: context,
    position: RelativeRect.fromLTRB(
      position.dx,
      position.dy,
      position.dx,
      position.dy,
    ),
    items: items.map((item) {
      return PopupMenuItem<T>(
        value: item.value,
        enabled: item.enabled,
        height: menuStyle?.itemHeight ?? 48.0,
        padding: EdgeInsets.zero,
        child: _MenuItemContent<T>(
          item: item,
          menuStyle: menuStyle,
        ),
      );
    }).toList(),
    elevation: 8,
    color: menuStyle?.containerStyle.backgroundColor,
    surfaceTintColor: Colors.transparent,
    shadowColor: menuStyle?.containerStyle.shadows.firstOrNull?.color ?? Colors.black26,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(
        menuStyle?.containerStyle.borderRadius ?? 8.0,
      ),
      side: BorderSide(
        color: menuStyle?.containerStyle.borderColor ?? Colors.transparent,
        width: menuStyle?.containerStyle.borderWidth ?? 0,
      ),
    ),
    semanticLabel: semanticLabel,
  );
}

/// A static preview widget for displaying menu items without overlay.
/// Useful for golden tests and component showcases.
class AppPopupMenuPreview<T> extends StatelessWidget {
  const AppPopupMenuPreview({
    super.key,
    required this.items,
    this.width,
    this.highlightedIndex,
  });

  /// List of menu items to display.
  final List<AppPopupMenuItem<T>> items;

  /// Optional fixed width for the menu.
  final double? width;

  /// Index of the item to show as highlighted/hovered (for cascade preview).
  final int? highlightedIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final menuStyle = theme?.menuStyle;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: menuStyle?.containerStyle.backgroundColor,
        borderRadius: BorderRadius.circular(
          menuStyle?.containerStyle.borderRadius ?? 8.0,
        ),
        border: Border.all(
          color: menuStyle?.containerStyle.borderColor ?? Colors.transparent,
          width: menuStyle?.containerStyle.borderWidth ?? 0,
        ),
        boxShadow: menuStyle?.containerStyle.shadows.isNotEmpty == true
            ? menuStyle!.containerStyle.shadows
            : const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          menuStyle?.containerStyle.borderRadius ?? 8.0,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: items.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return _MenuItemContentStatic<T>(
              item: item,
              menuStyle: menuStyle,
              isHighlighted: highlightedIndex == index,
            );
          }).toList(),
        ),
      ),
    );
  }
}

/// Static version of menu item content (no hover state, uses isHighlighted).
class _MenuItemContentStatic<T> extends StatelessWidget {
  const _MenuItemContentStatic({
    required this.item,
    required this.menuStyle,
    this.isHighlighted = false,
  });

  final AppPopupMenuItem<T> item;
  final AppMenuStyle? menuStyle;
  final bool isHighlighted;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final effectiveMenuStyle = menuStyle ?? theme?.menuStyle;

    // Resolve the appropriate style based on state
    final baseStyle = item.isDestructive
        ? effectiveMenuStyle?.destructiveItemStyle
        : effectiveMenuStyle?.itemStyle;

    final effectiveStyle = (isHighlighted && item.enabled)
        ? effectiveMenuStyle?.itemHoverStyle
        : baseStyle;

    final contentColor = item.isDestructive
        ? effectiveMenuStyle?.destructiveItemStyle.contentColor
        : effectiveStyle?.contentColor;

    final disabledColor = contentColor?.withValues(alpha: 0.38);
    final effectiveContentColor = item.enabled ? contentColor : disabledColor;

    return Container(
      height: effectiveMenuStyle?.itemHeight ?? 48.0,
      padding: EdgeInsets.symmetric(
        horizontal: effectiveMenuStyle?.itemHorizontalPadding ?? 16.0,
      ),
      decoration: BoxDecoration(
        color: effectiveStyle?.backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(
          effectiveStyle?.borderRadius ?? 0,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (item.icon != null) ...[
            Icon(
              item.icon,
              size: effectiveMenuStyle?.iconSize ?? 24.0,
              color: effectiveContentColor,
            ),
            SizedBox(width: effectiveMenuStyle?.iconLabelSpacing ?? 12.0),
          ],
          Flexible(
            child: Text(
              item.label,
              style: TextStyle(
                color: effectiveContentColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (item.hasSubmenu) ...[
            const Spacer(),
            Icon(
              Icons.chevron_right,
              size: 20,
              color: effectiveContentColor,
            ),
          ],
        ],
      ),
    );
  }
}

/// A cascading menu preview showing multiple levels of nested menus.
/// Useful for golden tests demonstrating submenu hierarchies.
class CascadingMenuPreview extends StatelessWidget {
  const CascadingMenuPreview({
    super.key,
    required this.level1Items,
    required this.level2Items,
    required this.level3Items,
    this.menuWidth = 160.0,
    this.cascadeOffset = 8.0,
    this.level1HighlightIndex = 0,
    this.level2HighlightIndex = 0,
  });

  /// Items for the first level menu.
  final List<AppPopupMenuItem<String>> level1Items;

  /// Items for the second level menu.
  final List<AppPopupMenuItem<String>> level2Items;

  /// Items for the third level menu.
  final List<AppPopupMenuItem<String>> level3Items;

  /// Width of each menu panel.
  final double menuWidth;

  /// Horizontal offset between cascade levels.
  final double cascadeOffset;

  /// Index of highlighted item in level 1.
  final int level1HighlightIndex;

  /// Index of highlighted item in level 2.
  final int level2HighlightIndex;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    final menuStyle = theme?.menuStyle;
    final itemHeight = menuStyle?.itemHeight ?? 48.0;

    // Calculate vertical offset for each level based on highlighted index
    final level2VerticalOffset = level1HighlightIndex * itemHeight;
    final level3VerticalOffset =
        level2VerticalOffset + (level2HighlightIndex * itemHeight);

    return SizedBox(
      width: (menuWidth * 3) + (cascadeOffset * 2) + 20,
      child: Stack(
        children: [
          // Level 1 menu
          Positioned(
            left: 0,
            top: 0,
            child: AppPopupMenuPreview<String>(
              width: menuWidth,
              items: level1Items,
              highlightedIndex: level1HighlightIndex,
            ),
          ),
          // Level 2 menu
          Positioned(
            left: menuWidth + cascadeOffset,
            top: level2VerticalOffset,
            child: AppPopupMenuPreview<String>(
              width: menuWidth,
              items: level2Items,
              highlightedIndex: level2HighlightIndex,
            ),
          ),
          // Level 3 menu
          Positioned(
            left: (menuWidth * 2) + (cascadeOffset * 2),
            top: level3VerticalOffset,
            child: AppPopupMenuPreview<String>(
              width: menuWidth,
              items: level3Items,
            ),
          ),
        ],
      ),
    );
  }
}
