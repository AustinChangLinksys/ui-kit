import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/molecules/toggles/toggle_content_renderer.dart';
import '../../foundation/theme/design_system/app_design_theme.dart';
import '../../atoms/surfaces/app_surface.dart';

class AppSwitch extends StatelessWidget {
  final bool value;
  final ValueChanged<bool>? onChanged;
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
    // 1. Get the current Design Theme and Spec
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    final toggleSpec = theme.toggleStyle;

    // 2. Calculate dimensions
    final double effectiveScale = scale ?? theme.spacingFactor;
    final double trackWidth = 52.0 * effectiveScale;
    final double trackHeight = 32.0 * effectiveScale;
    final double thumbSize = 24.0 * effectiveScale;
    final double padding = 4.0 * effectiveScale;

    // 3. ✨ Core Logic: Style Resolution ✨
    // Prioritize the override style in toggleSpec; if null, use the Theme's global semantic variant
    
    // Resolve Track style
    final currentTrackStyle = value
        ? (toggleSpec.activeTrackStyle ?? theme.surfaceHighlight)
        : (toggleSpec.inactiveTrackStyle ?? theme.surfaceBase);

    // Resolve Thumb style
    final currentThumbStyle = toggleSpec.thumbStyle ?? theme.surfaceElevated;

    return GestureDetector(
      onTap: _isEnabled ? () => onChanged!(!value) : null,
      child: Opacity(
        opacity: _isEnabled ? 1.0 : 0.5,
        child: AppSurface(
          // ✨ Here, style is directly injected instead of relying on variant lookup
          // (Prerequisite: AppSurface must support receiving 'style' parameter, see below for details)
          style: currentTrackStyle,
          width: trackWidth,
          height: trackHeight,
          padding: EdgeInsets.zero,
          child: Stack(
            children: [
              AnimatedAlign(
                duration: theme.animation.duration,
                curve: theme.animation.curve,
                alignment: value ? Alignment.centerRight : Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.all(padding),
                  child: AppSurface(
                    // ✨ Thumb also uses the resolved style
                    style: currentThumbStyle,
                    width: thumbSize,
                    height: thumbSize,
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
      // Note: The color should follow the currently used Thumb Style
      color: (style.thumbStyle ?? theme.surfaceElevated).contentColor, 
      text: checked ? style.activeText : style.inactiveText,
      icon: checked ? style.activeIcon : style.inactiveIcon,
    );
  }
}