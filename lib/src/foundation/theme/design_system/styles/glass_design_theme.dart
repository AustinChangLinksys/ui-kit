import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/app_bar_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/dialog_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/app_menu_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class GlassDesignTheme extends AppDesignTheme {
  const GlassDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.surfaceSecondary,
    required super.surfaceTertiary,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
    required super.toggleStyle,
    required super.skeletonStyle,
    required super.buttonHeight,
    required super.navigationStyle,
    required super.inputStyle,
    required super.loaderStyle,
    required super.toastStyle,
    required super.dividerStyle,
    required super.networkInputStyle,
    required super.layoutSpec,
    required super.appBarStyle,
    required super.menuStyle,
    required super.dialogStyle,
  });

  // Light Mode (Liquid Water)
  factory GlassDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final glassBaseColor = scheme.surface.withValues(alpha: 0.02);

    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: glassBaseColor,
        borderColor: scheme.outline.withValues(alpha: 0.5),
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: -5,
          )
        ],
        blurStrength: 25.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.1),
        borderColor: scheme.outline.withValues(alpha: 0.6),
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.1),
            blurRadius: 30,
            offset: const Offset(0, 15),
          )
        ],
        blurStrength: 35.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.15),
        borderColor: scheme.outline.withValues(alpha: 0.5),
        borderWidth: 1.5,
        borderRadius: 24.0,
        blurStrength: 20.0,
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.25),
            blurRadius: 12,
            spreadRadius: -2,
            offset: const Offset(0, 4),
          )
        ],
        contentColor: scheme.primary,
        interaction: const InteractionSpec(
          pressedScale: 0.92,
          pressedOpacity: 0.8,
          hoverOpacity: 0.9,
          pressedOffset: Offset.zero,
        ),
      ),
      // Secondary (Tonal) Surface - Medium emphasis, selected/active states
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.secondary.withValues(alpha: 0.12),
        borderColor: scheme.outline.withValues(alpha: 0.4),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 15.0,
        shadows: [
          BoxShadow(
            color: scheme.secondary.withValues(alpha: 0.1),
            blurRadius: 10,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: scheme.secondary.withValues(alpha: 0.8),
      ),
      // Tertiary (Accent) Surface - Decorative or special emphasis
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: 0.15),
        borderColor: scheme.tertiary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 12.0,
        shadows: [
          BoxShadow(
            color: scheme.tertiary.withValues(alpha: 0.1),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: scheme.tertiary,
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.primary.withValues(alpha: 0.02),
        highlightColor: scheme.primary.withValues(alpha: 0.12),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 24.0,
      ),
      toggleStyle: ToggleStyle(
        activeType: ToggleContentType.grip,
        inactiveType: ToggleContentType.grip,
        activeTrackStyle: SurfaceStyle(
          backgroundColor: scheme.primary.withValues(alpha: 0.5),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3), blurRadius: 12)
          ],
          blurStrength: 15.0,
          contentColor: scheme.onPrimary,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.1),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: scheme.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.9),
          borderColor: scheme.outline,
          borderWidth: 0.0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          blurStrength: 5.0,
          contentColor: scheme.primary,
        ),
      ),
      inputStyle: InputStyle(
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.outline.withValues(alpha: 0.3), // Required
          contentColor: scheme.onSurface, // Required
          borderWidth: 0,
          borderRadius: 0,
          blurStrength: 0,
          shadows: const [],
          customBorder: Border(
              bottom: BorderSide(
                  color: scheme.outline.withValues(alpha: 0.3), width: 1.5)),
        ),
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.1),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          contentColor: scheme.onSurface,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: [
            BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.05), blurRadius: 8)
          ],
          blurStrength: 10.0,
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.05),
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary.withValues(alpha: 0.6),
          contentColor: scheme.onSurface,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3), blurRadius: 12)
          ],
          blurStrength: 0,
        ),
        errorModifier: SurfaceStyle(
          backgroundColor: scheme.error.withValues(alpha: 0.05),
          borderColor: scheme.error,
          contentColor: scheme.error,
          blurStrength: 0,
        ),
      ),
      loaderStyle: LoaderStyle(
        type: LoaderType.circular,
        color: scheme.primary,
        strokeWidth: 4.0,
        size: 48.0,
        period: const Duration(milliseconds: 1500),
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.6),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(16),
        backgroundColor: scheme.surface.withValues(alpha: 0.6),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: scheme.onSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: scheme.outline.withValues(alpha: 0.3),
        thickness: 1.0,
        glowStrength: 6.0,
        pattern: DividerPattern.solid,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.glowingDot,
        macAddressSeparator: ':',
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
      spacingFactor: 1.0,
      buttonHeight: 44.0,
      navigationStyle: const NavigationStyle(
        height: 72.0,
        isFloating: true,
        floatingMargin: 24.0,
        itemSpacing: 16.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 20.0,
        marginTablet: 32.0,
        marginDesktop: 80.0,
        gutterMobile: 20.0,
        gutterTablet: 24.0,
        gutterDesktop: 32.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles (Glass Light)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.6),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 25.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.outline.withValues(alpha: 0.2),
          thickness: 1.0,
          pattern: DividerPattern.solid,
          glowStrength: 4.0,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 25.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.7),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.1),
              blurRadius: 20,
              spreadRadius: -5,
            ),
          ],
          blurStrength: 20.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.primary.withValues(alpha: 0.1),
          borderColor: scheme.primary.withValues(alpha: 0.2),
          borderWidth: 1.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.8),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          borderWidth: 1.5,
          borderRadius: 24.0,
          shadows: [
            BoxShadow(
              color: scheme.primary.withValues(alpha: 0.15),
              blurRadius: 30,
              spreadRadius: -5,
            ),
          ],
          blurStrength: 30.0,
          contentColor: scheme.onSurface,
        ),
        barrierColor: Colors.black.withValues(alpha: 0.3),
        barrierBlur: 10.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 12.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
    );
  }

  factory GlassDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.shadow.withValues(alpha: 0.3),
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.3),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
        blurStrength: 25.0,
        contentColor: scheme.onSurface,
        texture: AppTextures.noise, // Demonstration
        textureOpacity: 0.05,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.05),
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(color: scheme.shadow.withValues(alpha: 0.5), blurRadius: 32)
        ],
        blurStrength: 35.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.primary.withValues(alpha: 0.2),
        borderColor: scheme.primary.withValues(alpha: 0.4),
        borderWidth: 1.5,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
              color: scheme.primary.withValues(alpha: 0.2),
              blurRadius: 16,
              spreadRadius: 2)
        ],
        blurStrength: 20.0,
        contentColor: scheme.onPrimary,
        interaction: const InteractionSpec(
          pressedScale: 0.92,
          pressedOpacity: 0.8,
          hoverOpacity: 0.9,
          pressedOffset: Offset.zero,
        ),
        texture: AppTextures.pixelGrid, // Demonstration
        textureOpacity: 0.08,
      ),
      // Secondary (Tonal) Surface - Medium emphasis, selected/active states (Dark mode)
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.secondary.withValues(alpha: 0.25),
        borderColor: scheme.outline.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 15.0,
        shadows: [
          BoxShadow(
            color: scheme.secondary.withValues(alpha: 0.15),
            blurRadius: 10,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: scheme.onSecondary.withValues(alpha: 0.8),
      ),
      // Tertiary (Accent) Surface - Decorative or special emphasis (Dark mode)
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: 0.2),
        borderColor: scheme.tertiary.withValues(alpha: 0.3),
        borderWidth: 1.0,
        borderRadius: 24.0,
        blurStrength: 12.0,
        shadows: [
          BoxShadow(
            color: scheme.tertiary.withValues(alpha: 0.15),
            blurRadius: 8,
            spreadRadius: -2,
            offset: const Offset(0, 2),
          )
        ],
        contentColor: scheme.tertiary,
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.primary.withValues(alpha: 0.05),
        highlightColor: scheme.primary.withValues(alpha: 0.2),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 24.0,
      ),
      toggleStyle: ToggleStyle(
        activeType: ToggleContentType.grip,
        inactiveType: ToggleContentType.grip,
        activeTrackStyle: SurfaceStyle(
          backgroundColor: scheme.primary.withValues(alpha: 0.4),
          borderColor: scheme.outline.withValues(alpha: 0.1),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.2), blurRadius: 12)
          ],
          blurStrength: 10.0,
          contentColor: scheme.onPrimary,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.05),
          borderColor: scheme.outline.withValues(alpha: 0.1),
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: scheme.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: scheme.surface.withValues(alpha: 0.9),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.5),
                blurRadius: 4,
                offset: const Offset(0, 2))
          ],
          blurStrength: 5.0,
          contentColor: scheme.primary,
        ),
      ),
      inputStyle: InputStyle(
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.outline.withValues(alpha: 0.3), // Required
          contentColor: scheme.onSurface, // Required
          borderWidth: 0,
          borderRadius: 0,
          blurStrength: 0,
          shadows: const [],
          customBorder: Border(
              bottom: BorderSide(
                  color: scheme.outline.withValues(alpha: 0.3), width: 1.5)),
        ),
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.1),
          borderColor: scheme.outline.withValues(alpha: 0.3),
          contentColor: scheme.onSurface,
          borderWidth: 1.0,
          borderRadius: 8.0,
          shadows: [
            BoxShadow(
                color: scheme.shadow.withValues(alpha: 0.05), blurRadius: 8)
          ],
          blurStrength: 10.0,
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.05),
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 8.0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary.withValues(alpha: 0.6),
          contentColor: scheme.onSurface,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3), blurRadius: 12)
          ],
          blurStrength: 0,
        ),
        errorModifier: SurfaceStyle(
          backgroundColor: scheme.error.withValues(alpha: 0.05),
          borderColor: scheme.error,
          contentColor: scheme.error,
          blurStrength: 0,
        ),
      ),
      loaderStyle: LoaderStyle(
        type: LoaderType.circular,
        color: scheme.primary,
        strokeWidth: 4.0,
        size: 48.0,
        period: const Duration(milliseconds: 1500),
        shadows: [
          BoxShadow(
            color: scheme.primary.withValues(alpha: 0.6),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        margin: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(16),
        backgroundColor: scheme.surface.withValues(alpha: 0.6),
        textStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: scheme.onSurface),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: scheme.outline.withValues(alpha: 0.3),
        thickness: 1.0,
        glowStrength: 6.0,
        pattern: DividerPattern.solid,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.glowingDot,
        macAddressSeparator: ':',
      ),
      typography: const TypographySpec(),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 500),
        curve: Curves.fastLinearToSlowEaseIn,
      ),
      spacingFactor: 1.0,
      buttonHeight: 44.0,
      navigationStyle: const NavigationStyle(
        height: 72.0,
        isFloating: true,
        floatingMargin: 24.0,
        itemSpacing: 16.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 20.0,
        marginTablet: 32.0,
        marginDesktop: 80.0,
        gutterMobile: 20.0,
        gutterTablet: 24.0,
        gutterDesktop: 32.0,
      ),

      // Phase 2: AppBar, Menu, Dialog styles (Glass Dark)
      appBarStyle: AppBarStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.shadow.withValues(alpha: 0.4),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 1.0,
          borderRadius: 0.0,
          shadows: const [],
          blurStrength: 25.0,
          contentColor: scheme.onSurface,
        ),
        dividerStyle: DividerStyle(
          color: scheme.outline.withValues(alpha: 0.15),
          thickness: 1.0,
          pattern: DividerPattern.solid,
          glowStrength: 4.0,
        ),
        height: 56.0,
        collapsedHeight: 56.0,
        expandedHeight: 200.0,
        flexibleSpaceBlur: 25.0,
      ),
      menuStyle: AppMenuStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.shadow.withValues(alpha: 0.6),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 1.0,
          borderRadius: 16.0,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.4),
              blurRadius: 24,
            ),
          ],
          blurStrength: 20.0,
          contentColor: scheme.onSurface,
        ),
        itemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        itemHoverStyle: SurfaceStyle(
          backgroundColor: scheme.primary.withValues(alpha: 0.15),
          borderColor: scheme.primary.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.onSurface,
        ),
        destructiveItemStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          borderWidth: 0.0,
          borderRadius: 8.0,
          blurStrength: 0.0,
          contentColor: scheme.error,
        ),
      ),
      dialogStyle: DialogStyle(
        containerStyle: SurfaceStyle(
          backgroundColor: scheme.shadow.withValues(alpha: 0.7),
          borderColor: scheme.outline.withValues(alpha: 0.2),
          borderWidth: 1.5,
          borderRadius: 24.0,
          shadows: [
            BoxShadow(
              color: scheme.shadow.withValues(alpha: 0.5),
              blurRadius: 32,
            ),
          ],
          blurStrength: 30.0,
          contentColor: scheme.onSurface,
        ),
        barrierColor: Colors.black.withValues(alpha: 0.4),
        barrierBlur: 10.0,
        maxWidth: 400.0,
        padding: const EdgeInsets.all(24.0),
        buttonSpacing: 12.0,
        buttonAlignment: MainAxisAlignment.end,
      ),
    );
  }
}