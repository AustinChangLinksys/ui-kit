import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/input_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/interaction_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/layout_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/navigation_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/skeleton_style.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/toggle_style.dart';
import 'package:ui_kit_library/ui_kit.dart';

class BrutalDesignTheme extends AppDesignTheme {
  // Private constructor, used to receive all properties and can be called by Factory
  const BrutalDesignTheme._({
    required super.surfaceBase,
    required super.surfaceElevated,
    required super.surfaceHighlight,
    required super.toggleStyle,
    required super.typography,
    required super.animation,
    required super.spacingFactor,
    required super.skeletonStyle,
    required super.buttonHeight,
    required super.navigationStyle,
    required super.inputStyle,
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
          // 絕對剛體，不縮小
          pressedScale: 1.0,
          // 不改變透明度，保持高對比
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          // ✨ 關鍵：按下去往右下位移 (數值通常等於陰影的 offset)
          pressedOffset: Offset(4, 4),
        ),
      ),
      toggleStyle: const ToggleStyle(
        activeType: ToggleContentType.text,
        inactiveType: ToggleContentType.text,
        activeText: 'I',
        inactiveText: 'O',
      ),
      skeletonStyle: SkeletonStyle(
        baseColor: Colors.black.withValues(alpha: 0.15),
        highlightColor: Colors.black.withValues(alpha: 0.3),
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
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.onSurface, // 必須有
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

        // 狀態修改器 (Focus Switch)
        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary, // 邊框變主色
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
      typography: const TypographySpec(
        bodyFontFamily: 'Courier',
        displayFontFamily: 'Courier',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
      buttonHeight: 56.0,
      navigationStyle: const NavigationStyle(
        height: 80.0, // 高一點，給予厚重感
        isFloating: false, // ✨ 關鍵：固定模式 (貼底)
        floatingMargin: 0.0,
        itemSpacing: 8.0,
      ),
      layoutSpec: const LayoutSpec(
        // Brutal 風格通常不貼邊，甚至手機版都會留 24px 的粗邊
        marginMobile: 24.0,
        marginTablet: 48.0,
        marginDesktop: 120.0, // 桌面版大量留白，強調中心內容

        // 極寬的 Gutter，讓卡片之間完全分離
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
          // 絕對剛體，不縮小
          pressedScale: 1.0,
          // 不改變透明度，保持高對比
          pressedOpacity: 1.0,
          hoverOpacity: 1.0,
          // ✨ 關鍵：按下去往右下位移 (數值通常等於陰影的 offset)
          pressedOffset: Offset(4, 4),
        ),
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
        // Underline Style
        underlineStyle: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: black, // 必須有
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

        // 狀態修改器 (Focus Switch)
        focusModifier: SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: scheme.primary, // 邊框變主色
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
      typography: const TypographySpec(
        bodyFontFamily: 'Courier',
        displayFontFamily: 'Courier',
      ),
      animation: const AnimationSpec(
        duration: Duration(milliseconds: 150),
        curve: Curves.elasticOut,
      ),
      spacingFactor: 1.5,
      buttonHeight: 56.0,
      navigationStyle: const NavigationStyle(
        height: 80.0, // 高一點，給予厚重感
        isFloating: false, // ✨ 關鍵：固定模式 (貼底)
        floatingMargin: 0.0,
        itemSpacing: 8.0,
      ),
      layoutSpec: const LayoutSpec(
        // Brutal 風格通常不貼邊，甚至手機版都會留 24px 的粗邊
        marginMobile: 24.0,
        marginTablet: 48.0,
        marginDesktop: 120.0, // 桌面版大量留白，強調中心內容

        // 極寬的 Gutter，讓卡片之間完全分離
        gutterMobile: 24.0,
        gutterTablet: 32.0,
        gutterDesktop: 40.0,
      ),
    );
  }
}
