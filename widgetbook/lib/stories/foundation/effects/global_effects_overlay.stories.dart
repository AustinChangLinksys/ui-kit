import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

@widgetbook.UseCase(
  name: 'Global Effects Overlay',
  type: GlobalEffectsOverlay,
)
Widget buildGlobalEffectsOverlayUseCase(BuildContext context) {
  return GlobalEffectsOverlay(
    child: Center(
      child: Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Global Effects Demo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Switch themes to see effects:\n'
              '• Flat: No effect\n'
              '• Glass: Noise/Grain\n'
              '• Pixel: Scanlines/CRT',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            AppButton(
              label: 'Action Button',
              onTap: () {},
            ),
          ],
        ),
      ),
    ),
  );
}