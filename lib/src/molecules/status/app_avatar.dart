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
      // 4. Content clipping: Ensure image does not exceed circular boundary
      
      padding: EdgeInsets.zero,
      
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

  Widget _buildFallback(BuildContext context, AppDesignTheme theme) {
    // Use Tonal surface for fallback background
    // This automatically adapts to all design themes:
    // - Glass: Frosted tint
    // - Brutal: Solid grey with border
    // - Flat: Material 3 secondary container
    // - Neumorphic: Soft tactile surface
    // - Pixel: Grid pattern with retro colors

    return AppSurface(
      variant: SurfaceVariant.tonal,
      width: size,
      height: size,
      shape: BoxShape.circle,
      padding: EdgeInsets.zero,
      child: Center(
        child: Text(
          // Add null safety logic
          initials.isNotEmpty
              ? initials.substring(0, initials.length.clamp(0, 2)).toUpperCase()
              : "",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: theme.surfaceSecondary.contentColor,
            fontWeight: FontWeight.bold,
            fontSize: size * 0.4, // Font size scales with Avatar size
          ),
        ),
      ),
    );
  }
}