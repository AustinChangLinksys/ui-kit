import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A semantic card component with optional selection state styling.
///
/// Cards automatically switch between **Base** and **Tonal** surfaces based on
/// the [isSelected] parameter, enabling multi-select patterns (e.g., device grids).
///
/// **Example - Multi-select Device Grid**:
/// ```dart
/// AppCard(
///   isSelected: selectedDevices.contains(device.id),
///   onTap: () => toggleDeviceSelection(device.id),
///   child: Column(
///     children: [
///       AppIcon(Icons.phone_android),
///       SizedBox(height: 8),
///       AppText(device.name),
///     ],
///   ),
/// )
/// ```
///
/// **Visual Hierarchy**:
/// - `isSelected: false`: Base surface (neutral background)
/// - `isSelected: true`: Tonal surface (selected/active state)
class AppCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  /// Whether this card is in the selected/active state.
  /// When true, automatically applies the Tonal surface style.
  /// When false, uses the Base surface style.
  final bool isSelected;

  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.width,
    this.height,
    this.padding,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).extension<AppDesignTheme>()!;
    return AppSurface(
      variant: isSelected ? SurfaceVariant.tonal : SurfaceVariant.base,
      onTap: onTap,
      width: width,
      height: height,
      padding: padding ?? EdgeInsets.all(16.0 * theme.spacingFactor),
      child: child,
    );
  }
}
