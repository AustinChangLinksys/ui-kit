import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/divider_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/layout_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/navigation_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/network_input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/toggle_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class GlassDesignTheme extends AppDesignTheme {
  const GlassDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
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
  });

  // Light Mode (Liquid Water)
  factory GlassDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final glassBaseColor = scheme.surface.withValues(alpha: 0.02);

    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: glassBaseColor,
        borderColor: Colors.white.withValues(alpha: 0.5),
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
        backgroundColor: Colors.white.withValues(alpha: 0.1),
        borderColor: Colors.white.withValues(alpha: 0.6),
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
        borderColor: Colors.white.withValues(alpha: 0.5),
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
          borderColor: Colors.white.withValues(alpha: 0.2),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.3), blurRadius: 12)
          ],
          blurStrength: 15.0,
          contentColor: Colors.white,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: Colors.grey.withValues(alpha: 0.1),
          borderColor: Colors.white.withValues(alpha: 0.3),
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: scheme.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: Colors.white.withValues(alpha: 0.9),
          borderColor: Colors.white,
          borderWidth: 0.0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
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
          borderColor: Colors.white.withValues(alpha: 0.3), // Required
          contentColor: scheme.onSurface, // Required
          borderWidth: 0,
          borderRadius: 0,
          blurStrength: 0,
          shadows: const [],
          customBorder: Border(
              bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.3), width: 1.5)),
        ),
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: Colors.white.withValues(alpha: 0.1),
          borderColor: Colors.white.withValues(alpha: 0.3),
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
          backgroundColor: Colors.white.withValues(alpha: 0.05),
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
        type: LoaderType.pulse,
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
        backgroundColor: Colors.white.withValues(alpha: 0.6),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: Colors.white.withValues(alpha: 0.3),
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
    );
  }

  factory GlassDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    return GlassDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: Colors.black.withValues(alpha: 0.3),
        borderColor: Colors.white.withValues(alpha: 0.2),
        borderWidth: 1.5,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 24,
            spreadRadius: 0,
          ),
        ],
        blurStrength: 25.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: Colors.white.withValues(alpha: 0.05),
        borderColor: Colors.white.withValues(alpha: 0.2),
        borderWidth: 1.0,
        borderRadius: 24.0,
        shadows: [
          BoxShadow(color: Colors.black.withValues(alpha: 0.5), blurRadius: 32)
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
          borderColor: Colors.white.withValues(alpha: 0.1),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.2), blurRadius: 12)
          ],
          blurStrength: 10.0,
          contentColor: Colors.white,
        ),
        inactiveTrackStyle: SurfaceStyle(
          backgroundColor: Colors.white.withValues(alpha: 0.05),
          borderColor: Colors.white.withValues(alpha: 0.1),
          borderWidth: 1.0,
          borderRadius: 99.0,
          shadows: const [],
          blurStrength: 10.0,
          contentColor: scheme.onSurface.withValues(alpha: 0.5),
        ),
        thumbStyle: SurfaceStyle(
          backgroundColor: Colors.grey.withValues(alpha: 0.9),
          borderColor: Colors.white.withValues(alpha: 0.2),
          borderWidth: 0,
          borderRadius: 99.0,
          shadows: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.5),
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
          borderColor: Colors.white.withValues(alpha: 0.3), // Required
          contentColor: scheme.onSurface, // Required
          borderWidth: 0,
          borderRadius: 0,
          blurStrength: 0,
          shadows: const [],
          customBorder: Border(
              bottom: BorderSide(
                  color: Colors.white.withValues(alpha: 0.3), width: 1.5)),
        ),
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: Colors.white.withValues(alpha: 0.1),
          borderColor: Colors.white.withValues(alpha: 0.3),
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
          backgroundColor: Colors.white.withValues(alpha: 0.05),
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
        backgroundColor: Colors.black.withValues(alpha: 0.6),
        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        displayDuration: const Duration(seconds: 3),
      ),
      dividerStyle: DividerStyle(
        color: Colors.white.withValues(alpha: 0.15),
        thickness: 1.0,
        glowStrength: 4.0,
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
    );
  }
}
