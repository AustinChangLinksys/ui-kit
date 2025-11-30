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

    // 2. Radio does not need to override borderRadius, as it will be forcibly ignored by AppSurface(shape: Circle)
    // So just use baseStyle.

    Widget radio = AppSurface(
      style: baseStyle,
      height: 24 * theme.spacingFactor,
      width: 24 * theme.spacingFactor,
      
      // ✨ Key: Radio is always circular
      shape: BoxShape.circle, 
      // Note: When shape is circle, borderRadius will be ignored, so no need to pass it
      
      padding: EdgeInsets.zero,
      interactive: !isDisabled,
      onTap: isDisabled ? null : () => onChanged!(value),
      
      child: Center(
        // ✨ Reuse Renderer: Pass dot type to draw a dot
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