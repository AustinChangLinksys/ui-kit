# Theme Spec API Contracts: Mesh Network Topology View

**Feature**: 016-mesh-topology-view
**Date**: 2025-12-05
**Phase**: 1 - API Contracts

## TopologySpec Contract

### Class Definition

```dart
/// Theme specification for mesh topology visualization.
///
/// Part of [AppDesignTheme]. Provides all visual parameters for
/// topology components without hardcoded values.
///
/// Usage:
/// ```dart
/// final spec = Theme.of(context).extension<AppDesignTheme>()!.topologySpec;
/// ```
@TailorMixin()
class TopologySpec extends ThemeExtension<TopologySpec> with _$TopologySpecMixin {
  //============================================================
  // NODE STYLES
  //============================================================

  /// Style for gateway node in normal operation.
  final NodeStyle gatewayNormalStyle;

  /// Style for gateway node under high load.
  final NodeStyle gatewayHighLoadStyle;

  /// Style for gateway node when offline.
  final NodeStyle gatewayOfflineStyle;

  /// Style for extender node in normal operation.
  final NodeStyle extenderNormalStyle;

  /// Style for extender node under high load.
  final NodeStyle extenderHighLoadStyle;

  /// Style for extender node when offline.
  final NodeStyle extenderOfflineStyle;

  /// Style for client node in normal operation.
  final NodeStyle clientNormalStyle;

  /// Style for client node when offline.
  final NodeStyle clientOfflineStyle;

  //============================================================
  // LINK STYLES
  //============================================================

  /// Style for Ethernet (wired) connections.
  final LinkStyle ethernetLinkStyle;

  /// Style for WiFi connections with strong signal (> -50 dBm).
  final LinkStyle wifiStrongStyle;

  /// Style for WiFi connections with medium signal (-50 to -70 dBm).
  final LinkStyle wifiMediumStyle;

  /// Style for WiFi connections with weak signal (< -70 dBm).
  final LinkStyle wifiWeakStyle;

  /// Style for WiFi connections with unknown signal.
  final LinkStyle wifiUnknownStyle;

  //============================================================
  // TREE VIEW STYLES
  //============================================================

  /// Color for hierarchy guide lines.
  final Color guideLineColor;

  /// Width of guide lines.
  final double guideLineWidth;

  /// Card background color for tree nodes.
  final Color cardBackgroundColor;

  /// Card border radius.
  final double cardBorderRadius;

  /// Card elevation/shadow.
  final List<BoxShadow> cardShadows;

  //============================================================
  // ANIMATION PARAMETERS
  //============================================================

  /// Breathing animation period for normal state.
  final Duration breathingPeriodNormal;

  /// Breathing animation period for high-load state.
  final Duration breathingPeriodStressed;

  /// Full orbit period for client satellites.
  final Duration orbitPeriod;

  /// Wave animation period for liquid nodes.
  final Duration waveAnimationPeriod;

  /// Duration for Tree/Graph view transition.
  final Duration viewTransitionDuration;

  /// Curve for view transition animation.
  final Curve viewTransitionCurve;

  /// Debounce duration for status change animations.
  final Duration statusChangeDebounce;

  //============================================================
  // LAYOUT PARAMETERS
  //============================================================

  /// Base size for node widgets.
  final double nodeSize;

  /// Radius for client orbit around parent.
  final double orbitRadius;

  /// Radius for extender ring around gateway.
  final double extenderRingRadius;

  /// Threshold for grouping clients into clusters.
  final int clientClusterThreshold;

  /// Spacing between tree node cards.
  final double treeCardSpacing;

  /// Indentation per depth level in tree view.
  final double treeIndentation;

  //============================================================
  // CONSTRUCTOR
  //============================================================

  const TopologySpec({
    required this.gatewayNormalStyle,
    required this.gatewayHighLoadStyle,
    required this.gatewayOfflineStyle,
    required this.extenderNormalStyle,
    required this.extenderHighLoadStyle,
    required this.extenderOfflineStyle,
    required this.clientNormalStyle,
    required this.clientOfflineStyle,
    required this.ethernetLinkStyle,
    required this.wifiStrongStyle,
    required this.wifiMediumStyle,
    required this.wifiWeakStyle,
    required this.wifiUnknownStyle,
    required this.guideLineColor,
    required this.guideLineWidth,
    required this.cardBackgroundColor,
    required this.cardBorderRadius,
    required this.cardShadows,
    required this.breathingPeriodNormal,
    required this.breathingPeriodStressed,
    required this.orbitPeriod,
    required this.waveAnimationPeriod,
    required this.viewTransitionDuration,
    required this.viewTransitionCurve,
    required this.statusChangeDebounce,
    required this.nodeSize,
    required this.orbitRadius,
    required this.extenderRingRadius,
    required this.clientClusterThreshold,
    required this.treeCardSpacing,
    required this.treeIndentation,
  });

  //============================================================
  // HELPER METHODS
  //============================================================

  /// Get node style based on type and status.
  NodeStyle nodeStyleFor(MeshNodeType type, MeshNodeStatus status) {
    return switch ((type, status)) {
      (MeshNodeType.gateway, MeshNodeStatus.online) => gatewayNormalStyle,
      (MeshNodeType.gateway, MeshNodeStatus.highLoad) => gatewayHighLoadStyle,
      (MeshNodeType.gateway, MeshNodeStatus.offline) => gatewayOfflineStyle,
      (MeshNodeType.extender, MeshNodeStatus.online) => extenderNormalStyle,
      (MeshNodeType.extender, MeshNodeStatus.highLoad) => extenderHighLoadStyle,
      (MeshNodeType.extender, MeshNodeStatus.offline) => extenderOfflineStyle,
      (MeshNodeType.client, MeshNodeStatus.offline) => clientOfflineStyle,
      (MeshNodeType.client, _) => clientNormalStyle,
    };
  }

  /// Get link style based on signal quality.
  LinkStyle linkStyleFor(SignalQuality quality) {
    return switch (quality) {
      SignalQuality.wired => ethernetLinkStyle,
      SignalQuality.strong => wifiStrongStyle,
      SignalQuality.medium => wifiMediumStyle,
      SignalQuality.weak => wifiWeakStyle,
      SignalQuality.unknown => wifiUnknownStyle,
    };
  }
}
```

---

## NodeStyle Contract

### Class Definition

```dart
/// Visual parameters for a mesh node.
///
/// Used by [TopologySpec] to define appearance of Gateway,
/// Extender, and Client nodes in various states.
@TailorMixin()
class NodeStyle extends ThemeExtension<NodeStyle> with _$NodeStyleMixin {
  //============================================================
  // SURFACE PROPERTIES
  //============================================================

  /// Background color of the node.
  final Color backgroundColor;

  /// Border color.
  final Color borderColor;

  /// Border width in logical pixels.
  final double borderWidth;

  /// Corner radius (0 for sharp, >0 for rounded).
  final double borderRadius;

  /// Blur strength for Glass theme (0 for no blur).
  final double blurStrength;

  /// Shadow configuration.
  final List<BoxShadow> shadows;

  //============================================================
  // GLOW PROPERTIES (PulseNode)
  //============================================================

  /// Radius of breathing glow effect.
  final double glowRadius;

  /// Color of glow effect.
  final Color glowColor;

  //============================================================
  // WAVE PROPERTIES (LiquidNode)
  //============================================================

  /// Wave color at low load (0%).
  final Color waveLowColor;

  /// Wave color at high load (100%).
  final Color waveHighColor;

  /// Wave amplitude multiplier.
  final double waveAmplitude;

  /// Turbulence intensity at high load.
  final double turbulenceIntensity;

  //============================================================
  // CONTENT PROPERTIES
  //============================================================

  /// Icon/text color inside node.
  final Color contentColor;

  /// Font size for labels.
  final double labelFontSize;

  //============================================================
  // CONSTRUCTOR
  //============================================================

  const NodeStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.blurStrength,
    required this.shadows,
    required this.glowRadius,
    required this.glowColor,
    required this.waveLowColor,
    required this.waveHighColor,
    required this.waveAmplitude,
    required this.turbulenceIntensity,
    required this.contentColor,
    required this.labelFontSize,
  });
}
```

---

## LinkStyle Contract

### Class Definition

```dart
/// Visual parameters for a mesh link.
///
/// Used by [TopologySpec] to define appearance of
/// Ethernet and WiFi connections.
@TailorMixin()
class LinkStyle extends ThemeExtension<LinkStyle> with _$LinkStyleMixin {
  //============================================================
  // LINE PROPERTIES
  //============================================================

  /// Line color.
  final Color color;

  /// Line width in logical pixels.
  final double width;

  /// Dash pattern as [dashLength, gapLength].
  /// Null for solid lines (Ethernet).
  final List<double>? dashPattern;

  //============================================================
  // ANIMATION PROPERTIES
  //============================================================

  /// Flow animation speed (pixels per second).
  /// 0 for no animation.
  final double flowSpeed;

  //============================================================
  // EFFECT PROPERTIES
  //============================================================

  /// Glow radius around line.
  /// 0 for no glow.
  final double glowRadius;

  /// Glow color (defaults to line color if null).
  final Color? glowColor;

  //============================================================
  // CONSTRUCTOR
  //============================================================

  const LinkStyle({
    required this.color,
    required this.width,
    this.dashPattern,
    this.flowSpeed = 0.0,
    this.glowRadius = 0.0,
    this.glowColor,
  });
}
```

---

## Theme Implementation Examples

### Glass Theme

```dart
static TopologySpec glassTopologySpec(AppPalette palette) => TopologySpec(
  // Gateway styles
  gatewayNormalStyle: NodeStyle(
    backgroundColor: Colors.white.withOpacity(0.15),
    borderColor: Colors.white.withOpacity(0.3),
    borderWidth: 1.0,
    borderRadius: 24.0,
    blurStrength: 20.0,
    shadows: [],
    glowRadius: 20.0,
    glowColor: palette.accent.withOpacity(0.3),
    waveLowColor: Colors.transparent,
    waveHighColor: Colors.transparent,
    waveAmplitude: 0.0,
    turbulenceIntensity: 0.0,
    contentColor: Colors.white,
    labelFontSize: 12.0,
  ),
  gatewayHighLoadStyle: NodeStyle(
    backgroundColor: Colors.white.withOpacity(0.2),
    borderColor: palette.warning.withOpacity(0.5),
    borderWidth: 2.0,
    borderRadius: 24.0,
    blurStrength: 20.0,
    shadows: [],
    glowRadius: 30.0,
    glowColor: palette.warning.withOpacity(0.5),
    waveLowColor: Colors.transparent,
    waveHighColor: Colors.transparent,
    waveAmplitude: 0.0,
    turbulenceIntensity: 0.0,
    contentColor: Colors.white,
    labelFontSize: 12.0,
  ),
  gatewayOfflineStyle: NodeStyle(
    backgroundColor: Colors.grey.withOpacity(0.1),
    borderColor: Colors.grey.withOpacity(0.3),
    borderWidth: 1.0,
    borderRadius: 24.0,
    blurStrength: 5.0,
    shadows: [],
    glowRadius: 0.0,
    glowColor: Colors.transparent,
    waveLowColor: Colors.transparent,
    waveHighColor: Colors.transparent,
    waveAmplitude: 0.0,
    turbulenceIntensity: 0.0,
    contentColor: Colors.grey,
    labelFontSize: 12.0,
  ),

  // ... extender and client styles ...

  // Link styles
  ethernetLinkStyle: LinkStyle(
    color: Colors.white.withOpacity(0.6),
    width: 3.0,
    dashPattern: null,
    flowSpeed: 0.0,
    glowRadius: 4.0,
  ),
  wifiStrongStyle: LinkStyle(
    color: palette.success,
    width: 2.0,
    dashPattern: [8.0, 4.0],
    flowSpeed: 100.0,
    glowRadius: 2.0,
  ),
  wifiMediumStyle: LinkStyle(
    color: palette.warning,
    width: 2.0,
    dashPattern: [8.0, 4.0],
    flowSpeed: 50.0,
    glowRadius: 2.0,
  ),
  wifiWeakStyle: LinkStyle(
    color: palette.error,
    width: 2.0,
    dashPattern: [8.0, 4.0],
    flowSpeed: 20.0,
    glowRadius: 2.0,
  ),
  wifiUnknownStyle: LinkStyle(
    color: Colors.grey,
    width: 2.0,
    dashPattern: [4.0, 4.0],
    flowSpeed: 0.0,
    glowRadius: 0.0,
  ),

  // Animation parameters
  breathingPeriodNormal: const Duration(seconds: 4),
  breathingPeriodStressed: const Duration(seconds: 1),
  orbitPeriod: const Duration(seconds: 10),
  waveAnimationPeriod: const Duration(seconds: 2),
  viewTransitionDuration: const Duration(milliseconds: 300),
  viewTransitionCurve: Curves.easeInOutCubic,
  statusChangeDebounce: const Duration(milliseconds: 500),

  // Layout parameters
  nodeSize: 80.0,
  orbitRadius: 60.0,
  extenderRingRadius: 150.0,
  clientClusterThreshold: 20,
  treeCardSpacing: 8.0,
  treeIndentation: 24.0,

  // Tree view styles
  guideLineColor: Colors.white.withOpacity(0.3),
  guideLineWidth: 1.0,
  cardBackgroundColor: Colors.white.withOpacity(0.1),
  cardBorderRadius: 12.0,
  cardShadows: [],
);
```

### Brutal Theme

```dart
static TopologySpec brutalTopologySpec(AppPalette palette) => TopologySpec(
  // Gateway styles - sharp corners, heavy borders, offset shadows
  gatewayNormalStyle: NodeStyle(
    backgroundColor: Colors.white,
    borderColor: Colors.black,
    borderWidth: 3.0,
    borderRadius: 0.0,  // Sharp corners
    blurStrength: 0.0,  // No blur
    shadows: [
      BoxShadow(
        offset: const Offset(4, 4),
        color: Colors.black,
        spreadRadius: 0,
        blurRadius: 0,
      ),
    ],
    glowRadius: 0.0,  // No glow - use border thickness for emphasis
    glowColor: Colors.transparent,
    waveLowColor: Colors.transparent,
    waveHighColor: Colors.transparent,
    waveAmplitude: 0.0,
    turbulenceIntensity: 0.0,
    contentColor: Colors.black,
    labelFontSize: 14.0,  // Larger, bolder text
  ),

  // ... other styles with similar brutal treatment ...

  // Link styles - thick, stark
  ethernetLinkStyle: LinkStyle(
    color: Colors.black,
    width: 4.0,
    dashPattern: null,
    flowSpeed: 0.0,
    glowRadius: 0.0,
  ),
  wifiStrongStyle: LinkStyle(
    color: Colors.green.shade800,
    width: 3.0,
    dashPattern: [12.0, 6.0],
    flowSpeed: 80.0,
    glowRadius: 0.0,
  ),

  // ... other parameters ...
);
```

---

## Integration with AppDesignTheme

### Registration

```dart
@TailorMixin()
class AppDesignTheme extends ThemeExtension<AppDesignTheme> {
  // ... existing specs ...

  /// Topology visualization spec.
  final TopologySpec topologySpec;

  const AppDesignTheme({
    // ... existing params ...
    required this.topologySpec,
  });
}
```

### Access Pattern

```dart
// In any widget
@override
Widget build(BuildContext context) {
  final theme = Theme.of(context).extension<AppDesignTheme>();
  if (theme == null) {
    throw FlutterError('AppDesignTheme not found in context');
  }

  final spec = theme.topologySpec;
  final nodeStyle = spec.nodeStyleFor(node.type, node.status);

  return PulseNode(
    node: node,
    style: nodeStyle,
    breathingPeriod: spec.breathingPeriodNormal,
  );
}
```
