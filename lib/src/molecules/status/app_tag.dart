import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppTag extends StatelessWidget {
  const AppTag({
    required this.label,
    this.color,
    this.onDeleted,
    this.onTap,
    super.key,
  });

  final String label;
  
  /// 指定顏色 (Tint Color)。若為 null，則使用 Theme 的 Base 樣式。
  final Color? color;
  
  /// 刪除回呼。若存在，顯示刪除圖示。
  final VoidCallback? onDeleted;
  
  /// 點擊回呼 (例如選取 Tag)。
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    
    // 1. 取得基礎樣式 (IoC)
    // Tag 屬於 "Base" 層級，繼承卡片的物理特性 (如 Brutal 的粗框)
    final baseStyle = theme.surfaceBase;

    // 2. 計算有效樣式 (Style Resolution)
    SurfaceStyle effectiveStyle = baseStyle;

    if (color != null) {
      // 染色邏輯 (Tinting Logic) - 與 AppBadge 統一
      // Fill: 10% | Border: 20% | Content: 100%
      // 這會自動保留 Theme 定義的 borderWidth (例如 Brutal 的 3.0 或 Flat 的 1.0)
      effectiveStyle = effectiveStyle.copyWith(
        backgroundColor: color!.withValues(alpha: 0.1),
        borderColor: color!.withValues(alpha: 0.2),
        contentColor: color!,
      );
    }

    // 3. 形狀特化 (Topology Override)
    // 智慧圓角：如果 Theme 是圓角的 (Glass/Flat)，Tag 使用較小的圓角 (8.0)。
    // 如果 Theme 是直角的 (Brutal)，Tag 保持直角 (0.0)。
    if (baseStyle.borderRadius > 0) {
      effectiveStyle = effectiveStyle.copyWith(
        borderRadius: 8.0, 
      );
    }

    return AppSurface(
      style: effectiveStyle,
      shape: BoxShape.rectangle,
      
      // 互動設定
      interactive: onTap != null,
      onTap: onTap,
      
      // 內部佈局
      padding: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0 * theme.spacingFactor,
          vertical: 4.0 * theme.spacingFactor,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Label
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: effectiveStyle.contentColor,
                fontWeight: FontWeight.w500,
                height: 1.0,
              ),
            ),
            
            // Delete Icon
            if (onDeleted != null) ...[
              SizedBox(width: 4.0 * theme.spacingFactor),
              GestureDetector(
                onTap: onDeleted,
                behavior: HitTestBehavior.opaque, // 擴大點擊判定
                child: Icon(
                  Icons.close,
                  size: 14.0 * theme.spacingFactor,
                  // 刪除鈕顏色稍微淡一點，區分層級
                  color: effectiveStyle.contentColor.withValues(alpha: 0.6),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}