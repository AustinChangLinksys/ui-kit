import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

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

    // 1. 決定樣式 (DDS)
    final baseStyle =
        navSpec.isFloating ? theme.surfaceElevated : theme.surfaceBase;

    // 2. 微調樣式
    final effectiveStyle = baseStyle.copyWith(
      // Floating: 大圓角 (膠囊意象)
      // Fixed: 直角 (貼邊)
      borderRadius: navSpec.isFloating ? 99.0 : 0.0,
    );

    // 3. 寬度計算
    final width = 80.0 * theme.spacingFactor;

    // 4. 建構 Rail 本體
    Widget railContent = AppSurface(
      style: effectiveStyle,
      width: width,
      height: double.infinity, // 佔滿父層給予的高度
      padding: EdgeInsets.symmetric(vertical: theme.spacingFactor * 16),
      child: Column(
        children: [
          // Top Slot (Logo)
          if (leading != null) ...[
            leading!,
            SizedBox(height: theme.spacingFactor * 16),
          ],

          // Navigation Items (置中或靠上，這裡選用 Spacer 夾擊使其置中)
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

    // 5. 處理 Floating 間距與 Safe Area
    if (navSpec.isFloating) {
      return SafeArea(
        child: Padding(
          // 懸浮模式：上下左留白，右邊貼齊內容區
          padding: EdgeInsets.fromLTRB(
              navSpec.floatingMargin,
              navSpec.floatingMargin,
              0, // 右邊通常不留白，直接接內容
              navSpec.floatingMargin),
          child: railContent,
        ),
      );
    } else {
      // 固定模式：延伸到頂部和底部
      return SafeArea(
        right: false, // 不避開右側內容
        child: railContent,
      );
    }
  }
}

// 私有組件：Rail Item
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
    final color = isSelected
        ? theme.surfaceHighlight.contentColor
        : theme.surfaceBase.contentColor.withValues(alpha: 0.6);

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
              child: isSelected && item.activeIcon != null
                  ? item.activeIcon!
                  : item.icon,
            ),
            SizedBox(height: theme.spacingFactor * 4),
            Text(
              item.label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: color,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    fontSize: 10, // Rail 的文字通常比較小
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
