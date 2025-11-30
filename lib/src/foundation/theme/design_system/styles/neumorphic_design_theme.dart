import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_palette.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/layout_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/navigation_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/toggle_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class NeumorphicDesignTheme extends AppDesignTheme {
  NeumorphicDesignTheme._({
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
    required super.layoutSpec,
  });

  // Default to Light, providing a default ColorScheme
  factory NeumorphicDesignTheme.light([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultLightScheme;
    final lightBaseColor = scheme.surface;
    final lightShadow = Color.alphaBlend(
        Colors.white.withValues(alpha: 0.5), scheme.surface); // White shadow
    final darkShadow = Color.alphaBlend(
        Colors.black.withValues(alpha: 0.2), scheme.surface); // Black shadow
    final highlightBorderColor = scheme.primary;
    final neuBase = scheme.surface;
    final neuShadow = AppPalette.neumorphicLightShadow.withValues(alpha: 0.3);
    return NeumorphicDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: lightShadow,
            offset: const Offset(-6, -6),
            blurRadius: 12,
          ),
          BoxShadow(
            color: darkShadow,
            offset: const Offset(6, 6),
            blurRadius: 12,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 20.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                Colors.white.withValues(alpha: 0.7), scheme.surface),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color.alphaBlend(
                Colors.black.withValues(alpha: 0.3), scheme.surface),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: lightBaseColor,
        borderColor: highlightBorderColor,
        borderWidth: 1.5,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: lightShadow,
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: darkShadow,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
        blurStrength: 0.0,
        contentColor: highlightBorderColor,
        interaction: const InteractionSpec(
          // 極微小的縮放，模擬材質被壓實的感覺
          pressedScale: 0.98,
          // 保持實心，不變透明
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset.zero,
        ),
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.dot, // 使用凹槽圓點
        inactiveType: ToggleContentType.dot,
        // Neumorphism 通常不依賴文字或 Icon，而是依賴物理凹凸感
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.surface,
        highlightColor: scheme.surface.withValues(alpha: 0.9), // 微變亮
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 12.0,
      ),
      inputStyle: InputStyle(
        // Outline/Box Style (模擬凹槽)
        outlineStyle: SurfaceStyle(
          backgroundColor: neuBase,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0.0,
          borderRadius: 12.0,
          // 模擬凹陷效果
          shadows: [
            BoxShadow(
                color: neuShadow, offset: const Offset(2, 2), blurRadius: 4)
          ],
          blurStrength: 0.0,
        ),
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: neuShadow, width: 1.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 12.0,
          shadows: const [],
          blurStrength: 0,
        ),

        // 狀態修改器 (Focus)
        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary,
          contentColor: scheme.primary,
          // Focus 時通常要加上發光/凸起陰影
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.5), blurRadius: 8)
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
      typography: const TypographySpec(
        bodyFontFamily: 'Nunito',
        displayFontFamily: 'Nunito',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
      spacingFactor: 1.2,
      buttonHeight: 52.0,
      navigationStyle: const NavigationStyle(
        height: 88.0, // 較高，因為軟塑膠需要更多呼吸空間來呈現光影
        isFloating: false, // 固定模式 (融合背景)
        floatingMargin: 0.0,
        itemSpacing: 12.0,
      ),
      layoutSpec: const LayoutSpec(
        // 為了容納擴散的陰影，邊距不能太小
        marginMobile: 24.0,
        marginTablet: 40.0,
        marginDesktop: 80.0,

        // Gutter 必須大於 (Shadow Blur Radius * 2)，否則陰影會打架
        // 假設最大 Shadow Blur 是 10，那 Gutter 至少要 20-24
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),
    );
  }

  factory NeumorphicDesignTheme.dark([ColorScheme? scheme]) {
    scheme ??= AppTheme.defaultDarkScheme;
    final darkBaseColor = scheme.surface; // 2D2D2D
    final darkLightShadow = Color.alphaBlend(
        Colors.white.withValues(alpha: 0.1), scheme.surface); // Light shadow
    final darkDarkShadow = Color.alphaBlend(
        Colors.black.withValues(alpha: 0.6), scheme.surface); // Dark shadow
    final darkHighlightBorderColor = scheme.primary;
    final neuBase = scheme.surface;
    final neuShadow = AppPalette.neumorphicLightShadow.withValues(alpha: 0.3);

    return NeumorphicDesignTheme._(
      surfaceBase: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 16.0,
        shadows: [
          BoxShadow(
            color: darkLightShadow,
            offset: const Offset(-5, -5),
            blurRadius: 10,
          ),
          BoxShadow(
            color: darkDarkShadow,
            offset: const Offset(5, 5),
            blurRadius: 10,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceElevated: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: Colors.transparent,
        borderWidth: 0.0,
        borderRadius: 20.0,
        shadows: [
          BoxShadow(
            color: Color.alphaBlend(
                Colors.white.withValues(alpha: 0.15), scheme.surface),
            offset: const Offset(-8, -8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: Color.alphaBlend(
                Colors.black.withValues(alpha: 0.8), scheme.surface),
            offset: const Offset(8, 8),
            blurRadius: 16,
          ),
        ],
        blurStrength: 0.0,
        contentColor: scheme.onSurface,
      ),
      surfaceHighlight: SurfaceStyle(
        backgroundColor: darkBaseColor,
        borderColor: darkHighlightBorderColor,
        borderWidth: 1.5,
        borderRadius: 12.0,
        shadows: [
          BoxShadow(
            color: darkLightShadow,
            offset: const Offset(-4, -4),
            blurRadius: 8,
          ),
          BoxShadow(
            color: darkDarkShadow,
            offset: const Offset(4, 4),
            blurRadius: 8,
          ),
        ],
        blurStrength: 0.0,
        contentColor: darkHighlightBorderColor,
        interaction: const InteractionSpec(
          // 極微小的縮放，模擬材質被壓實的感覺
          pressedScale: 0.98,
          // 保持實心，不變透明
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          pressedOffset: Offset.zero,
        ),
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.dot, // 使用凹槽圓點
        inactiveType: ToggleContentType.dot,
        // Neumorphism 通常不依賴文字或 Icon，而是依賴物理凹凸感
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: scheme.surface,
        highlightColor: scheme.surface.withValues(alpha: 0.8),
        animationType: SkeletonAnimationType.pulse,
        borderRadius: 12.0,
      ),
      inputStyle: InputStyle(
        // Outline/Box Style (模擬凹槽)
        outlineStyle: SurfaceStyle(
          backgroundColor: neuBase,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0.0,
          borderRadius: 12.0,
          // 模擬凹陷效果
          shadows: [
            BoxShadow(
                color: neuShadow, offset: const Offset(2, 2), blurRadius: 4)
          ],
          blurStrength: 0.0,
        ),
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
          customBorder:
              Border(bottom: BorderSide(color: neuShadow, width: 1.0)),
        ),
        // Filled Style
        filledStyle: SurfaceStyle(
          backgroundColor: scheme.surfaceContainerHigh,
          borderColor: Colors.transparent,
          contentColor: scheme.onSurface,
          borderWidth: 0,
          borderRadius: 12.0,
          shadows: const [],
          blurStrength: 0,
        ),

        // 狀態修改器 (Focus)
        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary,
          contentColor: scheme.primary,
          // Focus 時通常要加上發光/凸起陰影
          shadows: [
            BoxShadow(
                color: scheme.primary.withValues(alpha: 0.5), blurRadius: 8)
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
      typography: const TypographySpec(
        bodyFontFamily: 'Nunito',
        displayFontFamily: 'Nunito',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      ),
      spacingFactor: 1.2,
      buttonHeight: 52.0,
      navigationStyle: const NavigationStyle(
        height: 88.0, // 較高，因為軟塑膠需要更多呼吸空間來呈現光影
        isFloating: false, // 固定模式 (融合背景)
        floatingMargin: 0.0,
        itemSpacing: 12.0,
      ),
      layoutSpec: const LayoutSpec(
        // 為了容納擴散的陰影，邊距不能太小
        marginMobile: 24.0,
        marginTablet: 40.0,
        marginDesktop: 80.0,

        // Gutter 必須大於 (Shadow Blur Radius * 2)，否則陰影會打架
        // 假設最大 Shadow Blur 是 10，那 Gutter 至少要 20-24
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),
    );
  }
}
