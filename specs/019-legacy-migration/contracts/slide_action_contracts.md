# Slide Action Contracts

```dart
import 'package:flutter/widgets.dart';
import 'package:theme_tailor/theme_tailor.dart';

part 'slide_action_style.tailor.dart';

/// Semantic variants for actions
enum SlideActionVariant {
  standard,
  destructive,
  neutral,
}

/// Data model for a single action
class SlideActionItem {
  final String label;
  final Widget icon;
  final VoidCallback onTap;
  final SlideActionVariant variant;
  final Color? foregroundColor;
  final Color? backgroundColor;

  const SlideActionItem({
    required this.label,
    required this.icon,
    required this.onTap,
    this.variant = SlideActionVariant.standard,
    this.foregroundColor,
    this.backgroundColor,
  });
}

/// Theme Extension for SlideAction
@TailorMixin()
class SlideActionStyle extends ThemeExtension<SlideActionStyle> with _$SlideActionStyleTailorMixin {
  // Appearance
  final Color actionBackground; // Default background
  final Color destructiveBackground; // Error background
  final Color contentColor;
  final double iconSize;
  
  // Style-specific
  final bool showInnerShadow;   // Neumorphic
  final bool isSolidBlock;      // Pixel (no blur/gradient)
  final bool enableBlur;        // Glass
  
  // Motion
  final Duration animationDuration;
  final Curve animationCurve;

  SlideActionStyle({
    required this.actionBackground,
    required this.destructiveBackground,
    required this.contentColor,
    required this.iconSize,
    required this.showInnerShadow,
    required this.isSolidBlock,
    required this.enableBlur,
    required this.animationDuration,
    required this.animationCurve,
  });
}

/// Main Widget
class AppSlideAction extends StatelessWidget {
  final Widget child;
  final List<SlideActionItem> actions;
  final bool enabled;
  final VoidCallback? onOpened;
  final VoidCallback? onClosed;

  const AppSlideAction({
    super.key,
    required this.child,
    required this.actions,
    this.enabled = true,
    this.onOpened,
    this.onClosed,
  });
}
```
