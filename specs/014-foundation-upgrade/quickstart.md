# Quickstart Guide: System Foundation Upgrades

This guide helps developers utilize the new dynamic motion system, global visual effects, and adaptive iconography.

## 1. Accessing Dynamic Motion

Instead of hardcoding `Duration` and `Curve` values for animations, use the `UnifiedTheme.motion` property.

```dart
import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart'; // Assuming AppTheme is exposed here

class MyAnimatedWidget extends StatefulWidget {
  const MyAnimatedWidget({super.key});

  @override
  State<MyAnimatedWidget> createState() => _MyAnimatedWidgetState();
}

class _MyAnimatedWidgetState extends State<MyAnimatedWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Access the motion spec from the theme
    final MotionSpec mediumMotion = AppTheme.of(context).motion.medium;

    _controller.duration = mediumMotion.duration;
    _animation = CurveTween(curve: mediumMotion.curve).animate(_controller);
    _controller.forward(); // Start animation
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: Container(
            width: 100,
            height: 100,
            color: Colors.blue,
            child: const Center(child: Text("Animated!")),
          ),
        );
      },
    );
  }
}
```

## 2. Global Visual Effects

The global visual effects are automatically applied by the active theme. No direct developer interaction is needed beyond ensuring your `MaterialApp` uses the provided `builder` or is wrapped appropriately.

## 3. Using Adaptive Icons

The `AppIcon` component now automatically adapts its rendering based on the active theme.

```dart
import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart'; // Assuming AppIcon is exposed here
import 'package:ui_kit_library/src/foundation/gen/assets.gen.dart'; // For SvgGenImage

class MyIconDisplayWidget extends StatelessWidget {
  const MyIconDisplayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // AppIcon now dynamically loads the correct asset based on AppTheme.iconStyle
    return AppIcon(
      AppAssets.icons.home, // Assuming AppAssets.icons.home provides the base identifier
      size: 32.0,
      color: Colors.purple,
    );
  }
}
```

**Note on Icon Asset Naming Conventions**: For `AppIcons` enum values like `AppIcons.home`, the `AppIcon` component will attempt to resolve assets based on the active `AppIconStyle` from `AppTheme.of(context).iconStyle`.
The expected asset naming convention (and corresponding `flutter_gen` property) is:
*   **`AppIconStyle.vectorFilled`**: `icon_name.svg` (e.g., `AppAssets.icons.home.svg` -> `AppAssets.icons.home`)
*   **`AppIconStyle.thinStroke`**: `icon_name_stroke.svg` (e.g., `AppAssets.icons.home_stroke.svg` -> `AppAssets.icons.homeStroke`)
*   **`AppIconStyle.pixelated`**: `icon_name_pixel.svg` or `icon_name_pixel.png` (e.g., `AppAssets.icons.home_pixel.svg` -> `AppAssets.icons.homePixel`)
Developers must ensure these corresponding assets and `flutter_gen` properties exist. SVG assets for icons MUST have their `fill` color attributes removed (Constitution 7.2) to allow dynamic coloring.
