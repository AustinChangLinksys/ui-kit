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
  
  /// Specifies the color (Tint Color). If null, uses Theme's Base style.
  final Color? color;
  
  /// Delete callback. If present, displays a delete icon.
  final VoidCallback? onDeleted;
  
  /// Click callback (e.g., selecting a Tag).
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    
    // 1. Get base style (IoC)
    // Tags belong to the "Base" level, inheriting the physical properties of cards (e.g., Brutal's thick border)
    final baseStyle = theme.surfaceBase;

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
    // Smart rounded corners: If the Theme has rounded corners (Glass/Flat), Tags use smaller rounded corners (8.0).
    // If the Theme has sharp corners (Brutal), Tags retain sharp corners (0.0).
    if (baseStyle.borderRadius > 0) {
      effectiveStyle = effectiveStyle.copyWith(
        borderRadius: 8.0, 
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
                onTap: onDeleted,
                behavior: HitTestBehavior.opaque, // Expand click area
                child: Icon(
                  Icons.close,
                  size: 14.0 * theme.spacingFactor,
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