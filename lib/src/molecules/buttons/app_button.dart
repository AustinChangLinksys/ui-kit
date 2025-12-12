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
    this.variant = SurfaceVariant
        .highlight, // Use standard naming variant (backward compatibility)
    this.size = AppButtonSize.medium, // Add size control
    this.styleVariant = ButtonStyleVariant.filled, // New unified style system
    this.iconPosition = AppButtonIconPosition.leading, // Icon position control
    super.key,
  });

  // Named constructors for common button patterns

  /// Creates a primary filled button with highlight emphasis.
  ///
  /// This is the most prominent button style, typically used for main call-to-action
  /// buttons such as "Save", "Submit", or "Continue".
  const AppButton.primary({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  })  : variant = SurfaceVariant.highlight,
        styleVariant = ButtonStyleVariant.filled;

  /// Creates a primary outline button with highlight emphasis.
  ///
  /// Used for secondary actions that still need prominence but shouldn't compete
  /// with the main primary action.
  const AppButton.primaryOutline({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  })  : variant = SurfaceVariant.highlight,
        styleVariant = ButtonStyleVariant.outline;

  /// Creates a secondary filled button with tonal emphasis.
  ///
  /// Used for important secondary actions that need visual weight but are
  /// less prominent than primary buttons.
  const AppButton.secondary({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  })  : variant = SurfaceVariant.tonal,
        styleVariant = ButtonStyleVariant.filled;

  /// Creates a secondary outline button with tonal emphasis.
  ///
  /// Used for secondary actions that need clear affordance but minimal
  /// visual weight in the interface hierarchy.
  const AppButton.secondaryOutline({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  })  : variant = SurfaceVariant.tonal,
        styleVariant = ButtonStyleVariant.outline;

  /// Creates a tertiary filled button with base emphasis.
  ///
  /// Used for low-priority actions that still benefit from a subtle background.
  const AppButton.tertiary({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  })  : variant = SurfaceVariant.base,
        styleVariant = ButtonStyleVariant.filled;

  /// Creates a text-only button with base emphasis.
  ///
  /// Used for the lowest priority actions such as "Cancel", "Skip", or
  /// tertiary navigation links.
  const AppButton.text({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  })  : variant = SurfaceVariant.base,
        styleVariant = ButtonStyleVariant.text;

  /// Creates a danger filled button with accent emphasis.
  ///
  /// Used for destructive actions such as "Delete", "Remove", or "Cancel Subscription".
  /// Provides appropriate visual warning for irreversible actions.
  const AppButton.danger({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  })  : variant = SurfaceVariant.accent,
        styleVariant = ButtonStyleVariant.filled;

  /// Creates a danger outline button with accent emphasis.
  ///
  /// Used for destructive actions that need confirmation or are reversible.
  /// Less visually aggressive than filled danger buttons.
  const AppButton.dangerOutline({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  })  : variant = SurfaceVariant.accent,
        styleVariant = ButtonStyleVariant.outline;

  /// Creates a small button with the specified style variant.
  ///
  /// Used in compact interfaces or when multiple actions need to fit
  /// in limited space without overwhelming the interface.
  const AppButton.small({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.variant = SurfaceVariant.highlight,
    this.styleVariant = ButtonStyleVariant.filled,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  }) : size = AppButtonSize.small;

  /// Creates a large button with the specified style variant.
  ///
  /// Used for prominent call-to-action buttons in spacious layouts
  /// or when the button is the primary interface element.
  const AppButton.large({
    required this.label,
    this.onTap,
    this.icon,
    this.isLoading = false,
    this.variant = SurfaceVariant.highlight,
    this.styleVariant = ButtonStyleVariant.filled,
    this.iconPosition = AppButtonIconPosition.leading,
    super.key,
  }) : size = AppButtonSize.large;

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

  /// The visual style variant that determines button appearance (filled, outline, text).
  /// Used by the unified ButtonStyle system for consistent theming.
  final ButtonStyleVariant styleVariant;

  /// Controls the position of icons relative to button text.
  final AppButtonIconPosition iconPosition;

  bool get _isEnabled => onTap != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    // Use extension to get Theme (assuming you have added this)
    // Or use Theme.of(context).extension<AppDesignTheme>()!
    final theme = Theme.of(context).extension<AppDesignTheme>()!;

    // 1. Determine height and padding based on Size Enum (DDS)
    // Constitution 3.3 compliance: Use theme buttonHeight instead of hardcoded values
    final double height =
        _resolveHeight(size, theme.buttonHeight) * theme.spacingFactor;
    final double paddingX =
        _resolvePadding(size, theme.buttonHeight) * theme.spacingFactor;

    // 2. Resolve button surface style based on styleVariant and state
    final buttonSurfaces = _getButtonSurfaces(theme.buttonStyle);
    final baseSurfaceStyle = buttonSurfaces.resolve(
      isEnabled: _isEnabled,
      isPressed: false, // Will be handled by AppSurface interaction
      isHovered: false, // Will be handled by AppSurface interaction
    );

    // 3. Apply semantic variant colors to the base style
    final surfaceStyle =
        _applySemanticVariantColors(baseSurfaceStyle, theme, context);

    // 4. Handle Disabled state (Opacity)
    return Opacity(
      opacity: _isEnabled
          ? 1.0
          : 1.0, // No opacity, let button styles handle disabled state
      child: AppSurface(
        // 5. Use resolved button surface style instead of variant
        style: surfaceStyle,
        interactive: _isEnabled, // Enable physical interaction (Scale/Glow)
        onTap: _isEnabled ? onTap : null,
        height: height,
        // 6. Buttons need horizontal Padding
        padding: EdgeInsets.symmetric(horizontal: paddingX),

        child: Row(
          mainAxisSize:
              MainAxisSize.min, // Shrink-wrap to prevent unbounded constraints
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading)
              // Show theme-aware loader when loading
              SizedBox(
                width: height * 0.6, // Larger size for better visibility
                height: height * 0.6,
                child: const AppLoader(
                  variant: LoaderVariant.circular,
                  value: null, // Indeterminate animation
                ),
              )
            else ...[
              if (icon != null) ...[
                icon!,
                SizedBox(width: 8 * theme.spacingFactor),
              ],
              Flexible(
                child: AppText(
                  label,
                  variant: _resolveTextVariant(size),
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
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

  /// Get the appropriate ButtonSurfaceStates based on the button's styleVariant
  ButtonSurfaceStates _getButtonSurfaces(AppButtonStyle buttonStyle) {
    switch (styleVariant) {
      case ButtonStyleVariant.filled:
        return buttonStyle.filledSurfaces;
      case ButtonStyleVariant.outline:
        return buttonStyle.outlineSurfaces;
      case ButtonStyleVariant.text:
        return buttonStyle.textSurfaces;
    }
  }

  /// Apply semantic variant colors to the base surface style
  ///
  /// This method takes the base button surface style (from filled/outline/text)
  /// and adapts the colors based on the semantic variant (highlight/tonal/base)
  /// to create visual distinction between Primary and Secondary buttons.
  ///
  /// For text and outline buttons, we use ColorScheme colors directly:
  /// - highlight → primary
  /// - tonal → secondary
  /// - accent → tertiary
  /// - base/elevated → onSurface
  SurfaceStyle _applySemanticVariantColors(
    SurfaceStyle baseStyle,
    AppDesignTheme theme,
    BuildContext context,
  ) {
    // Get ColorScheme for text/outline button content colors
    final colorScheme = Theme.of(context).colorScheme;

    // Get the appropriate surface style based on semantic variant
    late final SurfaceStyle targetSurface;
    switch (variant) {
      case SurfaceVariant.highlight:
        targetSurface = theme.surfaceHighlight;
        break;
      case SurfaceVariant.tonal:
        targetSurface = theme.surfaceSecondary;
        break;
      case SurfaceVariant.base:
        targetSurface = theme.surfaceBase;
        break;
      case SurfaceVariant.elevated:
        targetSurface = theme.surfaceElevated;
        break;
      case SurfaceVariant.accent:
        targetSurface = theme.surfaceTertiary;
        break;
    }

    // Resolve content color for non-filled styles using ColorScheme
    Color resolveSchemeColor() {
      switch (variant) {
        case SurfaceVariant.highlight:
          return colorScheme.primary;
        case SurfaceVariant.tonal:
          return colorScheme.secondary;
        case SurfaceVariant.accent:
          return colorScheme.tertiary;
        case SurfaceVariant.base:
        case SurfaceVariant.elevated:
          return colorScheme.onSurface;
      }
    }

    switch (styleVariant) {
      case ButtonStyleVariant.filled:
        // For filled buttons, use the surface colors directly
        // backgroundColor = primary/secondary/etc, contentColor = onPrimary/onSecondary/etc
        return baseStyle.copyWith(
          backgroundColor: targetSurface.backgroundColor,
          borderColor: targetSurface.borderColor,
          contentColor: targetSurface.contentColor,
        );

      case ButtonStyleVariant.outline:
        // For outline buttons:
        // - Border and content use the brand color (primary/secondary)
        // - Background is transparent or very subtle tint
        final schemeColor = resolveSchemeColor();
        Color? adaptedBackgroundColor;
        if (targetSurface.backgroundColor.a > 0.05) {
          adaptedBackgroundColor =
              targetSurface.backgroundColor.withValues(alpha: 0.05);
        } else {
          adaptedBackgroundColor = baseStyle.backgroundColor;
        }

        return baseStyle.copyWith(
          backgroundColor: adaptedBackgroundColor,
          borderColor: schemeColor,
          contentColor: schemeColor,
        );

      case ButtonStyleVariant.text:
        // For text buttons:
        // - Content uses the brand color directly (primary/secondary)
        // - No background or border
        final schemeColor = resolveSchemeColor();

        return baseStyle.copyWith(
          contentColor: schemeColor,
          backgroundColor: baseStyle.backgroundColor,
          borderColor: baseStyle.borderColor,
        );
    }
  }
}
