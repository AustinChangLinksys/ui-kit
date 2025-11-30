import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/toggle_style.dart';
import 'package:ui_kit_library/src/molecules/toggles/toggle_content_renderer.dart';

class AppRadio<T> extends StatelessWidget {
  const AppRadio({
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
    super.key,
  });

  final T value;
  final T? groupValue;
  final ValueChanged<T?>? onChanged;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final isSelected = value == groupValue;
    final isDisabled = onChanged == null;

    final spec = theme.toggleStyle;
    
    // 1. Style Resolution with Fallback
    final baseStyle = isSelected 
        ? (spec.activeTrackStyle ?? theme.surfaceHighlight) 
        : (spec.inactiveTrackStyle ?? theme.surfaceBase);

    // 2. Radio 不需要覆寫 borderRadius，因為它會被 AppSurface(shape: Circle) 強制忽略
    // 所以直接用 baseStyle 即可

    Widget radio = AppSurface(
      style: baseStyle,
      height: 24 * theme.spacingFactor,
      width: 24 * theme.spacingFactor,
      
      // ✨ 關鍵：Radio 永遠是圓形
      shape: BoxShape.circle, 
      // 注意：當 shape 為 circle 時，borderRadius 會被忽略，所以不用傳
      
      padding: EdgeInsets.zero,
      interactive: !isDisabled,
      onTap: isDisabled ? null : () => onChanged!(value),
      
      child: Center(
        // ✨ 重用 Renderer：傳入 dot 類型來畫圓點
        child: ToggleContentRenderer(
          type: isSelected ? ToggleContentType.dot : ToggleContentType.none,
          color: baseStyle.contentColor,
        ),
      ),
    );

    if (label != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          radio,
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

    return radio;
  }
}