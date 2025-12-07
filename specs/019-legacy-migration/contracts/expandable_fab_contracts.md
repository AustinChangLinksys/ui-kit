# Expandable FAB Contracts

```dart
import 'package:flutter/widgets.dart';
import 'package:theme_tailor/theme_tailor.dart';

part 'expandable_fab_style.tailor.dart';

enum FabAnimationType {
  fanOut,
  float,
  gridSnap,
  spring,
}

/// Theme Extension for ExpandableFab
@TailorMixin()
class ExpandableFabStyle extends ThemeExtension<ExpandableFabStyle> with _$ExpandableFabStyleTailorMixin {
  // Shape & Geometry
  final BoxShape shape;         // Circle vs Square
  final double distance;        // Distance of satellite actions
  final FabAnimationType type;  // Animation strategy
  
  // Overlay/Scrim
  final Color overlayColor;
  final bool enableBlur;        // Glass
  final bool showDitherPattern; // Pixel
  
  // Visuals
  final bool glowEffect;        // Glass
  final bool highContrastBorder; // Pixel/Brutal

  ExpandableFabStyle({
    required this.shape,
    required this.distance,
    required this.type,
    required this.overlayColor,
    required this.enableBlur,
    required this.showDitherPattern,
    required this.glowEffect,
    required this.highContrastBorder,
  });
}

/// Main Widget
class AppExpandableFab extends StatelessWidget {
  /// Recommended to use [AppIconButton] for consistent styling.
  final List<Widget> children;
  final Widget? icon; // Defaults to '+'
  final Widget? activeIcon; // Defaults to 'x'
  final bool initiallyOpen;
  
  const AppExpandableFab({
    super.key,
    required this.children,
    this.icon,
    this.activeIcon,
    this.initiallyOpen = false,
  });
}
```
