import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Playground',
  type: LiquidGlassCard,
)
Widget buildLiquidGlassCard(BuildContext context) {
  // 定義一個漸層範例 (給 Knobs 選用)
  const rainbowGradient = LinearGradient(
    colors: [
      Color(0x22FF0000),
      Color(0x2200FF00),
      Color(0x220000FF),
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  return Center(
    child: LiquidGlassCard(
      // 透過 Style Object 接收 Knobs 的數值
      style: LiquidGlassStyle(
        width: context.knobs.double.slider(
          label: 'Width',
          initialValue: 300,
          min: 100,
          max: 500,
        ),
        height: context.knobs.double.slider(
          label: 'Height',
          initialValue: 200,
          min: 100,
          max: 500,
        ),
        borderRadius: context.knobs.double.slider(
          label: 'Border Radius',
          initialValue: 24,
          min: 0,
          max: 50,
        ),
        blurStrength: context.knobs.double.slider(
          label: 'Blur Strength',
          initialValue: 15,
          min: 0,
          max: 30,
        ),
        // 測試漸層開關
        sheenGradient: context.knobs.boolean(label: 'Show Sheen', initialValue: true)
            ? rainbowGradient
            : null,
      ),
      // 卡片內容
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.wifi, size: 48, color: Colors.white),
          const SizedBox(height: 16),
          Text(
            context.knobs.string(label: 'Card Text', initialValue: 'Glass UI'),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}