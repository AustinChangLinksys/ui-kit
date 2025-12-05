import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Renderer for theme-specific expansion panel styling
///
/// This renderer extracts theme-specific rendering logic to enable
/// the same component to look different across visual languages without
/// modifying the component code (Renderer Pattern).
abstract class ExpansionPanelRenderer {
  /// Get the renderer for the current theme
  static ExpansionPanelRenderer of(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();
    if (theme == null) {
      return _DefaultExpansionPanelRenderer();
    }

    // Detect theme type based on characteristics
    // Glass: high blur, glow effects (surfaceElevated available)
    // Pixel: uses linear animation and snap behavior

    // Check for Pixel theme (uses linear curve, snap animations - 100ms)
    if (theme.expansionPanelStyle.animationDuration == const Duration(milliseconds: 100)) {
      return PixelExpansionPanelRenderer(theme);
    }

    // Check for Glass theme (uses easeInOutCubic - 400ms)
    if (theme.expansionPanelStyle.animationDuration == const Duration(milliseconds: 400)) {
      return GlassExpansionPanelRenderer(theme);
    }

    // Default for all other themes (Flat, Brutal, Neumorphic)
    return _DefaultExpansionPanelRenderer();
  }

  /// Build the expand/collapse indicator icon with theme-specific styling
  Widget buildExpandIcon(
    IconData icon,
    Color color,
    bool isExpanded,
    Duration animationDuration,
  );

  /// Get the background color for expanded content
  Color getExpandedBackgroundColor();

  /// Get animation curve for expand/collapse
  Curve getAnimationCurve();
}

/// Default expansion panel renderer
class _DefaultExpansionPanelRenderer implements ExpansionPanelRenderer {
  @override
  Widget buildExpandIcon(
    IconData icon,
    Color color,
    bool isExpanded,
    Duration animationDuration,
  ) {
    return Icon(
      icon,
      color: color,
    );
  }

  @override
  Color getExpandedBackgroundColor() {
    return Colors.transparent;
  }

  @override
  Curve getAnimationCurve() {
    return Curves.easeInOut;
  }
}

/// Glass theme expansion panel renderer
/// Features: Deepened background on expand (recessed look via AppSurface variant)
class GlassExpansionPanelRenderer implements ExpansionPanelRenderer {
  final AppDesignTheme theme;

  GlassExpansionPanelRenderer(this.theme);

  @override
  Widget buildExpandIcon(
    IconData icon,
    Color color,
    bool isExpanded,
    Duration animationDuration,
  ) {
    return Icon(
      icon,
      color: color,
    );
  }

  @override
  Color getExpandedBackgroundColor() {
    // Glass theme uses a slightly elevated surface for expanded content
    return theme.surfaceElevated.backgroundColor;
  }

  @override
  Curve getAnimationCurve() {
    return Curves.easeInOutCubic;
  }
}

/// Pixel theme expansion panel renderer
/// Features: Pixel-perfect expand/collapse indicator animation
class PixelExpansionPanelRenderer implements ExpansionPanelRenderer {
  final AppDesignTheme theme;

  PixelExpansionPanelRenderer(this.theme);

  @override
  Widget buildExpandIcon(
    IconData icon,
    Color color,
    bool isExpanded,
    Duration animationDuration,
  ) {
    // Pixel theme uses simple discrete rotation without easing
    return Icon(
      icon,
      color: color,
    );
  }

  @override
  Color getExpandedBackgroundColor() {
    // Pixel theme uses distinct contrast
    return theme.surfaceHighlight.backgroundColor;
  }

  @override
  Curve getAnimationCurve() {
    return Curves.linear;
  }
}
