import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';

class AppAvatar extends StatelessWidget {
  const AppAvatar({
    required this.initials,
    this.imageUrl,
    this.size = 40.0,
    super.key,
  });

  final String initials;
  final String? imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    // 1. Get Theme
    final theme = Theme.of(context).extension<AppDesignTheme>()!;

    return AppSurface(
      // 2. Style inheritance: Use Base style (to get border/shadow/Blur)
      style: theme.surfaceBase,
      
      // 3. Geometric shape: Force circular
      width: size,
      height: size,
      shape: BoxShape.circle, 
      // ❌ Correction: When shape is circle, borderRadius should not be passed, AppSurface will handle it internally
      // borderRadius: ... (Remove this line)
      
      padding: EdgeInsets.zero,
      
      // 4. Content clipping: Ensure image does not exceed circular boundary
      child: ClipOval(
        child: imageUrl != null
            ? Image.network(
                imageUrl!,
                fit: BoxFit.cover, // Center Crop (Cover)
                width: size,
                height: size,
                // Show Fallback when image loading fails
                errorBuilder: (context, error, stackTrace) => _buildFallback(context, theme),
              )
            : _buildFallback(context, theme),
      ),
    );
  }

  // ✨ Correction: Add BuildContext parameter
  Widget _buildFallback(BuildContext context, AppDesignTheme theme) {
    // Use Highlight color (usually Primary Color) as base tone
    final primaryColor = theme.surfaceHighlight.contentColor;

    return Container(
      width: size,
      height: size,
      // Background color: extremely light primary tone
      color: primaryColor.withValues(alpha: 0.1),
      alignment: Alignment.center,
      child: Text(
        // ✨ Correction: Add null safety logic
        initials.isNotEmpty 
            ? initials.substring(0, initials.length.clamp(0, 2)).toUpperCase() 
            : "",
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: primaryColor, // Text color
          fontWeight: FontWeight.bold,
          fontSize: size * 0.4, // Font size scales with Avatar size
        ),
      ),
    );
  }
}