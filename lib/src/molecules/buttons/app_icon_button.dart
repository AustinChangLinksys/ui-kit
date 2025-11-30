import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/loading/app_skeleton.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
import 'app_button.dart'; // Import AppButtonSize enum

/// A square or circular icon button based on the theme.
///
/// Follows the **Data-Driven Strategy**:
/// - Enforces 1:1 aspect ratio.
/// - Visuals driven by [AppSurface] and [SurfaceVariant].
class AppIconButton extends StatelessWidget {
  const AppIconButton({
    required this.icon,
    this.onTap,
    this.isLoading = false,
    this.variant = SurfaceVariant.base, // Standardized naming
    this.size = AppButtonSize.medium,   // Standardized sizing
    this.tooltip,
    super.key,
  });

  final Widget icon;
  final VoidCallback? onTap;
  final bool isLoading;
  final SurfaceVariant variant;
  final AppButtonSize size;
  final String? tooltip;

  bool get _isEnabled => onTap != null && !isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    
    // 1. Resolve exact pixel size based on enum
    final double pixelSize = _resolveSize(size) * theme.spacingFactor;

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

  double _resolveSize(AppButtonSize size) {
    switch (size) {
      case AppButtonSize.small: return 32.0;
      case AppButtonSize.medium: return 48.0;
      case AppButtonSize.large: return 56.0;
    }
  }
}