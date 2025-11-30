import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/surfaces/app_surface.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_theme.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/app_design_theme.dart';

class AppSlider extends StatelessWidget {
  const AppSlider({
    required this.value,
    required this.onChanged,
    this.min = 0.0,
    this.max = 1.0,
    this.divisions,
    super.key,
  });

  final double value;
  final ValueChanged<double>? onChanged;
  final double min;
  final double max;
  final int? divisions;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final isDisabled = onChanged == null;

    // 1. Calculate progress (0.0 - 1.0)
    final range = max - min;
    final fraction = range == 0 ? 0.0 : (value.clamp(min, max) - min) / range;

    return LayoutBuilder(
      builder: (context, constraints) {
        final width = constraints.maxWidth;
        // Dimensions scale with Theme
        final thumbSize = 24.0 * theme.spacingFactor;
        final trackHeight = 6.0 * theme.spacingFactor;

        // Movable width of Thumb center point
        final trackWidth = width - thumbSize;

        // Thumb left position
        final thumbLeft = trackWidth * fraction;

        return GestureDetector(
          // Supports clicking the track to jump
          onTapUp: isDisabled
              ? null
              : (details) {
                  _handleInput(details.localPosition.dx, trackWidth, thumbSize);
                },
          // Supports dragging (removed unused onHorizontalDragStart/End)
          onHorizontalDragUpdate: isDisabled
              ? null
              : (details) {
                  _handleInput(details.localPosition.dx, trackWidth, thumbSize);
                },
          child: Container(
            height: thumbSize, // Overall height determined by Thumb
            width: width,
            color: Colors.transparent, // Expand click area
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                // 1. Track (Background Track)
                AppSurface(
                  variant: SurfaceVariant.base,
                  width: width,
                  height: trackHeight,
                  shape: BoxShape.rectangle,
                  // Force capsule track
                  style: theme.surfaceBase.copyWith(borderRadius: 99.0),
                  padding: EdgeInsets.zero,
                  // Draw ticks if in discrete mode
                  child: divisions != null
                      ? _buildTicks(theme, width)
                      : const SizedBox.shrink(),
                ),

                // 2. Fill (Progress Bar - Highlight)
                AppSurface(
                  variant: SurfaceVariant.highlight,
                  width: thumbLeft + (thumbSize / 2),
                  height: trackHeight,
                  style: theme.surfaceHighlight.copyWith(borderRadius: 99.0),
                  padding: EdgeInsets.zero,
                  child: const SizedBox.shrink(),
                ),

                // 3. Thumb (Slider - Elevated)
                Positioned(
                  left: thumbLeft,
                  child: AppSurface(
                    variant: SurfaceVariant.elevated,
                    width: thumbSize,
                    height: thumbSize,
                    shape: BoxShape.circle,
                    padding: EdgeInsets.zero,
                    // Although dragging is handled by the parent, interactive: true
                    // still allows the Thumb to display Theme-defined physical effects (Glow/Scale) when clicked.
                    interactive: true,
                    child: const SizedBox.shrink(),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleInput(double dx, double trackWidth, double thumbSize) {
    // Correct coordinates: subtract Thumb radius offset
    final relativeX = dx - (thumbSize / 2);
    double newFraction = (relativeX / trackWidth).clamp(0.0, 1.0);

    double newValue = min + (newFraction * (max - min));

    // Handle discrete steps (Snapping)
    if (divisions != null && divisions! > 0) {
      final stepSize = (max - min) / divisions!;
      final steps = (newValue - min) / stepSize;
      final snappedSteps = steps.round();
      newValue = min + (snappedSteps * stepSize);
    }

    if (newValue != value) {
      onChanged!(newValue.clamp(min, max));
    }
  }

  Widget _buildTicks(AppDesignTheme theme, double width) {
    final count = divisions!;
    if (count > 20) return const SizedBox.shrink();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(count + 1, (index) {
        if (index == 0 || index == count) return const SizedBox(width: 2);

        return Container(
          width: 2,
          height: 4,
          color: theme.surfaceBase.contentColor.withValues(alpha: 0.3),
        );
      }),
    );
  }
}
