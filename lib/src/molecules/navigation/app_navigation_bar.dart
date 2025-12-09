import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A semantic navigation bar with pill-shaped Tonal indicator for selected items.
///
/// The selected item is highlighted with a **Tonal pill-shaped surface**,
/// providing a clear visual indication of the current navigation state across all design themes.
///
/// **Example**:
/// ```dart
/// AppNavigationBar(
///   currentIndex: selectedIndex,
///   onTap: (index) => setState(() => selectedIndex = index),
///   items: [
///     AppNavigationItem(icon: Icons.home, label: 'Home'),
///     AppNavigationItem(icon: Icons.search, label: 'Search'),
///     AppNavigationItem(icon: Icons.favorite, label: 'Favorites'),
///   ],
/// )
/// ```
///
/// **Visual Hierarchy**:
/// - Selected item: Pill-shaped Tonal surface (medium-priority highlight)
/// - Unselected items: Reduced opacity text/icons on base background
class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  }) : assert(items.length >= 2 && items.length <= 5,
            'AppNavigationBar must have between 2 and 5 items.');

  /// Navigation items to display in the bar (2-5 items)
  final List<AppNavigationItem> items;
  /// The index of the currently selected item
  final int currentIndex;
  /// Callback when a different item is selected
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    // 1. Get Theme and Spec
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    final navSpec = theme.navigationStyle;

    // 2. Determine style strategy (DDS)
    // - Floating (Glass): Use Elevated (floating feel)
    // - Fixed (Brutal): Use Base (solid bottom)
    final baseStyle =
        navSpec.isFloating ? theme.surfaceElevated : theme.surfaceBase;

    // 3. Fine-tune style (Overrides)
    // Force override rounded corners based on whether it is floating
    final effectiveStyle = baseStyle.copyWith(
      // Fine-tune: If it's Floating (Liquid), force it into a capsule shape (99.0)
      // This makes it look more like a "surface tension" rather than just a rounded rectangle.
      borderRadius: navSpec.isFloating ? 99.0 : 0.0,
    );

    // 4. Construct the core Bar (using AppSurface)
    Widget navBarContent = AppSurface(
      style: effectiveStyle,
      height: navSpec.height,
      width: double.infinity,
      // Internal padding: slightly leave space on left and right, so icons don't stick to the edge
      padding: EdgeInsets.symmetric(horizontal: theme.spacingFactor * 4),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;

          // Color logic: Use itemColors from NavigationStyle
          final color = navSpec.itemColors.resolve(isActive: isSelected);

          // Use Expanded to ensure click area is evenly distributed
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque, // Ensure blank areas are also clickable
              child: Center(
                child: isSelected
                    // Pill-shaped Tonal indicator for selected item
                    ? AppSurface(
                        variant: SurfaceVariant.tonal,
                        shape: BoxShape.rectangle,
                        style: theme.surfaceSecondary.copyWith(
                          borderRadius: 99.0, // Force pill shape
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: 16 * theme.spacingFactor,
                          vertical: 4 * theme.spacingFactor,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconTheme(
                              data: IconThemeData(
                                color: color,
                                size: 24 * theme.spacingFactor,
                              ),
                              child: item.activeIcon ?? item.icon,
                            ),
                            SizedBox(height: 4 * theme.spacingFactor),
                            Text(
                              item.label,
                              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                    color: color,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      )
                    // Unselected item - no background
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconTheme(
                            data: IconThemeData(
                              color: color,
                              size: 24 * theme.spacingFactor,
                            ),
                            child: item.icon,
                          ),
                          SizedBox(height: 4 * theme.spacingFactor),
                          Text(
                            item.label,
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                                  color: color,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                        ],
                      ),
              ),
            ),
          );
        }),
      ),
    );

    // 5. Handle layout mode (Floating vs Fixed) and Safe Area
    if (navSpec.isFloating) {
      // --- Floating Mode (Glass) ---
      // Floats above Safe Area, with spacing around it
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: navSpec.floatingMargin,
            vertical: navSpec.floatingMargin / 2, // Leave a little space at the bottom
          ),
          child: navBarContent,
        ),
      );
    } else {
      // --- Fixed Mode (Brutal/Flat) ---
      // Sticks to the bottom. To extend the background color to the Home Indicator area, we usually don't wrap SafeArea (bottom: true)
      // Instead, let Scaffold handle it, or extend AppSurface.
      // The most common practice is: only content avoids Safe Area, background extends.

      // But because AppSurface has borders/rounded corners, to achieve a perfect "extended background but avoid content",
      // it is usually recommended to directly return navBarContent and let Scaffold's bottomNavigationBar property handle Safe Area.

      return SafeArea(
        top: false,
        child: navBarContent,
      );
    }
  }
}
