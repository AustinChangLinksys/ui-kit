import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;


/// A simple state wrapper to make the Switch on Widgetbook truly clickable
class _SwitchWrapper extends StatefulWidget {
  final bool initialValue;
  final bool isDisabled;

  const _SwitchWrapper({
    required this.initialValue,
    required this.isDisabled,
  });

  @override
  State<_SwitchWrapper> createState() => _SwitchWrapperState();
}

class _SwitchWrapperState extends State<_SwitchWrapper> {
  late bool _value;

  @override
  void initState() {
    super.initState();
    _value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return AppSwitch(
      value: _value,
      // 當 isDisabled 為 true 時，傳入 null 來模擬禁用狀態
      onChanged: widget.isDisabled
          ? null
          : (newValue) => setState(() => _value = newValue),
    );
  }
}

@widgetbook.UseCase(name: 'Interactive Playground', type: AppSwitch)
Widget interactiveAppSwitch(BuildContext context) {
  // 使用 Knob 來控制是否禁用
  final isDisabled = context.knobs.boolean(
    label: 'Disabled',
    initialValue: false,
  );

  final initialValue = context.knobs.boolean(
    label: 'Initial Value',
    initialValue: true,
  );

  return Center(
    child: _SwitchWrapper(
      initialValue: initialValue,
      isDisabled: isDisabled,
    ),
  );
}

@widgetbook.UseCase(name: 'All States', type: AppSwitch)
Widget appSwitchStates(BuildContext context) {
  // 靜態展示所有狀態，方便設計師 Review
  return const Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Active (On)'),
        SizedBox(height: 8),
        AppSwitch(value: true, onChanged: _dummyCallback),
        
        SizedBox(height: 24),
        
        Text('Inactive (Off)'),
        SizedBox(height: 8),
        AppSwitch(value: false, onChanged: _dummyCallback),

        SizedBox(height: 24),

        Text('Disabled (On)'),
        SizedBox(height: 8),
        AppSwitch(value: true, onChanged: null),

        SizedBox(height: 24),

        Text('Disabled (Off)'),
        SizedBox(height: 8),
        AppSwitch(value: false, onChanged: null),
      ],
    ),
  );
}

void _dummyCallback(bool _) {}