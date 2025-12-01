import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Button size variants
enum AppButtonSize {
  small, // 32px
  medium, // 48px (Default)
  large, // 56px
}

class AppButton extends StatelessWidget {
  const AppButton({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.variant = SurfaceVariant.highlight, // Use standard naming variant
    this.size = AppButtonSize.medium, // Add size control
    super.key,
  });

  final String label;
  final VoidCallback? onTap;
  final Widget? icon;
  final bool isLoading;
  final SurfaceVariant variant;
  final AppButtonSize size;

  bool get _isEnabled => onTap != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    // Use extension to get Theme (assuming you have added this)
    // Or use Theme.of(context).extension<AppDesignTheme>()!
    final theme = Theme.of(context).extension<AppDesignTheme>()!;

    // 1. Determine height and padding based on Size Enum (DDS)
    final double height = _resolveHeight(size) * theme.spacingFactor;
    final double paddingX = _resolvePadding(size) * theme.spacingFactor;

    // 2. Handle Disabled state (Opacity)
    return Opacity(
      opacity: _isEnabled ? 1.0 : 0.5,
      child: AppSurface(
        // 3. Directly pass Variant, let AppSurface decide style (IoC)
        variant: variant,
        interactive: _isEnabled, // Enable physical interaction (Scale/Glow)
        onTap: _isEnabled ? onTap : null,
        height: height,
        // 4. Buttons need horizontal Padding
        padding: EdgeInsets.symmetric(horizontal: paddingX),

        child: Row(
          mainAxisSize: MainAxisSize.min, // Hug Content
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              // Show circular Skeleton when loading (simulating Spinner)
              AppSkeleton.circular(size: height * 0.4)
            else ...[
              if (icon != null) ...[
                icon!,
                SizedBox(width: 8 * theme.spacingFactor),
              ],
              AppText(
                label,
                variant: _resolveTextVariant(size),
                fontWeight: FontWeight.bold,
              ),
            ],
          ],
        ),
      ),
    );
  }

  // --- Helper Methods (encapsulate size logic) ---

  double _resolveHeight(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 32.0;
      case AppButtonSize.medium:
        return 48.0;
      case AppButtonSize.large:
        return 56.0;
    }
  }

  double _resolvePadding(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return 16.0;
      case AppButtonSize.medium:
        return 24.0;
      case AppButtonSize.large:
        return 32.0;
    }
  }

  AppTextVariant _resolveTextVariant(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small:
        return AppTextVariant.labelMedium;
      case AppButtonSize.medium:
        return AppTextVariant.labelLarge;
      case AppButtonSize.large:
        return AppTextVariant.titleMedium;
    }
  }
}
