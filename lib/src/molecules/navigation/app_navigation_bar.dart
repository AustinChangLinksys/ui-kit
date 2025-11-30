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
    // 1. 獲取 Theme 與 Spec
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    final navSpec = theme.navigationStyle;

    // 2. 決定樣式策略 (DDS)
    // - Floating (Glass): 使用 Elevated (浮起感)
    // - Fixed (Brutal): 使用 Base (實心底)
    final baseStyle =
        navSpec.isFloating ? theme.surfaceElevated : theme.surfaceBase;

    // 3. 微調樣式 (Overrides)
    // 根據是否浮動，強制覆寫圓角
    final effectiveStyle = baseStyle.copyWith(
      // ✨ 微調：如果是 Floating (Liquid)，強制變成膠囊形 (99.0)
      // 這樣看起來更有 "表面張力" 的感覺，而不是只是圓角矩形
      borderRadius: navSpec.isFloating ? 99.0 : 0.0,
    );

    // 4. 建構核心 Bar (使用 AppSurface)
    Widget navBarContent = AppSurface(
      style: effectiveStyle,
      height: navSpec.height,
      width: double.infinity,
      // 內距：左右稍微留白，讓圖示不要貼邊
      padding: EdgeInsets.symmetric(horizontal: theme.spacingFactor * 4),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (index) {
          final item = items[index];
          final isSelected = index == currentIndex;

          // 顏色邏輯：
          // - 選中：使用 Highlight 的文字色 (通常是主色)
          // - 未選中：使用 Base 的文字色並降低不透明度
          final color = isSelected
              ? theme.surfaceHighlight.contentColor
              : theme.surfaceBase.contentColor.withValues(alpha: 0.6);

          // 使用 Expanded 確保點擊區域平均分配
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque, // 確保空白處也能點擊
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconTheme(
                    data: IconThemeData(
                      color: color,
                      size: 24 * theme.spacingFactor, // 支援縮放
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

    // 5. 處理佈局模式 (Floating vs Fixed) 與 Safe Area
    if (navSpec.isFloating) {
      // --- Floating Mode (Glass) ---
      // 懸浮在 Safe Area 之上，四周有間距
      return SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: navSpec.floatingMargin,
            vertical: navSpec.floatingMargin / 2, // 底部留一點空間
          ),
          child: navBarContent,
        ),
      );
    } else {
      // --- Fixed Mode (Brutal/Flat) ---
      // 貼齊底部。為了讓背景色延伸到 Home Indicator 區域，我們通常不包 SafeArea (bottom: true)
      // 而是讓 Scaffold 來處理，或是把 AppSurface 延伸。
      // 最通用的做法是：僅內容避開 Safe Area，背景延伸。

      // 但因為 AppSurface 有邊框/圓角，如果要做到完美的「延伸背景但避開內容」，
      // 通常建議直接回傳 navBarContent，並由 Scaffold 的 bottomNavigationBar 屬性去處理 Safe Area。

      return SafeArea(
        top: false,
        child: navBarContent,
      );
    }
  }
}
