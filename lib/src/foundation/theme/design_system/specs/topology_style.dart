import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'topology_style.tailor.dart';

/// Visual parameters for a mesh node.
///
/// Used by [TopologySpec] to define appearance of Gateway,
/// Extender, and Client nodes in various states.
@TailorMixin()
class NodeStyle extends ThemeExtension<NodeStyle> with _$NodeStyleTailorMixin {
  /// Background color of the node.
  @override
  final Color backgroundColor;

  /// Border color.
  @override
  final Color borderColor;

  /// Border width in logical pixels.
  @override
  final double borderWidth;

  /// Corner radius (0 for sharp, >0 for rounded, 999 for circular).
  @override
  final double borderRadius;

  /// Radius of glow effect.
  @override
  final double glowRadius;

  /// Color of glow effect.
  @override
  final Color glowColor;

  /// Node size in logical pixels.
  @override
  final double size;

  /// Icon/content color inside node.
  @override
  final Color iconColor;

  const NodeStyle({
    required this.backgroundColor,
    required this.borderColor,
    required this.borderWidth,
    required this.borderRadius,
    required this.glowRadius,
    required this.glowColor,
    required this.size,
    required this.iconColor,
  });
}

/// Visual parameters for a mesh link.
///
/// Used by [TopologySpec] to define appearance of
/// Ethernet and WiFi connections.
@TailorMixin()
class LinkStyle extends ThemeExtension<LinkStyle> with _$LinkStyleTailorMixin {
  /// Line color.
  @override
  final Color color;

  /// Line width in logical pixels.
  @override
  final double width;

  /// Dash pattern as [dashLength, gapLength].
  /// Null for solid lines (Ethernet).
  @override
  final List<double>? dashPattern;

  /// Glow radius around line.
  @override
  final double glowRadius;

  /// Glow color.
  @override
  final Color glowColor;

  /// Duration for flow animation. Duration.zero for no animation.
  @override
  final Duration animationDuration;

  const LinkStyle({
    required this.color,
    required this.width,
    this.dashPattern,
    required this.glowColor,
    required this.glowRadius,
    required this.animationDuration,
  });
}

/// Theme specification for mesh topology visualization.
///
/// Part of [AppDesignTheme]. Provides all visual parameters for
/// topology components without hardcoded values.
@TailorMixin()
class TopologySpec extends ThemeExtension<TopologySpec>
    with _$TopologySpecTailorMixin {
  // Node styles per type and status
  @override
  final NodeStyle gatewayNormalStyle;
  @override
  final NodeStyle gatewayHighLoadStyle;
  @override
  final NodeStyle gatewayOfflineStyle;

  @override
  final NodeStyle extenderNormalStyle;
  @override
  final NodeStyle extenderHighLoadStyle;
  @override
  final NodeStyle extenderOfflineStyle;

  @override
  final NodeStyle clientNormalStyle;
  @override
  final NodeStyle clientOfflineStyle;

  // Link styles per signal quality
  @override
  final LinkStyle ethernetLinkStyle;
  @override
  final LinkStyle wifiStrongStyle;
  @override
  final LinkStyle wifiMediumStyle;
  @override
  final LinkStyle wifiWeakStyle;
  @override
  final LinkStyle wifiUnknownStyle;

  // Layout parameters
  @override
  final double nodeSpacing;

  @override
  final double linkCurvature;

  @override
  final double orbitRadius;

  @override
  final Duration orbitSpeed;

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
    required this.nodeSpacing,
    required this.linkCurvature,
    required this.orbitRadius,
    required this.orbitSpeed,
  });

  /// Get node style based on type and status.
  ///
  /// Uses Dart 3 switch expression for exhaustive matching.
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

/// Node type enumeration for style lookup.
enum MeshNodeType { gateway, extender, client }

/// Node status enumeration for style lookup.
enum MeshNodeStatus { online, offline, highLoad }

/// Signal quality enumeration for link style lookup.
enum SignalQuality { wired, strong, medium, weak, unknown }
