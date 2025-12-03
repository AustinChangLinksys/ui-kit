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
    // Simplify BorderRadius and EdgeInsets to doubles for editing
    final double currentRadius = initialStyle.borderRadius.topLeft.x;
    final double currentPadding = initialStyle.padding.top;
    final double currentMargin = initialStyle.margin.top;

    return ExpansionTile(
      title: Text('Toast Spec', style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        '6 parameters',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
      ),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // 1. Background Color
              color_prop.ColorProperty(
                label: 'Background Color',
                value: initialStyle.backgroundColor ?? Colors.black,
                onChanged: (color) {
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

              // 2. Border Radius
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

              // 3. Padding (uniform)
              DoubleProperty(
                label: 'Padding (internal spacing)',
                value: currentPadding,
                min: 4,
                max: 32,
                onChanged: (value) {
                  onChanged(
                    ToastStyle(
                      backgroundColor: initialStyle.backgroundColor,
                      borderRadius: initialStyle.borderRadius,
                      padding: EdgeInsets.all(value),
                      margin: initialStyle.margin,
                      textStyle: initialStyle.textStyle,
                      displayDuration: initialStyle.displayDuration,
                    ),
                  );
                },
              ),
              const Gap(12),

              // 4. Margin (uniform)
              DoubleProperty(
                label: 'Margin (external spacing)',
                value: currentMargin,
                min: 4,
                max: 32,
                onChanged: (value) {
                  onChanged(
                    ToastStyle(
                      backgroundColor: initialStyle.backgroundColor,
                      borderRadius: initialStyle.borderRadius,
                      padding: initialStyle.padding,
                      margin: EdgeInsets.all(value),
                      textStyle: initialStyle.textStyle,
                      displayDuration: initialStyle.displayDuration,
                    ),
                  );
                },
              ),
              const Gap(12),

              // 5. Display Duration
              DoubleProperty(
                label: 'Display Duration (seconds)',
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
              const Gap(12),

              // 6. Text Style (read-only info)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Text Style',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Font Size: ${initialStyle.textStyle.fontSize?.toStringAsFixed(1) ?? "default"}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          Text(
                            'Font Weight: ${initialStyle.textStyle.fontWeight?.toString().split('.').last ?? "normal"}',
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Text style set via theme implementations',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey,
                            fontStyle: FontStyle.italic,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
