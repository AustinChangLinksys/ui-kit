import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/loading/app_skeleton.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';

/// 按鈕尺寸變體
enum AppButtonSize {
  small,  // 32px
  medium, // 48px (Default)
  large,  // 56px
}

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.variant = SurfaceVariant.highlight, // 使用標準命名 variant
    this.size = AppButtonSize.medium,        // 新增尺寸控制
    super.key,
  });

  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final bool isLoading;
  final SurfaceVariant variant;
  final AppButtonSize size;

  bool get _isEnabled => onTap != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    // 使用 extension 獲取 Theme (假設你有加這一段)
    // 或是使用 Theme.of(context).extension<AppDesignTheme>()!
    final theme = Theme.of(context).extension<AppDesignTheme>()!;

    // 1. 根據 Size Enum 決定高度與 Padding (DDS)
    final double height = _resolveHeight(size) * theme.spacingFactor;
    final double paddingX = _resolvePadding(size) * theme.spacingFactor;

    // 2. Disabled 狀態處理 (Opacity)
    return Opacity(
      opacity: _isEnabled ? 1.0 : 0.5,
      child: AppSurface(
        // 3. 直接傳遞 Variant，讓 AppSurface 決定樣式 (IoC)
        variant: variant,
        interactive: _isEnabled, // 啟用物理互動 (Scale/Glow)
        onTap: _isEnabled ? onTap : null,
        height: height,
        // 4. 按鈕需要水平 Padding
        padding: EdgeInsets.symmetric(horizontal: paddingX),
        
        child: Row(
          mainAxisSize: MainAxisSize.min, // Hug Content
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              // Loading 時顯示圓形 Skeleton (模擬 Spinner)
              AppSkeleton.circular(size: height * 0.4)
            else ...[
              if (icon != null) ...[
                icon!,
                SizedBox(width: 8 * theme.spacingFactor),
              ],
              Text(
                label,
                // 根據按鈕大小調整字體
                style: _resolveTextStyle(context, size),
              ),
            ],
          ],
        ),
      ),
    );
  }

  // --- Helper Methods (封裝尺寸邏輯) ---

  double _resolveHeight(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small: return 32.0;
      case AppButtonSize.medium: return 48.0;
      case AppButtonSize.large: return 56.0;
    }
  }

  double _resolvePadding(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small: return 16.0;
      case AppButtonSize.medium: return 24.0;
      case AppButtonSize.large: return 32.0;
    }
  }

  TextStyle? _resolveTextStyle(BuildContext context, AppButtonSize size) {
    final textTheme = Theme.of(context).textTheme;
    // 這裡可以再混合 theme.typography.bodyStyleOverride
    switch (size) {
      case AppButtonSize.small: return textTheme.labelMedium?.copyWith(fontWeight: FontWeight.bold);
      case AppButtonSize.medium: return textTheme.labelLarge?.copyWith(fontWeight: FontWeight.bold);
      case AppButtonSize.large: return textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold);
    }
  }
}