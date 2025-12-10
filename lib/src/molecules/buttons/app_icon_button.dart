import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/loading/app_skeleton.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
import 'app_button.dart'; // Import AppButtonSize enum
import 'enums/button_style_variant.dart';

/// A square or circular icon button with semantic surface variant support.
///
/// Follows the **Data-Driven Strategy**:
/// - Enforces 1:1 aspect ratio.
/// - Visuals driven by [AppSurface] and [SurfaceVariant].
///
/// **Variant Usage Examples**:
/// ```dart
/// // Default base style (action button)
/// AppIconButton(
///   icon: Icon(Icons.add),
///   onTap: () => addItem(),
/// )
///
/// // Toggle state with Tonal (e.g., favorite, mute)
/// AppIconButton(
///   icon: Icon(isMuted ? Icons.volume_off : Icons.volume_up),
///   variant: isMuted ? SurfaceVariant.tonal : SurfaceVariant.base,
///   onTap: () => toggleMute(),
/// )
///
/// // Highlight for critical action (delete)
/// AppIconButton(
///   icon: Icon(Icons.delete),
///   variant: SurfaceVariant.highlight, // Use semantic variant for visual hierarchy
///   onTap: () => deleteItem(),
/// )
/// ```
///
/// **Surface Variants**:
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
    this.variant = SurfaceVariant.base, // Standardized naming (backward compatibility)
    this.size = AppButtonSize.medium, // Standardized sizing
    this.styleVariant = ButtonStyleVariant.filled, // New unified style system
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
  }) : variant = SurfaceVariant.highlight,
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
  }) : variant = SurfaceVariant.tonal,
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

  /// Creates a ghost (text-style) icon button with minimal visual presence.
  ///
  /// Used for low-priority actions or when the icon button should blend
  /// into the background until interacted with.
  const AppIconButton.ghost({
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
  }) : variant = isActive ? SurfaceVariant.tonal : SurfaceVariant.base,
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
  }) : variant = SurfaceVariant.accent,
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
    final double pixelSize = _resolveSize(size, theme.buttonHeight) * theme.spacingFactor;

    Widget content = AppSurface(
      // 2. IoC: Pass variant directly, let Surface decide look
      variant: variant,
      interactive: _isEnabled,
      onTap: _isEnabled ? onTap : null,
      
      // 3. Enforce 1:1 Aspect Ratio
      height: pixelSize,
      width: pixelSize,
      
      // 4. Centered Content (Loader or Icon)
      child: Center(
        child: isLoading
            ? AppSkeleton.circular(size: pixelSize * 0.5) // Scaled loader
            : icon,
      ),
    );

    // 5. Visual Feedback for Disabled State
    content = Opacity(
      opacity: _isEnabled ? 1.0 : 0.5,
      child: content,
    );

    // 6. Accessibility
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
}