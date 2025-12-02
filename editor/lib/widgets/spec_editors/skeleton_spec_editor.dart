import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../property_editors/color_property.dart' as color_prop;
import '../property_editors/double_property.dart';
import '../property_editors/enum_property.dart';

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
              color_prop.ColorProperty(
                label: 'Base Color',
                value: initialStyle.baseColor,
                onChanged: (color) {
                  onChanged(
                    SkeletonStyle(
                      baseColor: color,
                      highlightColor: initialStyle.highlightColor,
                      animationType: initialStyle.animationType,
                      borderRadius: initialStyle.borderRadius,
                    ),
                  );
                },
              ),
              const Gap(12),
              color_prop.ColorProperty(
                label: 'Highlight Color',
                value: initialStyle.highlightColor,
                onChanged: (color) {
                  onChanged(
                    SkeletonStyle(
                      baseColor: initialStyle.baseColor,
                      highlightColor: color,
                      animationType: initialStyle.animationType,
                      borderRadius: initialStyle.borderRadius,
                    ),
                  );
                },
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
