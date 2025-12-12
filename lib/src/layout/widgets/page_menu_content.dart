import 'package:flutter/material.dart';
import '../../atoms/typography/app_text.dart';
import '../../atoms/icons/app_icon.dart';
import '../../atoms/layout/app_divider.dart';
import '../../molecules/layout/app_list_tile.dart';
import '../../foundation/theme/tokens/app_spacing.dart';
import '../models/page_menu_config.dart';

/// A Constitution-compliant menu content widget for AppPageView.
///
/// This widget extracts the menu content rendering logic from AppPageView
/// to improve maintainability and testability. Used in both desktop sidebar
/// and mobile bottom sheet contexts.
///
/// Constitution Compliance:
/// - §3.3: Uses AppSpacing tokens instead of hardcoded values
/// - §6.2: Dumb component - receives data via constructor, passes events via callback
/// - §6.3: Uses Slots Pattern with composable items
class PageMenuContent extends StatelessWidget {
  /// Configuration for the menu items
  final PageMenuConfig config;

  const PageMenuContent({
    super.key,
    required this.config,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Menu Title (if provided)
        if (config.title != null)
          Padding(
            // Use AppSpacing.lg (16) instead of hardcoded value (§3.3)
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: AppText.titleLarge(config.title!),
          ),

        // Menu Items
        ...config.items.map((item) {
          if (item.isDivider) {
            return const AppDivider();
          }

          return AppListTile(
            leading: item.icon != null ? AppIcon.font(item.icon!) : null,
            title: AppText(item.label),
            selected: item.isSelected,
            onTap: item.enabled ? item.onTap : null,
          );
        }),
      ],
    );
  }
}
