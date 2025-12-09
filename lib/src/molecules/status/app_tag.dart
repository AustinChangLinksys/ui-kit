import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A semantic tag component with automatic selection state styling.
///
/// Tags automatically switch between **Base** and **Tonal** surfaces based on selection state,
/// providing clear visual feedback for filter selection and status indication.
///
/// **Example - Filter Tags**:
/// ```dart
/// AppTag(
///   label: '#Flutter',
///   isSelected: isFlutterSelected,
///   onTap: () => setState(() => isFlutterSelected = !isFlutterSelected),
/// )
///
/// // With custom color
/// AppTag(
///   label: 'Active',
///   color: Colors.green,
///   isSelected: true,
/// )
/// ```
///
/// **Visual Hierarchy**:
/// - `isSelected: false`: Base surface (low-priority)
/// - `isSelected: true`: Tonal surface (medium-priority, active state)
class AppTag extends StatelessWidget {
  const AppTag({
    required this.label,
    this.color,
    this.onDeleted,
    this.onTap,
    this.isSelected = false,
    super.key,
  });

  final String label;

  /// Specifies the color (Tint Color). If null, uses Theme's Base/Tonal style.
  final Color? color;

  /// Delete callback. If present, displays a delete icon.
  final VoidCallback? onDeleted;

  /// Click callback (e.g., selecting a Tag).
  final VoidCallback? onTap;

  /// Whether this tag is in the selected/active state.
  /// When true, automatically applies the Tonal surface style.
  /// When false, uses the Base surface style.
  /// Enables clear visual feedback for filter selections and active states.
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    // 1. Get base style (IoC)
    // Tags use Base level by default, Tonal when selected
    // When selected, automatically switch to Secondary (Tonal) surface for visual distinction
    final baseStyle = isSelected ? theme.surfaceSecondary : theme.surfaceBase;

    // 2. Calculate effective style (Style Resolution)
    SurfaceStyle effectiveStyle = baseStyle;

    if (color != null) {
      // Tinting Logic - Unified with AppBadge
      // Fill: 10% | Border: 20% | Content: 100%
      // This automatically retains the Theme-defined borderWidth (e.g., Brutal's 3.0 or Flat's 1.0)
      effectiveStyle = effectiveStyle.copyWith(
        backgroundColor: color!.withValues(alpha: 0.1),
        borderColor: color!.withValues(alpha: 0.2),
        contentColor: color!,
      );
    }

    // 3. Shape specialization (Topology Override)
    // Smart rounded corners: If the Theme has rounded corners (Glass/Flat), Tags use smaller rounded corners (50% of base).
    // If the Theme has sharp corners (Brutal), Tags retain sharp corners (0.0).
    if (baseStyle.borderRadius > 0) {
      effectiveStyle = effectiveStyle.copyWith(
        borderRadius: baseStyle.borderRadius * 0.5,
      );
    }

    return AppSurface(
      style: effectiveStyle,
      shape: BoxShape.rectangle,
      
      // Interaction settings
      interactive: onTap != null,
      onTap: onTap,
      
      // Internal layout
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
                onTap: () async {
                  await AppFeedback.onInteraction();
                  onDeleted?.call();
                },
                behavior: HitTestBehavior.opaque, // Expand click area
                child: Icon(
                  Icons.close,
                  size: (Theme.of(context).textTheme.bodySmall?.fontSize ?? appTextTheme.bodySmall!.fontSize!) * theme.spacingFactor,
                  // Delete button color slightly lighter to distinguish hierarchy
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