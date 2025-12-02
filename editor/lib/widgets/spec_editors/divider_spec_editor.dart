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
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              color_prop.ColorProperty(
                label: 'Color',
                value: initialStyle.color,
                onChanged: (color) {
                  onChanged(DividerStyle(
                    color: color,
                    thickness: initialStyle.thickness,
                    indent: initialStyle.indent,
                    endIndent: initialStyle.endIndent,
                    pattern: initialStyle.pattern,
                  ));
                },
              ),
              const Gap(12),
              DoubleProperty(
                label: 'Thickness',
                value: initialStyle.thickness,
                min: 0.5,
                max: 10,
                onChanged: (value) {
                  onChanged(DividerStyle(
                    color: initialStyle.color,
                    thickness: value,
                    indent: initialStyle.indent,
                    endIndent: initialStyle.endIndent,
                    pattern: initialStyle.pattern,
                  ));
                },
              ),
              const Gap(12),
              DoubleProperty(
                label: 'Indent',
                value: initialStyle.indent,
                min: 0,
                max: 100,
                onChanged: (value) {
                  onChanged(DividerStyle(
                    color: initialStyle.color,
                    thickness: initialStyle.thickness,
                    indent: value,
                    endIndent: initialStyle.endIndent,
                    pattern: initialStyle.pattern,
                  ));
                },
              ),
              const Gap(12),
              EnumProperty<DividerPattern>(
                label: 'Pattern',
                value: initialStyle.pattern,
                options: DividerPattern.values,
                onChanged: (value) {
                  onChanged(DividerStyle(
                    color: initialStyle.color,
                    thickness: initialStyle.thickness,
                    indent: initialStyle.indent,
                    endIndent: initialStyle.endIndent,
                    pattern: value,
                  ));
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
