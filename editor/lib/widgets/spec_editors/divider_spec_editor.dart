import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/color_property.dart' as color_prop;
import '../property_editors/double_property.dart';
import '../property_editors/enum_property.dart';

class DividerSpecEditor extends StatelessWidget {
  final DividerStyle initialStyle;
  final ValueChanged<DividerStyle> onChanged;

  const DividerSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Divider Spec', style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        '7 parameters',
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
              // 1. Primary Color
              color_prop.ColorProperty(
                label: 'Color',
                value: initialStyle.color,
                onChanged: (color) {
                  onChanged(initialStyle.copyWith(color: color));
                },
              ),
              const Gap(12),
              // 2. Secondary Color
              color_prop.ColorProperty(
                label: 'Secondary Color (for patterns)',
                value: initialStyle.secondaryColor ?? Colors.transparent,
                onChanged: (color) {
                  onChanged(initialStyle.copyWith(secondaryColor: color));
                },
              ),
              const Gap(12),
              // 3. Thickness
              DoubleProperty(
                label: 'Thickness',
                value: initialStyle.thickness,
                min: 0.5,
                max: 10,
                onChanged: (value) {
                  onChanged(initialStyle.copyWith(thickness: value));
                },
              ),
              const Gap(12),
              // 4. Indent (left spacing)
              DoubleProperty(
                label: 'Indent (left spacing)',
                value: initialStyle.indent,
                min: 0,
                max: 100,
                onChanged: (value) {
                  onChanged(initialStyle.copyWith(indent: value));
                },
              ),
              const Gap(12),
              // 5. End Indent (right spacing)
              DoubleProperty(
                label: 'End Indent (right spacing)',
                value: initialStyle.endIndent,
                min: 0,
                max: 100,
                onChanged: (value) {
                  onChanged(initialStyle.copyWith(endIndent: value));
                },
              ),
              const Gap(12),
              // 6. Glow Strength
              DoubleProperty(
                label: 'Glow Strength',
                value: initialStyle.glowStrength,
                min: 0,
                max: 10,
                onChanged: (value) {
                  onChanged(initialStyle.copyWith(glowStrength: value));
                },
              ),
              const Gap(12),
              // 7. Pattern
              EnumProperty<DividerPattern>(
                label: 'Pattern',
                value: initialStyle.pattern,
                options: DividerPattern.values,
                onChanged: (value) {
                  onChanged(initialStyle.copyWith(pattern: value));
                },
                getDisplayName: (e) => e.name,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
