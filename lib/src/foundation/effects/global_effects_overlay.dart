import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/effects/global_effects_type.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';
import 'package:ui_kit_library/src/foundation/effects/noise_overlay.dart';

class GlobalEffectsOverlay extends StatelessWidget {
  final Widget child;
  final int? noiseSeed;

  const GlobalEffectsOverlay({
    super.key,
    required this.child,
    this.noiseSeed,
  });

  @override
  Widget build(BuildContext context) {
    // Use direct theme access if possible, or standard Theme.of(context) extension mechanism
    // Assuming standard usage:
    final theme = Theme.of(context).extension<AppDesignTheme>();
    
    if (theme == null) return child;

    final effectType = theme.visualEffects;

    Widget overlay = const SizedBox.shrink();

    switch (effectType) {
      case GlobalEffectsType.noiseOverlay:
        overlay = NoiseOverlay(seed: noiseSeed);
        break;
      case GlobalEffectsType.crtShader:
        overlay = const _CrtOverlay();
        break;
      case GlobalEffectsType.none:
        // No overlay
        break;
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        child,
        IgnorePointer(
          child: overlay,
        ),
      ],
    );
  }
}

// Remove the inline _NoiseOverlay and _NoisePainter as they are now in noise_overlay.dart


class _CrtOverlay extends StatelessWidget {
  const _CrtOverlay();

  @override
  Widget build(BuildContext context) {
    // Reduced Motion check
    final isReducedMotion = MediaQuery.of(context).disableAnimations;
    if (isReducedMotion) {
       // Return static scanlines without flicker if reduced motion, or just nothing
       return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black.withValues(alpha: 0.1),
              Colors.transparent,
            ],
            stops: const [0.0, 0.1],
            tileMode: TileMode.repeated,
          ),
        ),
      );
    }

    return Stack(
      fit: StackFit.expand,
      children: [
        // Scanlines
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withValues(alpha: 0.1),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5],
              tileMode: TileMode.repeated,
            ),
          ),
        ),
        // Vignette
        Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: 1.5,
              colors: [
                Colors.transparent,
                Colors.black.withValues(alpha: 0.3),
              ],
              stops: const [0.6, 1.0],
            ),
          ),
        ),
      ],
    );
  }
}
