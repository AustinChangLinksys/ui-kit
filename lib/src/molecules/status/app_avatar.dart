import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.initials,
    this.imageUrl,
    this.size = 40.0,
    super.key,
  });

  final String initials;
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    // 1. 取得 Theme
    final theme = Theme.of(context).extension<AppDesignTheme>()!;

    return AppSurface(
      // 2. 樣式繼承：使用 Base 樣式 (獲得邊框/陰影/Blur)
      style: theme.surfaceBase,
      
      // 3. 幾何形狀：強制圓形
      width: size,
      height: size,
      shape: BoxShape.circle, 
      // ❌ 修正：當 shape 為 circle 時，不可傳入 borderRadius，AppSurface 內部會處理
      // borderRadius: ... (移除此行)
      
      padding: EdgeInsets.zero,
      
      // 4. 內容裁切：確保圖片不會超出圓形邊界
      child: ClipOval(
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover, // Center Crop (Cover)
                width: size,
                height: size,
                // 圖片載入失敗時顯示 Fallback
                errorBuilder: (context, error, stackTrace) => _buildFallback(context, theme),
              )
            : _buildFallback(context, theme),
      ),
    );
  }

  // ✨ 修正：加入 BuildContext 參數
  Widget _buildFallback(BuildContext context, AppDesignTheme theme) {
    // 使用 Highlight 的顏色 (通常是 Primary Color) 做為基調
    final primaryColor = theme.surfaceHighlight.contentColor;

    return Container(
      width: size,
      height: size,
      // 背景色：極淡的主色調
      color: primaryColor.withValues(alpha: 0.1),
      alignment: Alignment.center,
      child: Text(
        // ✨ 修正：加入防呆邏輯
        initials.isNotEmpty 
            ? initials.substring(0, initials.length.clamp(0, 2)).toUpperCase() 
            : "",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: primaryColor, // 文字顏色
          fontWeight: FontWeight.bold,
          fontSize: size * 0.4, // 字體大小隨 Avatar 尺寸縮放
        ),
      ),
    );
  }
}