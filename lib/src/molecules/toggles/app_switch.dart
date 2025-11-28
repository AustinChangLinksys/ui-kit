import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/molecules/toggles/toggle_content_renderer.dart';
import '../../foundation/theme/design_system/app_design_theme.dart';
import '../../atoms/surfaces/app_surface.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;

  // 支援自定義尺寸因子，預設使用 Theme.spacingFactor
  final double? scale;

  const AppSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.scale,
  });

  bool get _isEnabled => onChanged != null;

  @override
  Widget build(BuildContext context) {
    // 1. 取得當前的 Design Theme
    final theme = Theme.of(context).extension<AppDesignTheme>()!;

    // 2. 計算尺寸 (基於 Spacing Factor)
    // 預設寬度 52, 高度 32 (標準 Mobile 尺寸)
    final double effectiveScale = scale ?? theme.spacingFactor;
    final double trackWidth = 52.0 * effectiveScale;
    final double trackHeight = 32.0 * effectiveScale;
    final double thumbSize = 24.0 * effectiveScale;
    final double padding = 4.0 * effectiveScale;

    return GestureDetector(
      onTap: _isEnabled ? () => onChanged!(!value) : null,
      child: Opacity(
        opacity: _isEnabled ? 1.0 : 0.5, // Disabled 狀態自動變半透明
        child: AppSurface(
          // --- Track (軌道) ---
          // 根據狀態切換變體：開啟時高亮，關閉時使用基礎底色
          variant: value ? SurfaceVariant.highlight : SurfaceVariant.base,
          width: trackWidth,
          height: trackHeight,
          // 強制圓角：如果你希望 Brutal 也是圓角，可以不設；
          // 但通常我們讓 AppSurface 根據 Theme 決定 (Glass=圓, Brutal=方)
          // 這裡我們不寫死 borderRadius，完全交給 Theme 決定形狀！
          child: Stack(
            children: [
              // --- Thumb (拇指) ---
              AnimatedAlign(
                // 3. 讀取 Theme 的物理動畫設定
                duration: theme.animation.duration,
                curve: theme.animation.curve,
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: AppSurface(
                    // Thumb 通常是 Elevated (浮起來的)
                    variant: SurfaceVariant.elevated,
                    width: thumbSize,
                    height: thumbSize,
                    // 這裡可以放 Icon，例如 Brutal 風格可以放個 "I" / "O"
                    child: _buildThumbContent(theme, value),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThumbContent(AppDesignTheme theme, bool checked) {
    final style = theme.toggleStyle;

    return ToggleContentRenderer(
      type: checked ? style.activeType : style.inactiveType,
      color: theme.surfaceElevated.contentColor,
      text: checked ? style.activeText : style.inactiveText,
      icon: checked ? style.activeIcon : style.inactiveIcon,
    );
  }
}
