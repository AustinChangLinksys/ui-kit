import 'package:flutter/material.dart';
import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import test utilities
import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  // Setup: Load fonts
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppGauge Golden Tests', () {
    goldenTest(
      'AppGauge - 75% Value',
      fileName: 'app_gauge_75',
      builder: () => buildThemeMatrix(
        name: '75%',
        width: 300.0,
        height: 300.0,
        child: AppGauge(
          value: 75,
          size: 240,
          markers: const [0, 25, 50, 75, 100],
          centerBuilder: (context, value) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AppText.headlineMedium('${value.toInt()}'),
              AppText.bodySmall('Mbps'),
            ],
          ),
        ),
      ),
    );

    goldenTest(
      'AppGauge - With Default Markers',
      fileName: 'app_gauge_default_markers',
      builder: () => buildThemeMatrix(
        name: 'Default Markers',
        width: 320.0,
        height: 320.0,
        child: AppGauge.withDefaultMarkers(
          value: 65,
          size: 260,
          centerBuilder: (context, value) => AppText.headlineLarge(
            '${value.toInt()}%',
          ),
          bottomBuilder: (context, value) => AppText.bodyMedium(
            'Progress',
          ),
        ),
      ),
    );

    goldenTest(
      'AppGauge - Minimal (No Markers)',
      fileName: 'app_gauge_minimal',
      builder: () => buildThemeMatrix(
        name: 'Minimal',
        width: 250.0,
        height: 250.0,
        child: AppGauge(
          value: 50,
          size: 200,
          displayIndicatorValues: false,
          centerBuilder: (context, value) => AppText.displaySmall(
            '${value.toInt()}%',
          ),
        ),
      ),
    );
  });
}
