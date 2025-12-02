import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Interactive Tooltip',
  type: AppTooltip,
)
Widget buildInteractiveTooltip(BuildContext context) {
  // 1. Knobs
  final message = context.knobs.string(
    label: 'Message',
    initialValue: 'This is a helpful tooltip',
  );

  final position = context.knobs.object.dropdown<AxisDirection>(
    label: 'Position',
    options: AxisDirection.values,
    initialOption: AxisDirection.up,
    labelBuilder: (val) => val.name,
  );

  final useRichContent = context.knobs.boolean(
    label: 'Use Rich Content',
    initialValue: false,
  );

  // 2. 構建
  return DesignSystem.init(
    context,
    Center(
      child: AppTooltip(
        position: position,
        // 根據 Knob 決定顯示文字還是複雜內容
        message: useRichContent ? null : message,
        content: useRichContent ? _buildRichContent(context) : null,
        child: AppButton(
          label: 'Hover / Long Press Me',
          onTap: () {},
        ),
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'Positions Gallery',
  type: AppTooltip,
)
Widget buildTooltipGallery(BuildContext context) {
  // 靜態展示：雖然不能自動全部打開（因為需要互動），但可以讓開發者測試各個方向
  return DesignSystem.init(
    context,
    const Center(
      child: Wrap(
        spacing: 48, // 加大間距以免 Tooltip 重疊
        runSpacing: 80, // 留垂直空間給 Tooltip
        alignment: WrapAlignment.center,
        children: [
          _TooltipDemo(
              label: 'Top',
              tooltip: AppTooltip(
                message: 'Tooltip Top',
                position: AxisDirection.up,
                child:
                    AppIconButton(icon: Icon(Icons.arrow_upward), onTap: null),
              )),
          _TooltipDemo(
              label: 'Bottom',
              tooltip: AppTooltip(
                message: 'Tooltip Bottom',
                position: AxisDirection.down,
                child: AppIconButton(
                    icon: Icon(Icons.arrow_downward), onTap: null),
              )),
          _TooltipDemo(
              label: 'Left',
              tooltip: AppTooltip(
                message: 'Left Side',
                position: AxisDirection.left,
                child: AppIconButton(icon: Icon(Icons.arrow_back), onTap: null),
              )),
          _TooltipDemo(
              label: 'Right',
              tooltip: AppTooltip(
                message: 'Right Side',
                position: AxisDirection.right,
                child:
                    AppIconButton(icon: Icon(Icons.arrow_forward), onTap: null),
              )),
        ],
      ),
    ),
  );
}

// --- Helpers ---

Widget _buildRichContent(BuildContext context) {
  return Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      const AppAvatar(initials: 'JD', size: 32),
      const SizedBox(width: 8),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const AppText('John Doe', fontWeight: FontWeight.bold),
          AppText.caption('Online', color: Colors.green),
        ],
      ),
    ],
  );
}

class _TooltipDemo extends StatelessWidget {
  final String label;
  final Widget tooltip;

  const _TooltipDemo({required this.label, required this.tooltip});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        tooltip,
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 10)),
      ],
    );
  }
}
