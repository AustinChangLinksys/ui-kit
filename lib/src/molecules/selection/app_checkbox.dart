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
    final theme = AppTheme.of(context); // Use helper to get
    final isDisabled = onChanged == null;

    // 1. Get Theme Spec
    final spec = theme.toggleStyle;

    // 2. Determine base style (including Fallback logic)
    // If Spec doesn't define a dedicated style, fall back to global Highlight/Base
    final baseStyle = value
        ? (spec.activeTrackStyle ?? theme.surfaceHighlight)
        : (spec.inactiveTrackStyle ?? theme.surfaceBase);

    // 3. Shape specialization (Topology Override)
    // Checkbox's physical characteristic is "slightly rounded square" (Radius ~ 6.0)
    // We use copyWith to retain the Theme's material (color/shadow), but force change the shape
    final checkboxStyle = baseStyle.copyWith(
      borderRadius: 6.0,
    );

    Widget checkbox = AppSurface(
      // ✨ Correct way: Directly pass the processed style object
      style: checkboxStyle,

      // Recommended size scales with spacingFactor (will be larger in Brutal mode)
      height: 24 * theme.spacingFactor,
      width: 24 * theme.spacingFactor,

      // Checkbox is a rectangle (BoxShape.rectangle)
      shape: BoxShape.rectangle,

      // Interaction settings
      padding: EdgeInsets.zero,
      interactive: !isDisabled,
      onTap: isDisabled ? null : () => onChanged!(!value),

      // ✨ Correct way: Renderer should be Dumb, told what to draw by external means
      child: Center(
        child: ToggleContentRenderer(
          // If selected: depends on Theme whether to draw Icon (Flat) or Text (Brutal)
          // If unselected: usually None
          type: value ? spec.activeType : spec.inactiveType,
          color: checkboxStyle.contentColor,
          icon: value ? Icons.check : null, // Force specify Checkbox's semantic icon
          text: value ? spec.activeText : null, // Support Brutal's text
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
