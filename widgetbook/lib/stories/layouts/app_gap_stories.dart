import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

// 為了 Knob 方便，定義一個 Enum
enum GapSizeVariant { xxs, xs, sm, md, lg, xl, xxl, xxxl, gutter }

@widgetbook.UseCase(
  name: 'Interactive Playground',
  type: AppGap,
)
Widget buildInteractiveGap(BuildContext context) {
  final variant = context.knobs.object.dropdown<GapSizeVariant>(
    label: 'Size',
    options: GapSizeVariant.values,
    initialOption: GapSizeVariant.md,
    labelBuilder: (val) => val.name,
  );

  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Box A'),
        Container(
            width: 100, height: 50, color: Colors.blue.withValues(alpha: 0.3)),

        // ✨ 動態切換 Gap
        _buildGap(variant),

        Container(
            width: 100, height: 50, color: Colors.red.withValues(alpha: 0.3)),
        const Text('Box B'),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Size Gallery',
  type: AppGap,
)
Widget buildGapGallery(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _GapRow('xxs', AppGap.xxs()),
        _GapRow('xs', AppGap.xs()),
        _GapRow('sm', AppGap.sm()),
        _GapRow('md', AppGap.md()),
        _GapRow('lg', AppGap.lg()),
        _GapRow('xl', AppGap.xl()),
        _GapRow('xxl', AppGap.xxl()),
        _GapRow('xxxl', AppGap.xxxl()),
        const Divider(height: 32),
        _GapRow('Gutter (Responsive)', AppGap.gutter()),
      ],
    ),
  );
}

// --- Helpers ---

Widget _buildGap(GapSizeVariant variant) {
  switch (variant) {
    case GapSizeVariant.xxs:
      return AppGap.xxs();
    case GapSizeVariant.xs:
      return AppGap.xs();
    case GapSizeVariant.sm:
      return AppGap.sm();
    case GapSizeVariant.md:
      return AppGap.md();
    case GapSizeVariant.lg:
      return AppGap.lg();
    case GapSizeVariant.xl:
      return AppGap.xl();
    case GapSizeVariant.xxl:
      return AppGap.xxl();
    case GapSizeVariant.xxxl:
      return AppGap.xxxl();
    case GapSizeVariant.gutter:
      return AppGap.gutter();
  }
}

class _GapRow extends StatelessWidget {
  final String label;
  final Widget gap;

  const _GapRow(this.label, this.gap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          SizedBox(width: 150, child: Text(label)),
          Container(width: 20, height: 20, color: Colors.grey),
          gap, // The Gap being tested
          Container(width: 20, height: 20, color: Colors.grey),
        ],
      ),
    );
  }
}
