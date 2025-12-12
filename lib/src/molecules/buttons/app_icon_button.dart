import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/loading/app_skeleton.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/button_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/button_surface_states.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/surface_style.dart';
import 'app_button.dart'; // Import AppButtonSize enum
import 'enums/button_style_variant.dart';

/// A square or circular icon button with semantic surface variant support.
///
/// Follows the **Data-Driven Strategy**:
/// - Enforces 1:1 aspect ratio.
/// - Visuals driven by [AppSurface] and [ButtonStyleVariant].
///
/// **Style Variant Usage**:
/// - `filled` (default): Solid background with full visual weight
/// - `outline`: Border only, transparent background
/// - `text`: No background or border, icon only
///
/// **Variant Usage Examples**:
/// ```dart
/// // Default filled style (action button)
/// AppIconButton(
///   icon: Icon(Icons.add),
///   onTap: () => addItem(),
/// )
///
/// // Icon-only button (no background, no border)
/// AppIconButton.icon(
///   icon: Icon(Icons.close),
///   onTap: () => dismiss(),
/// )
///
/// // Outline style button
/// AppIconButton.outline(
///   icon: Icon(Icons.settings),
///   onTap: () => openSettings(),
/// )
///
/// // Toggle state with Tonal (e.g., favorite, mute)
/// AppIconButton.toggle(
///   icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
///   isActive: isMuted,
///   onTap: () => toggleMute(),
/// )
/// ```
///
/// **Surface Variants** (semantic color variants):
/// - `base` (default): Standard action button
/// - `tonal`: Toggle/selected states, secondary actions
/// - `highlight`: Critical actions, primary CTAs
/// - `elevated`: Floating/prominent context
/// - `accent`: Decorative or special emphasis
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.variant = SurfaceVariant.base,
    this.size = AppButtonSize.medium,
    this.styleVariant = ButtonStyleVariant.filled,
    this.tooltip,
    super.key,
  });

  // Named constructors for common icon button patterns

  /// Creates a primary icon button with highlight emphasis and filled style.
  ///
  /// Used for the most important icon actions such as primary navigation,
  /// main action triggers, or critical operations.
  const AppIconButton.primary({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.tooltip,
    super.key,
  })  : variant = SurfaceVariant.highlight,
        styleVariant = ButtonStyleVariant.filled;

  /// Creates a secondary icon button with tonal emphasis and filled style.
  ///
  /// Used for important secondary actions that need visual weight but
  /// shouldn't compete with primary actions.
  const AppIconButton.secondary({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.tooltip,
    super.key,
  })  : variant = SurfaceVariant.tonal,
        styleVariant = ButtonStyleVariant.filled;

  /// Creates an outline icon button with base emphasis.
  ///
  /// Used for secondary actions that need clear affordance but minimal
  /// visual weight. Shows border but no background fill.
  const AppIconButton.outline({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.variant = SurfaceVariant.base,
    this.size = AppButtonSize.medium,
    this.tooltip,
    super.key,
  }) : styleVariant = ButtonStyleVariant.outline;

  /// Creates an icon-only button with no background or border.
  ///
  /// Used for minimal visual presence where only the icon should be visible.
  /// Ideal for close buttons, dismiss actions, or inline icon actions.
  const AppIconButton.icon({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.variant = SurfaceVariant.base,
    this.size = AppButtonSize.medium,
    this.tooltip,
    super.key,
  }) : styleVariant = ButtonStyleVariant.text;

  /// Creates a toggle icon button that changes appearance based on active state.
  ///
  /// The [isActive] parameter controls the visual state: active buttons use
  /// tonal emphasis while inactive buttons use base emphasis.
  const AppIconButton.toggle({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.tooltip,
    required bool isActive,
    super.key,
  })  : variant = isActive ? SurfaceVariant.tonal : SurfaceVariant.base,
        styleVariant = ButtonStyleVariant.filled;

  /// Creates a danger icon button for destructive actions.
  ///
  /// Used for destructive operations like delete, remove, or cancel.
  /// Uses accent emphasis to provide appropriate visual warning.
  const AppIconButton.danger({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.size = AppButtonSize.medium,
    this.tooltip,
    super.key,
  })  : variant = SurfaceVariant.accent,
        styleVariant = ButtonStyleVariant.filled;

  /// Creates a small icon button for compact interfaces.
  ///
  /// Used in dense layouts or when multiple icon buttons need to coexist
  /// in limited space.
  const AppIconButton.small({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.variant = SurfaceVariant.base,
    this.styleVariant = ButtonStyleVariant.filled,
    this.tooltip,
    super.key,
  }) : size = AppButtonSize.small;

  /// Creates a large icon button for prominent interfaces.
  ///
  /// Used for primary actions in spacious layouts or when the icon button
  /// is the main interface element.
  const AppIconButton.large({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.variant = SurfaceVariant.base,
    this.styleVariant = ButtonStyleVariant.filled,
    this.tooltip,
    super.key,
  }) : size = AppButtonSize.large;

  final Widget icon;
  final VoidCallback? onTap;
  final bool isLoading;
  final SurfaceVariant variant;
  final AppButtonSize size;

  /// The visual style variant that determines button appearance (filled, outline, text).
  /// Used by the unified ButtonStyle system for consistent theming.
  final ButtonStyleVariant styleVariant;
  final String? tooltip;

  bool get _isEnabled => onTap != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>()!;

    // 1. Resolve exact pixel size based on enum
    // Constitution 3.3 compliance: Use theme buttonHeight instead of hardcoded values
    final double pixelSize =
        _resolveSize(size, theme.buttonHeight) * theme.spacingFactor;

    // 2. Resolve button surface style based on styleVariant
    final buttonSurfaces = _getButtonSurfaces(theme.buttonStyle);
    final baseSurfaceStyle = buttonSurfaces.resolve(
      isEnabled: _isEnabled,
      isPressed: false, // Will be handled by AppSurface interaction
      isHovered: false, // Will be handled by AppSurface interaction
    );

    // 3. Apply semantic variant colors to the base style
    final surfaceStyle =
        _applySemanticVariantColors(baseSurfaceStyle, theme, context);

    Widget content = AppSurface(
      // 4. Use resolved button surface style instead of variant
      style: surfaceStyle,
      interactive: _isEnabled,
      onTap: _isEnabled ? onTap : null,

      // 5. Enforce 1:1 Aspect Ratio
      height: pixelSize,
      width: pixelSize,

      // 6. Centered Content (Loader or Icon)
      child: Center(
        child: isLoading
            ? AppSkeleton.circular(size: pixelSize * 0.5) // Scaled loader
            : icon,
      ),
    );

    // 7. Visual Feedback for Disabled State
    content = Opacity(
      opacity: _isEnabled ? 1.0 : 0.5,
      child: content,
    );

    // 8. Accessibility
    if (tooltip != null) {
      content = Semantics(
        label: tooltip,
        button: true,
        enabled: _isEnabled,
        child: content,
      );
    }

    return content;
  }

  // Constitution 3.3 compliance: Use theme values instead of hardcoded sizes
  double _resolveSize(AppButtonSize size, double themeButtonHeight) {
    // Use theme buttonHeight as medium baseline, apply size ratios
    // Icon buttons maintain 1:1 aspect ratio using height as both width and height
    switch (size) {
      case AppButtonSize.small:
        return themeButtonHeight * 0.67; // ~2/3 of medium size
      case AppButtonSize.medium:
        return themeButtonHeight; // Use theme value directly
      case AppButtonSize.large:
        return themeButtonHeight * 1.17; // ~1.17x of medium size
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
        // For text buttons (icon-only):
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
