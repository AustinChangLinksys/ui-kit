import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Button size variants
enum AppButtonSize {
  small, // 32px
  medium, // 48px (Default)
  large, // 56px
}

/// A semantic button component with visual hierarchy support.
///
/// **Variant Examples**:
/// ```dart
/// // Primary action (default)
/// AppButton(label: 'Confirm', onTap: () {})
///
/// // Secondary action (tonal)
/// AppButton(
///   label: 'Save Draft',
///   variant: SurfaceVariant.tonal,
///   onTap: () {},
/// )
///
/// // Low priority (base)
/// AppButton(
///   label: 'Cancel',
///   variant: SurfaceVariant.base,
///   onTap: () {},
/// )
/// ```
///
/// Visual hierarchy: `highlight` (primary) > `tonal` (secondary) > `base` (tertiary)
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
  /// The semantic variant that controls button styling across all design themes.
  /// - `highlight`: Primary CTA (default)
  /// - `tonal`: Secondary action
  /// - `base`: Low priority action
  final SurfaceVariant variant;
  final AppButtonSize size;

  bool get _isEnabled => onTap != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    // Use extension to get Theme (assuming you have added this)
    // Or use Theme.of(context).extension<AppDesignTheme>()!
    final theme = Theme.of(context).extension<AppDesignTheme>()!;

    // 1. Determine height and padding based on Size Enum (DDS)
    // Constitution 3.3 compliance: Use theme buttonHeight instead of hardcoded values
    final double height = _resolveHeight(size, theme.buttonHeight) * theme.spacingFactor;
    final double paddingX = _resolvePadding(size, theme.buttonHeight) * theme.spacingFactor;

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
  // Constitution 3.3 compliance: Use theme values instead of hardcoded sizes

  double _resolveHeight(AppButtonSize size, double themeButtonHeight) {
    // Use theme buttonHeight as medium baseline, apply size ratios
    switch (size) {
      case AppButtonSize.small:
        return themeButtonHeight * 0.67; // ~2/3 of medium size
      case AppButtonSize.medium:
        return themeButtonHeight; // Use theme value directly
      case AppButtonSize.large:
        return themeButtonHeight * 1.17; // ~1.17x of medium size
    }
  }

  double _resolvePadding(AppButtonSize size, double themeButtonHeight) {
    // Padding scales with height proportionally
    const baseRatio = 0.5; // Base ratio: padding = height * 0.5
    switch (size) {
      case AppButtonSize.small:
        return (themeButtonHeight * 0.67) * baseRatio;
      case AppButtonSize.medium:
        return themeButtonHeight * baseRatio;
      case AppButtonSize.large:
        return (themeButtonHeight * 1.17) * baseRatio;
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
