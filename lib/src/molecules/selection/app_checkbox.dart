import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/molecules/toggles/toggle_content_renderer.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppCheckbox extends StatelessWidget {
  const AppCheckbox({
    required this.value,
    this.onChanged,
    this.label,
    super.key,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context); // 使用 helper 獲取
    final isDisabled = onChanged == null;

    // 1. 取得 Theme Spec
    final spec = theme.toggleStyle;

    // 2. 決定基礎樣式 (包含 Fallback 邏輯)
    // 如果 Spec 沒定義專屬樣式，退回使用全域的 Highlight/Base
    final baseStyle = value
        ? (spec.activeTrackStyle ?? theme.surfaceHighlight)
        : (spec.inactiveTrackStyle ?? theme.surfaceBase);

    // 3. 形狀特化 (Topology Override)
    // Checkbox 的物理特徵是 "微圓角方塊" (Radius ~ 6.0)
    // 我們使用 copyWith 保留 Theme 的材質 (顏色/陰影)，但強制改變形狀
    final checkboxStyle = baseStyle.copyWith(
      borderRadius: 6.0,
    );

    Widget checkbox = AppSurface(
      // ✨ 正確寫法：直接傳入處理好的 style 物件
      style: checkboxStyle,

      // 尺寸建議跟隨 spacingFactor 縮放 (Brutal 模式下會變大)
      height: 24 * theme.spacingFactor,
      width: 24 * theme.spacingFactor,

      // Checkbox 是矩形 (BoxShape.rectangle)
      shape: BoxShape.rectangle,

      // 互動設定
      padding: EdgeInsets.zero,
      interactive: !isDisabled,
      onTap: isDisabled ? null : () => onChanged!(!value),

      // ✨ 正確寫法：Renderer 應該是 Dumb 的，由外部告訴它畫什麼
      child: Center(
        child: ToggleContentRenderer(
          // 如果選中：看 Theme 規定要畫 Icon (Flat) 還是 Text (Brutal)
          // 如果未選中：通常是 None
          type: value ? spec.activeType : spec.inactiveType,
          color: checkboxStyle.contentColor,
          icon: value ? Icons.check : null, // 強制指定 Checkbox 的語義圖示
          text: value ? spec.activeText : null, // 支援 Brutal 的文字
        ),
      ),
    );

    if (label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          checkbox,
          SizedBox(width: theme.spacingFactor * 8),
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: isDisabled
                      ? theme.surfaceBase.contentColor.withValues(alpha: 0.5)
                      : theme.surfaceBase.contentColor,
                ),
          ),
        ],
      );
    }

    return checkbox;
  }
}
