import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Abstract base class for theme-specific carousel rendering
///
/// Provides theme-specific animation behavior:
/// - Glass/Brutal: Smooth scroll animation
/// - Pixel: Snap scroll (instant page changes)
abstract class CarouselRenderer {
  /// Detect which renderer to use based on animation duration
  static CarouselRenderer fromTheme(AppDesignTheme theme) {
    // Pixel theme has snap animation (0ms), others have smooth (300ms+)
    if (theme.carouselStyle.useSnapScroll) {
      return PixelCarouselRenderer();
    } else {
      return SmoothCarouselRenderer();
    }
  }

  /// Get animation curve for this theme
  Curve getAnimationCurve();

  /// Get animation duration for this theme
  Duration getAnimationDuration();

  /// Get button styling for this theme
  ButtonStyle getButtonStyle();
}

/// Smooth carousel renderer (Glass, Brutal, Flat, Neumorphic themes)
class SmoothCarouselRenderer extends CarouselRenderer {
  @override
  Curve getAnimationCurve() => Curves.easeInOut;

  @override
  Duration getAnimationDuration() => const Duration(milliseconds: 300);

  @override
  ButtonStyle getButtonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey[300];
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.blue[300];
        }
        return Colors.blue;
      }),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

/// Pixel theme carousel renderer with snap scroll
class PixelCarouselRenderer extends CarouselRenderer {
  @override
  Curve getAnimationCurve() => Curves.linear;

  @override
  Duration getAnimationDuration() => Duration.zero; // Snap = instant

  @override
  ButtonStyle getButtonStyle() {
    return ButtonStyle(
      backgroundColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.disabled)) {
          return Colors.grey[400];
        }
        if (states.contains(WidgetState.hovered)) {
          return Colors.black87;
        }
        return Colors.black;
      }),
      foregroundColor: WidgetStateProperty.all(Colors.white),
      shape: WidgetStateProperty.all(
        const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // Pixel theme: no rounding
        ),
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
    );
  }
}
