import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    required this.items,
    required this.currentIndex,
    required this.onTap,
    super.key,
  }) : assert(items.length >= 2 && items.length <= 5,
            'AppNavigationBar must have between 2 and 5 items.');

  final List<AppNavigationItem> items;
  final int currentIndex;
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

          // Color logic:
          // - Selected: Use Highlight's text color (usually primary color)
          // - Unselected: Use Base's text color with reduced opacity
          final color = isSelected
              ? theme.surfaceHighlight.contentColor
              : theme.surfaceBase.contentColor.withValues(alpha: 0.6);

          // Use Expanded to ensure click area is evenly distributed
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque, // Ensure blank areas are also clickable
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: color,
                      size: 24 * theme.spacingFactor, // Support scaling
                    ),
                    child: isSelected && item.activeIcon != null
                        ? item.activeIcon!
                        : item.icon,
                  ),
                  SizedBox(height: 4 * theme.spacingFactor),
                  Text(
                    item.label,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: color,
                          fontWeight:
                              isSelected ? FontWeight.w600 : FontWeight.w400,
                        ),
                  ),
                ],
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
