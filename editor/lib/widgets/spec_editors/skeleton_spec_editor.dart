import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/double_property.dart';
import '../property_editors/enum_property.dart';
import 'color_info_display.dart';

class SkeletonSpecEditor extends StatelessWidget {
  final SkeletonStyle initialStyle;
  final ValueChanged<SkeletonStyle> onChanged;

  const SkeletonSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(
        'Skeleton Spec',
        style: Theme.of(context).textTheme.titleMedium,
      ),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              ColorInfoDisplay(
                label: 'Base Color',
                color: initialStyle.baseColor,
                sourceColor: 'Set via theme implementation',
                note: 'Modify in Colors tab to change scheme colors',
              ),
              const Gap(12),
              ColorInfoDisplay(
                label: 'Highlight Color',
                color: initialStyle.highlightColor,
                sourceColor: 'Set via theme implementation',
                note: 'Modify in Colors tab to change scheme colors',
              ),
              const Gap(12),
              DoubleProperty(
                label: 'Border Radius',
                value: initialStyle.borderRadius,
                min: 0,
                max: 32,
                onChanged: (value) {
                  onChanged(
                    SkeletonStyle(
                      baseColor: initialStyle.baseColor,
                      highlightColor: initialStyle.highlightColor,
                      animationType: initialStyle.animationType,
                      borderRadius: value,
                    ),
                  );
                },
              ),
              const Gap(12),
              EnumProperty<SkeletonAnimationType>(
                label: 'Animation Type',
                value: initialStyle.animationType,
                options: SkeletonAnimationType.values,
                onChanged: (value) {
                  onChanged(
                    SkeletonStyle(
                      baseColor: initialStyle.baseColor,
                      highlightColor: initialStyle.highlightColor,
                      animationType: value,
                      borderRadius: initialStyle.borderRadius,
                    ),
                  );
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
