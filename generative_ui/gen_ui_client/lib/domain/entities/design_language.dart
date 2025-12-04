/// Represents the available design languages in the UI Kit.
///
/// Each design language provides a distinct visual style:
/// - [glass]: Glassmorphism with blur effects and transparency
/// - [brutal]: Neo-Brutalism with bold borders and raw aesthetics
/// - [flat]: Clean, minimal design with solid colors
/// - [neumorphic]: Soft UI with subtle shadows creating depth
/// - [pixel]: Retro pixel-art inspired blocky design
enum DesignLanguage {
  /// Glassmorphism: Frosted glass effects with blur and transparency.
  glass,

  /// Neo-Brutalism: Bold, raw aesthetics with strong borders.
  brutal,

  /// Flat Design: Clean, minimal design with solid colors.
  flat,

  /// Neumorphism: Soft UI with subtle shadows and depth.
  neumorphic,

  /// Pixel Art: Retro-inspired blocky, pixelated design.
  pixel;

  /// Display name for UI presentation.
  String get displayName {
    switch (this) {
      case DesignLanguage.glass:
        return 'Glassmorphism';
      case DesignLanguage.brutal:
        return 'Neo-Brutalism';
      case DesignLanguage.flat:
        return 'Flat Design';
      case DesignLanguage.neumorphic:
        return 'Neumorphism';
      case DesignLanguage.pixel:
        return 'Pixel Art';
    }
  }

  /// Short name for compact UI elements.
  String get shortName {
    switch (this) {
      case DesignLanguage.glass:
        return 'Glass';
      case DesignLanguage.brutal:
        return 'Brutal';
      case DesignLanguage.flat:
        return 'Flat';
      case DesignLanguage.neumorphic:
        return 'Neumorphic';
      case DesignLanguage.pixel:
        return 'Pixel';
    }
  }
}
