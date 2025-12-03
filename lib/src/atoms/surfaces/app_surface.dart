import 'dart:ui'; // For ImageFilter
import 'package:flutter/material.dart';
import '../../foundation/theme/design_system/app_design_theme.dart';
import '../../foundation/theme/design_system/specs/surface_style.dart';
import '../../foundation/theme/design_system/specs/interaction_spec.dart';

/// The possible semantic roles for a surface.
enum SurfaceVariant {
  base,       // Default background (Cards, Panels)
  elevated,   // Floating elements (Dialogs, Tooltips)
  highlight,  // Primary actions (Buttons, Active states)
  tonal,      // Secondary actions (Selected filters, Tonal buttons)
  accent,     // Decorative or special emphasis
}

/// The fundamental building block of the UI Kit.
///
/// [AppSurface] is responsible for:
/// 1. Rendering visual styles (Border, Shadow, Blur, Color) defined by the Theme.
/// 2. Handling physical interactions (Scale, Glow, Offset) defined by [InteractionSpec].
/// 3. Cascading content colors to child Text and Icons.
class AppSurface extends StatefulWidget {
  const AppSurface({
    super.key,
    required this.child,
    this.style,
    this.variant = SurfaceVariant.base,
    this.onTap,
    this.interactive = false,
    this.width,
    this.height,
    this.padding,
    this.margin, // Note: Prefer using AppGap or wrapping Padding externally
    this.shape = BoxShape.rectangle,
  });

  /// The content of the surface.
  final Widget child;

  /// Explicit style override. If provided, it takes precedence over [variant].
  final SurfaceStyle? style;

  /// The semantic variant to use from the current [AppDesignTheme].
  final SurfaceVariant variant;

  /// Callback when the surface is tapped.
  /// If provided, [interactive] is automatically treated as true.
  final VoidCallback? onTap;

  /// Whether to enable interaction physics (Scale/Glow/Offset).
  /// Defaults to true if [onTap] is provided.
  final bool interactive;

  /// Fixed width (optional).
  final double? width;

  /// Fixed height (optional).
  final double? height;

  /// Inner padding.
  final EdgeInsetsGeometry? padding;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// The geometric shape of the surface (Rectangle or Circle).
  final BoxShape shape;

  @override
  State<AppSurface> createState() => _AppSurfaceState();
}

class _AppSurfaceState extends State<AppSurface> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    // 1. Access the Design System Theme
    final theme = Theme.of(context).extension<AppDesignTheme>();

    // Fallback for robust previewing if theme is missing
    if (theme == null) {
      return Container(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        margin: widget.margin,
        child: widget.child,
      );
    }

    // 2. Resolve the effective style (Override > Variant)
    final effectiveStyle = widget.style ?? _resolveStyle(theme, widget.variant);
    
    // 3. Resolve Interaction Physics
    final isInteractive = widget.interactive || widget.onTap != null;
    final physics = effectiveStyle.interaction ?? const InteractionSpec();
    
    // Calculate active physics values
    final double scale = (isInteractive && _isPressed) ? physics.pressedScale : 1.0;
    final double opacity = (isInteractive && _isPressed) ? physics.pressedOpacity : 1.0;
    final Offset offset = (isInteractive && _isPressed) ? physics.pressedOffset : Offset.zero;

    // 4. Build the Render Tree
    // Structure: Padding (Margin) -> Gesture -> Transform (Offset) -> Opacity -> Scale -> Container -> Clip (Blur) -> Content
    
    Widget content = AnimatedContainer(
      duration: theme.animation.duration,
      curve: theme.animation.curve,
      width: widget.width,
      height: widget.height,
      padding: widget.padding ?? EdgeInsets.zero,
      decoration: BoxDecoration(
        color: effectiveStyle.backgroundColor,
        // Border Logic: Prefer customBorder (e.g. Underline), fallback to uniform border
        border: effectiveStyle.customBorder ?? Border.all(
          color: effectiveStyle.borderColor,
          width: effectiveStyle.borderWidth,
          // Brutalism might use 0 width but valid color, checking width > 0 is safer
          style: effectiveStyle.borderWidth > 0 ? BorderStyle.solid : BorderStyle.none,
        ),
        // Shape Logic: Circles cannot have borderRadius
        borderRadius: widget.shape == BoxShape.circle 
            ? null 
            : BorderRadius.circular(effectiveStyle.borderRadius),
        boxShadow: effectiveStyle.shadows,
        shape: widget.shape,
      ),
      // ✨ Inject Content Color to children (Text & Icons)
      child: IconTheme(
        data: IconThemeData(
          color: effectiveStyle.contentColor,
          size: 24.0, // Default icon size
        ),
        child: DefaultTextStyle.merge(
          style: TextStyle(
            color: effectiveStyle.contentColor,
            fontFamily: theme.typography.bodyFontFamily,
          ),
          child: widget.child,
        ),
      ),
    );

    // 5. Apply Backdrop Blur (Glassmorphism)
    if (effectiveStyle.blurStrength > 0) {
      content = ClipRRect(
        // Ensure clip matches the shape
        borderRadius: widget.shape == BoxShape.circle
            ? BorderRadius.circular(9999) // Hack for circle clip
            : BorderRadius.circular(effectiveStyle.borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: effectiveStyle.blurStrength,
            sigmaY: effectiveStyle.blurStrength,
          ),
          child: content,
        ),
      );
    }

    // 6. Apply Physics & Gesture
    // We wrap everything in gesture detector to handle state
    if (isInteractive) {
      content = GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        behavior: HitTestBehavior.opaque, // Ensure clicks are caught even on transparent areas
        child: AnimatedScale(
          scale: scale,
          duration: theme.animation.duration,
          curve: theme.animation.curve,
          child: AnimatedOpacity(
            opacity: opacity,
            duration: theme.animation.duration,
            curve: theme.animation.curve,
            child: Transform.translate(
              offset: offset,
              child: content,
            ),
          ),
        ),
      );
    }

    // 7. Apply External Margin
    if (widget.margin != null) {
      content = Padding(padding: widget.margin!, child: content);
    }

    return content;
  }

  /// Resolves the correct [SurfaceStyle] based on the semantic [variant].
  ///
  /// **Variant Resolution**:
  /// - `base`: Default surface for low-priority content (cards, panels, neutral areas)
  /// - `elevated`: Floating surfaces for high-priority content (dialogs, tooltips, modals)
  /// - `highlight`: Maximum-priority interactive elements (primary buttons, CTAs, critical actions)
  /// - `tonal` (secondary): Medium-priority surfaces for selected/active states (filter tags, navigation selection)
  /// - `accent` (tertiary): Decorative or special emphasis (badges, accent indicators)
  ///
  /// Each variant is rendered with design-language-specific physics:
  /// - Glass: Blur strength and alpha transparency
  /// - Brutal: Solid borders and geometric forms
  /// - Flat: Material 3 color palette
  /// - Neumorphic: Shallow convex shadows and soft forms
  /// - Pixel: Grid patterns and retro aesthetics
  SurfaceStyle _resolveStyle(AppDesignTheme theme, SurfaceVariant variant) {
    switch (variant) {
      case SurfaceVariant.base:
        return theme.surfaceBase;
      case SurfaceVariant.elevated:
        return theme.surfaceElevated;
      case SurfaceVariant.highlight:
        return theme.surfaceHighlight;
      case SurfaceVariant.tonal:
        return theme.surfaceSecondary;
      case SurfaceVariant.accent:
        return theme.surfaceTertiary;
    }
  }
}