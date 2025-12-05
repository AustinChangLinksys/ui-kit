/// Abstract base class for theme-specific stepper rendering
///
/// Different visual themes render steppers differently:
/// - Most themes: smooth animations, standard connectors
/// - Pixel theme: dashed connectors, pixel-perfect sizing
abstract class StepperRenderer {
  /// Factory for creating appropriate renderer based on theme
  factory StepperRenderer.forTheme({required bool usePixelStyle}) {
    return usePixelStyle ? PixelStepperRenderer() : SmoothStepperRenderer();
  }

  /// Determines if stepper should use dashed connectors
  bool get useDashedConnector;

  /// Step indicator size (may vary by theme)
  double get stepSize;
}

/// Standard smooth stepper renderer (Glass, Brutal, Flat, Neumorphic themes)
class SmoothStepperRenderer implements StepperRenderer {
  @override
  bool get useDashedConnector => false;

  @override
  double get stepSize => 48.0;
}

/// Pixel-art style stepper renderer (Pixel theme)
class PixelStepperRenderer implements StepperRenderer {
  @override
  bool get useDashedConnector => true;

  @override
  double get stepSize => 56.0; // Larger for pixel aesthetic
}
