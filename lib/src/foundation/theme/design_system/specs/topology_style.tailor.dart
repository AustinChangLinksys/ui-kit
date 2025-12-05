// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'topology_style.dart';

// **************************************************************************
// TailorAnnotationsGenerator
// **************************************************************************

mixin _$NodeStyleTailorMixin on ThemeExtension<NodeStyle> {
  Color get backgroundColor;
  Color get borderColor;
  double get borderWidth;
  double get borderRadius;
  double get glowRadius;
  Color get glowColor;
  double get size;
  Color get iconColor;

  @override
  NodeStyle copyWith({
    Color? backgroundColor,
    Color? borderColor,
    double? borderWidth,
    double? borderRadius,
    double? glowRadius,
    Color? glowColor,
    double? size,
    Color? iconColor,
  }) {
    return NodeStyle(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
      borderRadius: borderRadius ?? this.borderRadius,
      glowRadius: glowRadius ?? this.glowRadius,
      glowColor: glowColor ?? this.glowColor,
      size: size ?? this.size,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  @override
  NodeStyle lerp(covariant ThemeExtension<NodeStyle>? other, double t) {
    if (other is! NodeStyle) return this as NodeStyle;
    return NodeStyle(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t)!,
      borderColor: Color.lerp(borderColor, other.borderColor, t)!,
      borderWidth: t < 0.5 ? borderWidth : other.borderWidth,
      borderRadius: t < 0.5 ? borderRadius : other.borderRadius,
      glowRadius: t < 0.5 ? glowRadius : other.glowRadius,
      glowColor: Color.lerp(glowColor, other.glowColor, t)!,
      size: t < 0.5 ? size : other.size,
      iconColor: Color.lerp(iconColor, other.iconColor, t)!,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NodeStyle &&
            const DeepCollectionEquality()
                .equals(backgroundColor, other.backgroundColor) &&
            const DeepCollectionEquality()
                .equals(borderColor, other.borderColor) &&
            const DeepCollectionEquality()
                .equals(borderWidth, other.borderWidth) &&
            const DeepCollectionEquality()
                .equals(borderRadius, other.borderRadius) &&
            const DeepCollectionEquality()
                .equals(glowRadius, other.glowRadius) &&
            const DeepCollectionEquality().equals(glowColor, other.glowColor) &&
            const DeepCollectionEquality().equals(size, other.size) &&
            const DeepCollectionEquality().equals(iconColor, other.iconColor));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(borderColor),
      const DeepCollectionEquality().hash(borderWidth),
      const DeepCollectionEquality().hash(borderRadius),
      const DeepCollectionEquality().hash(glowRadius),
      const DeepCollectionEquality().hash(glowColor),
      const DeepCollectionEquality().hash(size),
      const DeepCollectionEquality().hash(iconColor),
    );
  }
}

extension NodeStyleBuildContextProps on BuildContext {
  NodeStyle get nodeStyle => Theme.of(this).extension<NodeStyle>()!;

  /// Background color of the node.
  Color get backgroundColor => nodeStyle.backgroundColor;

  /// Border color.
  Color get borderColor => nodeStyle.borderColor;

  /// Border width in logical pixels.
  double get borderWidth => nodeStyle.borderWidth;

  /// Corner radius (0 for sharp, >0 for rounded, 999 for circular).
  double get borderRadius => nodeStyle.borderRadius;

  /// Radius of glow effect.
  double get glowRadius => nodeStyle.glowRadius;

  /// Color of glow effect.
  Color get glowColor => nodeStyle.glowColor;

  /// Node size in logical pixels.
  double get size => nodeStyle.size;

  /// Icon/content color inside node.
  Color get iconColor => nodeStyle.iconColor;
}

mixin _$LinkStyleTailorMixin on ThemeExtension<LinkStyle> {
  Color get color;
  double get width;
  List<double>? get dashPattern;
  double get glowRadius;
  Color get glowColor;
  Duration get animationDuration;

  @override
  LinkStyle copyWith({
    Color? color,
    double? width,
    List<double>? dashPattern,
    double? glowRadius,
    Color? glowColor,
    Duration? animationDuration,
  }) {
    return LinkStyle(
      color: color ?? this.color,
      width: width ?? this.width,
      dashPattern: dashPattern ?? this.dashPattern,
      glowRadius: glowRadius ?? this.glowRadius,
      glowColor: glowColor ?? this.glowColor,
      animationDuration: animationDuration ?? this.animationDuration,
    );
  }

  @override
  LinkStyle lerp(covariant ThemeExtension<LinkStyle>? other, double t) {
    if (other is! LinkStyle) return this as LinkStyle;
    return LinkStyle(
      color: Color.lerp(color, other.color, t)!,
      width: t < 0.5 ? width : other.width,
      dashPattern: t < 0.5 ? dashPattern : other.dashPattern,
      glowRadius: t < 0.5 ? glowRadius : other.glowRadius,
      glowColor: Color.lerp(glowColor, other.glowColor, t)!,
      animationDuration: t < 0.5 ? animationDuration : other.animationDuration,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LinkStyle &&
            const DeepCollectionEquality().equals(color, other.color) &&
            const DeepCollectionEquality().equals(width, other.width) &&
            const DeepCollectionEquality()
                .equals(dashPattern, other.dashPattern) &&
            const DeepCollectionEquality()
                .equals(glowRadius, other.glowRadius) &&
            const DeepCollectionEquality().equals(glowColor, other.glowColor) &&
            const DeepCollectionEquality()
                .equals(animationDuration, other.animationDuration));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(color),
      const DeepCollectionEquality().hash(width),
      const DeepCollectionEquality().hash(dashPattern),
      const DeepCollectionEquality().hash(glowRadius),
      const DeepCollectionEquality().hash(glowColor),
      const DeepCollectionEquality().hash(animationDuration),
    );
  }
}

extension LinkStyleBuildContextProps on BuildContext {
  LinkStyle get linkStyle => Theme.of(this).extension<LinkStyle>()!;

  /// Line color.
  Color get color => linkStyle.color;

  /// Line width in logical pixels.
  double get width => linkStyle.width;

  /// Dash pattern as [dashLength, gapLength].
  /// Null for solid lines (Ethernet).
  List<double>? get dashPattern => linkStyle.dashPattern;

  /// Glow radius around line.
  double get glowRadius => linkStyle.glowRadius;

  /// Glow color.
  Color get glowColor => linkStyle.glowColor;

  /// Duration for flow animation. Duration.zero for no animation.
  Duration get animationDuration => linkStyle.animationDuration;
}

mixin _$TopologySpecTailorMixin on ThemeExtension<TopologySpec> {
  NodeStyle get gatewayNormalStyle;
  NodeStyle get gatewayHighLoadStyle;
  NodeStyle get gatewayOfflineStyle;
  NodeStyle get extenderNormalStyle;
  NodeStyle get extenderHighLoadStyle;
  NodeStyle get extenderOfflineStyle;
  NodeStyle get clientNormalStyle;
  NodeStyle get clientOfflineStyle;
  LinkStyle get ethernetLinkStyle;
  LinkStyle get wifiStrongStyle;
  LinkStyle get wifiMediumStyle;
  LinkStyle get wifiWeakStyle;
  LinkStyle get wifiUnknownStyle;
  double get nodeSpacing;
  double get linkCurvature;
  double get orbitRadius;
  Duration get orbitSpeed;

  @override
  TopologySpec copyWith({
    NodeStyle? gatewayNormalStyle,
    NodeStyle? gatewayHighLoadStyle,
    NodeStyle? gatewayOfflineStyle,
    NodeStyle? extenderNormalStyle,
    NodeStyle? extenderHighLoadStyle,
    NodeStyle? extenderOfflineStyle,
    NodeStyle? clientNormalStyle,
    NodeStyle? clientOfflineStyle,
    LinkStyle? ethernetLinkStyle,
    LinkStyle? wifiStrongStyle,
    LinkStyle? wifiMediumStyle,
    LinkStyle? wifiWeakStyle,
    LinkStyle? wifiUnknownStyle,
    double? nodeSpacing,
    double? linkCurvature,
    double? orbitRadius,
    Duration? orbitSpeed,
  }) {
    return TopologySpec(
      gatewayNormalStyle: gatewayNormalStyle ?? this.gatewayNormalStyle,
      gatewayHighLoadStyle: gatewayHighLoadStyle ?? this.gatewayHighLoadStyle,
      gatewayOfflineStyle: gatewayOfflineStyle ?? this.gatewayOfflineStyle,
      extenderNormalStyle: extenderNormalStyle ?? this.extenderNormalStyle,
      extenderHighLoadStyle:
          extenderHighLoadStyle ?? this.extenderHighLoadStyle,
      extenderOfflineStyle: extenderOfflineStyle ?? this.extenderOfflineStyle,
      clientNormalStyle: clientNormalStyle ?? this.clientNormalStyle,
      clientOfflineStyle: clientOfflineStyle ?? this.clientOfflineStyle,
      ethernetLinkStyle: ethernetLinkStyle ?? this.ethernetLinkStyle,
      wifiStrongStyle: wifiStrongStyle ?? this.wifiStrongStyle,
      wifiMediumStyle: wifiMediumStyle ?? this.wifiMediumStyle,
      wifiWeakStyle: wifiWeakStyle ?? this.wifiWeakStyle,
      wifiUnknownStyle: wifiUnknownStyle ?? this.wifiUnknownStyle,
      nodeSpacing: nodeSpacing ?? this.nodeSpacing,
      linkCurvature: linkCurvature ?? this.linkCurvature,
      orbitRadius: orbitRadius ?? this.orbitRadius,
      orbitSpeed: orbitSpeed ?? this.orbitSpeed,
    );
  }

  @override
  TopologySpec lerp(covariant ThemeExtension<TopologySpec>? other, double t) {
    if (other is! TopologySpec) return this as TopologySpec;
    return TopologySpec(
      gatewayNormalStyle: gatewayNormalStyle.lerp(other.gatewayNormalStyle, t),
      gatewayHighLoadStyle:
          gatewayHighLoadStyle.lerp(other.gatewayHighLoadStyle, t),
      gatewayOfflineStyle:
          gatewayOfflineStyle.lerp(other.gatewayOfflineStyle, t),
      extenderNormalStyle:
          extenderNormalStyle.lerp(other.extenderNormalStyle, t),
      extenderHighLoadStyle:
          extenderHighLoadStyle.lerp(other.extenderHighLoadStyle, t),
      extenderOfflineStyle:
          extenderOfflineStyle.lerp(other.extenderOfflineStyle, t),
      clientNormalStyle: clientNormalStyle.lerp(other.clientNormalStyle, t),
      clientOfflineStyle: clientOfflineStyle.lerp(other.clientOfflineStyle, t),
      ethernetLinkStyle: ethernetLinkStyle.lerp(other.ethernetLinkStyle, t),
      wifiStrongStyle: wifiStrongStyle.lerp(other.wifiStrongStyle, t),
      wifiMediumStyle: wifiMediumStyle.lerp(other.wifiMediumStyle, t),
      wifiWeakStyle: wifiWeakStyle.lerp(other.wifiWeakStyle, t),
      wifiUnknownStyle: wifiUnknownStyle.lerp(other.wifiUnknownStyle, t),
      nodeSpacing: t < 0.5 ? nodeSpacing : other.nodeSpacing,
      linkCurvature: t < 0.5 ? linkCurvature : other.linkCurvature,
      orbitRadius: t < 0.5 ? orbitRadius : other.orbitRadius,
      orbitSpeed: t < 0.5 ? orbitSpeed : other.orbitSpeed,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is TopologySpec &&
            const DeepCollectionEquality()
                .equals(gatewayNormalStyle, other.gatewayNormalStyle) &&
            const DeepCollectionEquality()
                .equals(gatewayHighLoadStyle, other.gatewayHighLoadStyle) &&
            const DeepCollectionEquality()
                .equals(gatewayOfflineStyle, other.gatewayOfflineStyle) &&
            const DeepCollectionEquality()
                .equals(extenderNormalStyle, other.extenderNormalStyle) &&
            const DeepCollectionEquality()
                .equals(extenderHighLoadStyle, other.extenderHighLoadStyle) &&
            const DeepCollectionEquality()
                .equals(extenderOfflineStyle, other.extenderOfflineStyle) &&
            const DeepCollectionEquality()
                .equals(clientNormalStyle, other.clientNormalStyle) &&
            const DeepCollectionEquality()
                .equals(clientOfflineStyle, other.clientOfflineStyle) &&
            const DeepCollectionEquality()
                .equals(ethernetLinkStyle, other.ethernetLinkStyle) &&
            const DeepCollectionEquality()
                .equals(wifiStrongStyle, other.wifiStrongStyle) &&
            const DeepCollectionEquality()
                .equals(wifiMediumStyle, other.wifiMediumStyle) &&
            const DeepCollectionEquality()
                .equals(wifiWeakStyle, other.wifiWeakStyle) &&
            const DeepCollectionEquality()
                .equals(wifiUnknownStyle, other.wifiUnknownStyle) &&
            const DeepCollectionEquality()
                .equals(nodeSpacing, other.nodeSpacing) &&
            const DeepCollectionEquality()
                .equals(linkCurvature, other.linkCurvature) &&
            const DeepCollectionEquality()
                .equals(orbitRadius, other.orbitRadius) &&
            const DeepCollectionEquality()
                .equals(orbitSpeed, other.orbitSpeed));
  }

  @override
  int get hashCode {
    return Object.hash(
      runtimeType.hashCode,
      const DeepCollectionEquality().hash(gatewayNormalStyle),
      const DeepCollectionEquality().hash(gatewayHighLoadStyle),
      const DeepCollectionEquality().hash(gatewayOfflineStyle),
      const DeepCollectionEquality().hash(extenderNormalStyle),
      const DeepCollectionEquality().hash(extenderHighLoadStyle),
      const DeepCollectionEquality().hash(extenderOfflineStyle),
      const DeepCollectionEquality().hash(clientNormalStyle),
      const DeepCollectionEquality().hash(clientOfflineStyle),
      const DeepCollectionEquality().hash(ethernetLinkStyle),
      const DeepCollectionEquality().hash(wifiStrongStyle),
      const DeepCollectionEquality().hash(wifiMediumStyle),
      const DeepCollectionEquality().hash(wifiWeakStyle),
      const DeepCollectionEquality().hash(wifiUnknownStyle),
      const DeepCollectionEquality().hash(nodeSpacing),
      const DeepCollectionEquality().hash(linkCurvature),
      const DeepCollectionEquality().hash(orbitRadius),
      const DeepCollectionEquality().hash(orbitSpeed),
    );
  }
}

extension TopologySpecBuildContextProps on BuildContext {
  TopologySpec get topologySpec => Theme.of(this).extension<TopologySpec>()!;
  NodeStyle get gatewayNormalStyle => topologySpec.gatewayNormalStyle;
  NodeStyle get gatewayHighLoadStyle => topologySpec.gatewayHighLoadStyle;
  NodeStyle get gatewayOfflineStyle => topologySpec.gatewayOfflineStyle;
  NodeStyle get extenderNormalStyle => topologySpec.extenderNormalStyle;
  NodeStyle get extenderHighLoadStyle => topologySpec.extenderHighLoadStyle;
  NodeStyle get extenderOfflineStyle => topologySpec.extenderOfflineStyle;
  NodeStyle get clientNormalStyle => topologySpec.clientNormalStyle;
  NodeStyle get clientOfflineStyle => topologySpec.clientOfflineStyle;
  LinkStyle get ethernetLinkStyle => topologySpec.ethernetLinkStyle;
  LinkStyle get wifiStrongStyle => topologySpec.wifiStrongStyle;
  LinkStyle get wifiMediumStyle => topologySpec.wifiMediumStyle;
  LinkStyle get wifiWeakStyle => topologySpec.wifiWeakStyle;
  LinkStyle get wifiUnknownStyle => topologySpec.wifiUnknownStyle;

  /// Spacing between nodes in graph view.
  double get nodeSpacing => topologySpec.nodeSpacing;

  /// Curvature of links (0.0 for straight, higher for more curved).
  double get linkCurvature => topologySpec.linkCurvature;

  /// Radius for client orbit around parent nodes.
  double get orbitRadius => topologySpec.orbitRadius;

  /// Duration for one complete orbit cycle.
  Duration get orbitSpeed => topologySpec.orbitSpeed;
}
