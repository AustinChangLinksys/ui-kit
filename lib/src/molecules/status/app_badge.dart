import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class AppBadge extends StatelessWidget {
  const AppBadge({
    required this.label,
    this.color,
    this.textColor,
    this.onDeleted,
    super.key,
  });

  final String label;
  
  /// Background color override (e.g., Status Colors: Error/Success)
  /// If null, uses Theme's default Highlight style
  final Color? color;
  
  /// Text color override (usually paired with color, or automatically calculated)
  final Color? textColor;
  
  /// If provided, a delete icon will be displayed and interaction enabled
  final VoidCallback? onDeleted;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    
    // 1. Get base style (Single Source of Truth)
    // Badge is semantically Highlight (highlighted information)
    final baseStyle = theme.surfaceHighlight;

    // 2. Calculate effective style (Effective Style)
    // If a color is passed in, we use copyWith to override the color, but retain the Theme's physical properties (Blur/Shadow/BorderWidth)
    SurfaceStyle effectiveStyle = baseStyle;
    
    if (color != null) {
      // Strategy: If an external color is passed in (e.g., red), we simulate a "Tinted" effect.
      // Background = 10% alpha of color, Border = 20% alpha of color, Content = original color
      // This ensures consistency across Glass/Brutal styles.
      effectiveStyle = baseStyle.copyWith(
        backgroundColor: color!.withValues(alpha: 0.1),
        borderColor: color!.withValues(alpha: 0.2),
        contentColor: textColor ?? color!,
      );
    }

    // 3. Force shape (Topology)
    // Badge is always capsule-shaped (Stadium), so we force override the border radius
    effectiveStyle = effectiveStyle.copyWith(
      borderRadius: 99.0, 
    );

    return AppSurface(
      style: effectiveStyle,
      shape: BoxShape.rectangle, // Badge 是圓角矩形
      
      // Size settings
      height: 24.0 * theme.spacingFactor, // Fixed height but scales with density
      padding: EdgeInsets.zero, // Controlled by internal Padding
      
      // Interaction settings (interactive only if deletable)
      interactive: onDeleted != null,
      onTap: onDeleted, 

      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8.0 * theme.spacingFactor,
          // vertical is controlled by height to center, set to 0 here or fine-tune
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Label
            Text(
              label,
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: effectiveStyle.contentColor,
                height: 1.0, // Ensure text is vertically centered
              ),
            ),
            
            // Delete Icon (Optional)
            if (onDeleted != null) ...[
              SizedBox(width: 4.0 * theme.spacingFactor),
              Icon(
                Icons.close,
                size: 14.0 * theme.spacingFactor,
                color: effectiveStyle.contentColor,
              ),
            ],
          ],
        ),
      ),
    );
  }
}