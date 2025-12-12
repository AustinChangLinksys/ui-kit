import 'package:flutter/material.dart';
import '../../layout/models/page_menu_config.dart';
import '../../layout/layout_extensions.dart';
import '../../atoms/typography/app_text.dart';
import '../layout/app_list_tile.dart';

/// A responsive menu handler that adapts between desktop sidebar and mobile overlay
///
/// This component follows UI Kit constitutional compliance and adapts its display
/// based on screen size and configuration.
class ResponsiveMenuHandler extends StatelessWidget {
  /// Configuration for the menu system
  final PageMenuConfig config;

  /// The main content to display alongside the menu
  final Widget child;

  /// Creates a new ResponsiveMenuHandler instance
  const ResponsiveMenuHandler({
    super.key,
    required this.config,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDesktop = context.isDesktop;

    // If no menu items, just return the child
    if (!config.hasItems) {
      return child;
    }

    if (isDesktop) {
      return _buildDesktopLayout(context);
    } else {
      return _buildMobileLayout(context);
    }
  }

  /// Build desktop layout with sidebar
  Widget _buildDesktopLayout(BuildContext context) {
    final double menuWidth = config.largeMenu
        ? context.colWidth(4) // Larger sidebar for desktop
        : context.colWidth(3); // Standard sidebar width
    final double gutter = context.currentGutter;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Desktop Sidebar Menu
        SizedBox(
          width: menuWidth,
          child: _buildMenuContent(context, isDesktop: true),
        ),
        SizedBox(width: gutter),
        // Main Content
        Expanded(child: child),
      ],
    );
  }

  /// Build mobile layout - On mobile, we just return the child
  /// The AppPageView will handle mobile menu integration
  Widget _buildMobileLayout(BuildContext context) {
    // For mobile, the menu is handled by the AppPageView's drawer
    // We just return the child content
    return child;
  }

  /// Build the actual menu content
  Widget _buildMenuContent(BuildContext context, {required bool isDesktop}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Menu Title (if provided)
        if (config.title != null)
          Padding(
            padding: const EdgeInsets.all(16),
            child: AppText.titleLarge(config.title!),
          ),

        // Menu Items
        ...config.items.map((item) {
          if (item.isDivider) {
            return const Divider();
          }

          return AppListTile(
            leading: item.icon != null ? Icon(item.icon) : null,
            title: AppText(item.label),
            selected: item.isSelected,
            onTap: item.enabled ? item.onTap : null,
          );
        }),
      ],
    );
  }
}
