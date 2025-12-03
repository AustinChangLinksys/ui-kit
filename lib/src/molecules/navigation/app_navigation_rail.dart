import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A semantic side navigation rail with Tonal surface indicators for selected items.
///
/// Similar to [AppNavigationBar] but optimized for vertical layouts (landscape/desktop).
/// The selected item is highlighted with a **Tonal rounded surface** (8.0 radius),
/// providing visual consistency with the bottom navigation bar.
///
/// **Example**:
/// ```dart
/// AppNavigationRail(
///   currentIndex: selectedIndex,
///   onTap: (index) => setState(() => selectedIndex = index),
///   items: [
///     AppNavigationItem(icon: Icons.home, label: 'Home'),
///     AppNavigationItem(icon: Icons.search, label: 'Search'),
///     AppNavigationItem(icon: Icons.settings, label: 'Settings'),
///   ],
/// )
/// ```
///
/// **Visual Hierarchy**:
/// - Selected item: Tonal surface with rounded corners (8.0px)
/// - Unselected items: Reduced opacity text/icons on transparent background
class AppNavigationRail extends StatelessWidget {
  const AppNavigationRail({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    this.leading,
    this.trailing,
    super.key,
  });

  final List<AppNavigationItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;
  final Widget? leading; // e.g. Logo
  final Widget? trailing; // e.g. Settings Icon

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    final navSpec = theme.navigationStyle;

    // 1. Determine style (DDS)
    final baseStyle =
        navSpec.isFloating ? theme.surfaceElevated : theme.surfaceBase;

    // 2. Fine-tune style
    final effectiveStyle = baseStyle.copyWith(
      // Floating: Large rounded corners (capsule visual)
      // Fixed: Right angles (edge-aligned)
      borderRadius: navSpec.isFloating ? 99.0 : 0.0,
    );

    // 3. Width calculation
    final width = 80.0 * theme.spacingFactor;

    // 4. Construct the Rail body
    Widget railContent = AppSurface(
      style: effectiveStyle,
      width: width,
      height: double.infinity, // Occupy parent-given height
      padding: EdgeInsets.symmetric(vertical: theme.spacingFactor * 16),
      child: Column(
        children: [
          // Top Slot (Logo)
          if (leading != null) ...[
            leading!,
            SizedBox(height: theme.spacingFactor * 16),
          ],

          // Navigation Items (centered or top-aligned, here using Spacers to center them)
          const Spacer(),
          ...List.generate(items.length, (index) {
            final item = items[index];
            final isSelected = index == currentIndex;
            return _RailItem(
              item: item,
              isSelected: isSelected,
              onTap: () => onTap(index),
              theme: theme,
            );
          }),
          const Spacer(),

          // Bottom Slot (Settings)
          if (trailing != null) ...[
            SizedBox(height: theme.spacingFactor * 16),
            trailing!,
          ],
        ],
      ),
    );

    // 5. Handle Floating spacing and Safe Area
    if (navSpec.isFloating) {
      return SafeArea(
        child: Padding(
      // --- Floating Mode (Glass) ---
      // Floats above Safe Area, with spacing around it
          padding: EdgeInsets.fromLTRB(
              navSpec.floatingMargin,
              navSpec.floatingMargin,
              0, // Right side usually no padding, directly connect to content
              navSpec.floatingMargin),
          child: railContent,
        ),
      );
    } else {
      // Fixed mode: extends to top and bottom
      return SafeArea(
        right: false, // Do not avoid content on the right
        child: railContent,
      );
    }
  }
}

// Private component: Rail Item
class _RailItem extends StatelessWidget {
  final AppNavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;
  final AppDesignTheme theme;

  const _RailItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    // Selected items use Tonal pill indicator (like AppNavigationBar)
    // Unselected items use reduced opacity text/icons
    if (isSelected) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AppSurface(
          variant: SurfaceVariant.tonal,
          shape: BoxShape.rectangle,
          style: theme.surfaceSecondary.copyWith(
            borderRadius: 8.0, // Rail items use smaller radius than pill
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 8 * theme.spacingFactor,
            vertical: 8 * theme.spacingFactor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconTheme(
                data: IconThemeData(
                  color: theme.surfaceSecondary.contentColor,
                  size: 24,
                ),
                child: item.activeIcon ?? item.icon,
              ),
              SizedBox(height: theme.spacingFactor * 4),
              Text(
                item.label,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      color: theme.surfaceSecondary.contentColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 10,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    // Unselected items: reduced opacity text/icons on transparent background
    final color = theme.surfaceBase.contentColor.withValues(alpha: 0.6);
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: theme.spacingFactor * 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconTheme(
              data: IconThemeData(color: color, size: 24),
              child: item.icon,
            ),
            SizedBox(height: theme.spacingFactor * 4),
            Text(
              item.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
