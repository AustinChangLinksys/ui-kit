import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/app_theme.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label,
    this.color,
    this.textColor,
    this.onDeleted,
    super.key,
  });

  final String label;
  
  /// 背景色覆寫 (例如 Status Colors: Error/Success)
  /// 如果為 null，則使用 Theme 預設的 Highlight 樣式
  final Color? color;
  
  /// 文字顏色覆寫 (通常與 color 成對，或自動計算)
  final Color? textColor;
  
  /// 如果提供，會顯示刪除圖示並啟用互動
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    
    // 1. 取得基礎樣式 (Single Source of Truth)
    // Badge 語義上屬於 Highlight (高亮資訊)
    final baseStyle = theme.surfaceHighlight;

    // 2. 計算有效樣式 (Effective Style)
    // 如果有傳入 color，我們使用 copyWith 來覆寫顏色，但保留 Theme 的物理特性 (Blur/Shadow/BorderWidth)
    SurfaceStyle effectiveStyle = baseStyle;
    
    if (color != null) {
      // 策略：如果外部傳入特定顏色 (如紅色)，我們模擬 "Tinted" 效果
      // 背景 = 顏色 10%透明度, 邊框 = 顏色 20%透明度, 內容 = 原色
      // 這樣在 Glass/Brutal 下都能保持一定的一致性
      effectiveStyle = baseStyle.copyWith(
        backgroundColor: color!.withValues(alpha: 0.1),
        borderColor: color!.withValues(alpha: 0.2),
        contentColor: textColor ?? color!,
      );
    }

    // 3. 強制形狀 (Topology)
    // Badge 永遠是膠囊形 (Stadium)，所以我們強制覆寫圓角
    effectiveStyle = effectiveStyle.copyWith(
      borderRadius: 99.0, 
    );

    return AppSurface(
      style: effectiveStyle,
      shape: BoxShape.rectangle, // Badge 是圓角矩形
      
      // 尺寸設定
      height: 24.0 * theme.spacingFactor, // 固定高度但隨密度縮放
      padding: EdgeInsets.zero, // 由內部 Padding 控制
      
      // 互動設定 (只有在可刪除時才 interactive)
      interactive: onDeleted != null,
      onTap: onDeleted, 

      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0 * theme.spacingFactor,
          // vertical 由 height 控制居中，這裡設 0 即可，或微調
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Label
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: effectiveStyle.contentColor,
                height: 1.0, // 確保文字垂直居中
              ),
            ),
            
            // Delete Icon (Optional)
            if (onDeleted != null) ...[
              SizedBox(width: 4.0 * theme.spacingFactor),
              Icon(
                Icons.close,
                size: 14.0 * theme.spacingFactor,
                color: effectiveStyle.contentColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}