import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/color_property.dart' as color_prop;
import '../property_editors/double_property.dart';

class ToastSpecEditor extends StatelessWidget {
  final ToastStyle initialStyle;
  final ValueChanged<ToastStyle> onChanged;

  const ToastSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // Simplify BorderRadius to a single double for MVP editing
    final double currentRadius = initialStyle.borderRadius.topLeft.x;

    return ExpansionTile(
      title: Text('Toast Spec', style: Theme.of(context).textTheme.titleMedium),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              color_prop.ColorProperty(
                label: 'Background Color',
                value: initialStyle.backgroundColor ?? Colors.black,
                onChanged: (color) {
                  // For MVP, we keep other properties constant or default, as ToastStyle has many params (padding, margin, textStyle)
                  // Ideally we should use copyWith, but ToastStyle might not have it or it's generated.
                  // Assuming tailored class has copyWith (ThemeExtension usually does, but Tailor might generate it).
                  // Checking app_design_theme.dart: @TailorMixin used.
                  // Let's try to use the constructor with existing values for now as we can't easily inspect copyWith availability without intellisense.
                  // Actually, better to reconstruct.
                  onChanged(
                    ToastStyle(
                      backgroundColor: color,
                      borderRadius: initialStyle.borderRadius,
                      padding: initialStyle.padding,
                      margin: initialStyle.margin,
                      textStyle: initialStyle.textStyle,
                      displayDuration: initialStyle.displayDuration,
                    ),
                  );
                },
              ),
              const Gap(12),
              DoubleProperty(
                label: 'Border Radius',
                value: currentRadius,
                min: 0,
                max: 32,
                onChanged: (value) {
                  onChanged(
                    ToastStyle(
                      backgroundColor: initialStyle.backgroundColor,
                      borderRadius: BorderRadius.circular(value),
                      padding: initialStyle.padding,
                      margin: initialStyle.margin,
                      textStyle: initialStyle.textStyle,
                      displayDuration: initialStyle.displayDuration,
                    ),
                  );
                },
              ),
              const Gap(12),
              DoubleProperty(
                label: 'Display Duration (s)',
                value: initialStyle.displayDuration.inMilliseconds / 1000.0,
                min: 1,
                max: 10,
                onChanged: (value) {
                  onChanged(
                    ToastStyle(
                      backgroundColor: initialStyle.backgroundColor,
                      borderRadius: initialStyle.borderRadius,
                      padding: initialStyle.padding,
                      margin: initialStyle.margin,
                      textStyle: initialStyle.textStyle,
                      displayDuration: Duration(
                        milliseconds: (value * 1000).toInt(),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
