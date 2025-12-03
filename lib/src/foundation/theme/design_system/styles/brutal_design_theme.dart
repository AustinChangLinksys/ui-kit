import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/ui_kit.dart';

class BrutalDesignTheme extends AppDesignTheme {
  // Private constructor, used to receive all properties and can be called by Factory
  const BrutalDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.surfaceSecondary,
    required super.surfaceTertiary,
    required super.toggleStyle,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
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

  factory BrutalDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    return BrutalDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface, // Use ColorScheme's surface
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface, // Use ColorScheme's onSurface as shadow
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor:
            scheme.primaryContainer, // Use ColorScheme's primaryContainer
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(8, 8),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onPrimaryContainer,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.error, // Use ColorScheme's error
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 4.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onError,
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset(4, 4),
        ),
      ),
      // Secondary (Tonal) Surface - Medium emphasis with mechanical aesthetic
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.15),
        borderColor: scheme.onSurface,
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      // Tertiary (Accent) Surface - Decorative with mechanical aesthetic
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: 0.2),
        borderColor: scheme.tertiary,
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.tertiary,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.tertiary,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'I',
        inactiveText: 'O',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.shadow.withValues(alpha: 0.15),
        highlightColor: scheme.shadow.withValues(alpha: 0.3),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 0.0,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: scheme.onSurface,
          contentColor: scheme.onSurface,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(
                color: scheme.onSurface,
                offset: const Offset(4, 4),
                blurRadius: 0)
          ],
          blurStrength: 0.0,
        ),
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.onSurface,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: scheme.onSurface, width: 3.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary,
          contentColor: scheme.primary,
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
        type: LoaderType.block,
        color: scheme.primary,
        strokeWidth: 0,
        size: 32.0,
        period: const Duration(milliseconds: 800),
        borderRadius: 0.0,
        shadows: [
          const BoxShadow(
              color: Colors.black, offset: Offset(4, 4), blurRadius: 0),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        backgroundColor: scheme.surface,
        textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'NeueHaasGrotTextRound',
            color: scheme.onSurface),
        displayDuration: const Duration(seconds: 2),
      ),
      dividerStyle: DividerStyle(
        color: scheme.onSurface,
        thickness: 3.0,
        pattern: DividerPattern.jagged,
        indent: 0.0,
        endIndent: 0.0,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.squareBlock,
        macAddressSeparator: '-',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
      buttonHeight: 56.0,
      navigationStyle: const NavigationStyle(
        height: 80.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 8.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 24.0,
        marginTablet: 48.0,
        marginDesktop: 120.0,
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),
    );
  }

  factory BrutalDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final black = scheme.onSurface;

    return BrutalDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: scheme.surface,
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(4, 4),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor:
            scheme.primaryContainer, // Use ColorScheme's primaryContainer
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(8, 8),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onPrimaryContainer,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: scheme.error, // Use ColorScheme's error
        borderColor: scheme.onSurface,
        borderWidth: 3.0,
        borderRadius: 4.0,
        shadows: [
          BoxShadow(
            color: scheme.onSurface,
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.onError,
        interaction: const InteractionSpec(
          pressedScale: 1.0,
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset(4, 4),
        ),
      ),
      // Secondary (Tonal) Surface - Medium emphasis with mechanical aesthetic (Dark mode)
      surfaceSecondary: SurfaceStyle(
        backgroundColor: scheme.surfaceContainerHighest.withValues(alpha: 0.25),
        borderColor: scheme.outline.withValues(alpha: 0.3),
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.shadow.withValues(alpha: 0.4),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.outline.withValues(alpha: 0.8),
      ),
      // Tertiary (Accent) Surface - Decorative with mechanical aesthetic (Dark mode)
      surfaceTertiary: SurfaceStyle(
        backgroundColor: scheme.tertiary.withValues(alpha: 0.25),
        borderColor: scheme.tertiary.withValues(alpha: 0.6),
        borderWidth: 2.0,
        borderRadius: 0.0,
        shadows: [
          BoxShadow(
            color: scheme.tertiary.withValues(alpha: 0.3),
            blurRadius: 0,
            offset: const Offset(2, 2),
          )
        ],
        blurStrength: 0.0,
        contentColor: scheme.tertiary,
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'I',
        inactiveText: 'O',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.onSurface.withValues(alpha: 0.1),
        highlightColor: scheme.onSurface.withValues(alpha: 0.4),
        animationType: SkeletonAnimationType.blink,
        borderRadius: 0.0,
      ),
      inputStyle: InputStyle(
        // Outline Style
        outlineStyle: SurfaceStyle(
          backgroundColor: scheme.surface,
          borderColor: black,
          contentColor: black,
          borderWidth: 3.0,
          borderRadius: 0.0,
          shadows: [
            BoxShadow(color: black, offset: const Offset(4, 4), blurRadius: 0)
          ],
          blurStrength: 0.0,
        ),
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: black,
          contentColor: black,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder: Border(bottom: BorderSide(color: black, width: 3.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: black,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
        ),

        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary,
          contentColor: scheme.primary,
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
        type: LoaderType.block,
        color: scheme.primary,
        strokeWidth: 0,
        size: 32.0,
        period: const Duration(milliseconds: 800),
        borderRadius: 0.0,
        shadows: [
          const BoxShadow(
              color: Colors.black, offset: Offset(4, 4), blurRadius: 0),
        ],
      ),
      toastStyle: ToastStyle(
        padding: const EdgeInsets.all(16),
        margin: EdgeInsets.zero,
        borderRadius: BorderRadius.zero,
        backgroundColor: scheme.surface,
        textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: 'NeueHaasGrotTextRound',
            color: scheme.onSurface),
        displayDuration: const Duration(seconds: 2),
      ),
      dividerStyle: DividerStyle(
        color: scheme.onSurface,
        thickness: 3.0,
        pattern: DividerPattern.jagged,
        indent: 0.0,
        endIndent: 0.0,
      ),
      networkInputStyle: const NetworkInputStyle(
        ipv4SeparatorStyle: SeparatorStyle.squareBlock,
        macAddressSeparator: '-',
      ),
      typography: const TypographySpec(
        bodyFontFamily: 'NeueHaasGrotTextRound',
        displayFontFamily: 'NeueHaasGrotTextRound',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
      buttonHeight: 56.0,
      navigationStyle: const NavigationStyle(
        height: 80.0,
        isFloating: false,
        floatingMargin: 0.0,
        itemSpacing: 8.0,
      ),
      layoutSpec: const LayoutSpec(
        marginMobile: 24.0,
        marginTablet: 48.0,
        marginDesktop: 120.0,
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),
    );
  }
}
