import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/foundation/effects/global_effects_overlay.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/font_loader.dart';
import '../../test_utils/golden_test_matrix_factory.dart';


void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('GlobalEffectsOverlay Golden Tests', () {
    goldenTest(
      'GlobalEffectsOverlay - Theme Variants',
      fileName: 'global_effects_overlay',
      pumpWidget: (tester, widget) async {
        // Using pumpWidget with duration to allow potential animations (though we freeze them in Safe Mode)
        // Ideally for effects we might want to see one frame.
        // For TickerMode(enabled: false), animations should stop at 0.
        await tester.pumpWidget(widget);
      },
      builder: () => GoldenTestGroup(
        children: [
          buildThemeMatrix(
            name: 'Overlay Effects',
            width: 400.0,
            height: 300.0,
            child: GlobalEffectsOverlay(
              noiseSeed: 12345, // Fixed seed for deterministic testing
              child: Center(
                child: Container(
                  width: 200,
                  height: 100,
                  color: Colors.white,
                  child: const Center(child: Text('Content Behind Overlay')),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  });
}
