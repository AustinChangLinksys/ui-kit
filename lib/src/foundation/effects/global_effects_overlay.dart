import 'package:flutter/material.dart';

import 'crt_overlay.dart';
import 'global_effects_type.dart';
import 'noise_overlay.dart';
import '../theme/design_system/app_design_theme.dart';

/// Applies theme-specific visual effects as an overlay on top of the app content.
///
/// This widget automatically reads the [GlobalEffectsType] from the current
/// [AppDesignTheme] and renders the appropriate effect overlay.
///
/// Supported effects:
/// - [GlobalEffectsType.noiseOverlay]: Film grain noise effect (Glass theme)
/// - [GlobalEffectsType.crtShader]: CRT monitor effect (Pixel theme)
/// - [GlobalEffectsType.none]: No overlay effect
///
/// The overlay is wrapped in [IgnorePointer] to ensure it doesn't
/// interfere with user interactions.
///
/// This widget is automatically included in [DesignSystem.init], so you
/// typically don't need to use it directly.
class GlobalEffectsOverlay extends StatelessWidget {
  /// The content to display beneath the effect overlay.
  final Widget child;

  /// Optional seed for noise generation to ensure consistent patterns.
  final int? noiseSeed;

  const GlobalEffectsOverlay({
    super.key,
    required this.child,
    this.noiseSeed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>();

    // Skip overlay if theme is not available
    if (theme == null) return child;

    final overlay = _buildOverlay(theme.visualEffects);

    // Optimize: skip Stack if no overlay is needed
    if (overlay == null) return child;

    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        IgnorePointer(child: overlay),
      ],
    );
  }

  /// Builds the appropriate overlay widget based on the effect type.
  Widget? _buildOverlay(GlobalEffectsType effectType) {
    return switch (effectType) {
      GlobalEffectsType.noiseOverlay => NoiseOverlay(seed: noiseSeed),
      GlobalEffectsType.crtShader => const CrtOverlay(),
      GlobalEffectsType.none => null,
    };
  }
}
