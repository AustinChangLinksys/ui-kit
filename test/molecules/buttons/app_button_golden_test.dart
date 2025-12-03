import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import test utilities
import '../../test_utils/golden_test_matrix_factory.dart'; // ✨ Matrix factory
import '../../test_utils/font_loader.dart'; // ✨ Font loader

void main() {
  // 1. Setup: Load fonts
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppButton Golden Tests', () {

    // Test 1: Highlight Variant (Primary CTA)
    goldenTest(
      'AppButton - Highlight',
      fileName: 'app_button_highlight',
      builder: () => buildThemeMatrix(
        name: 'Highlight',
        width: 300,
        height: 100,
        child: AppButton(
          label: 'Confirm',
          onTap: () {},
          variant: SurfaceVariant.highlight,
        ),
      ),
    );

    // Test 2: Tonal Variant (Secondary Action)
    goldenTest(
      'AppButton - Tonal',
      fileName: 'app_button_tonal',
      builder: () => buildThemeMatrix(
        name: 'Tonal',
        width: 300,
        height: 100,
        child: AppButton(
          label: 'Save Draft',
          onTap: () {},
          variant: SurfaceVariant.tonal,
        ),
      ),
    );

    // Test 3: Base Variant (Low Priority)
    goldenTest(
      'AppButton - Base',
      fileName: 'app_button_base',
      builder: () => buildThemeMatrix(
        name: 'Base',
        width: 300,
        height: 100,
        child: AppButton(
          label: 'Cancel',
          onTap: () {},
          variant: SurfaceVariant.base,
        ),
      ),
    );

    // Test 4: Loading State
    goldenTest(
      'AppButton - Loading',
      fileName: 'app_button_loading',
      builder: () => buildThemeMatrix(
        name: 'Loading',
        width: 300,
        height: 100,
        // Matrix factory internally calls buildSafeScenario with disableAnimation: true
        // Animations are frozen automatically to prevent timeout
        child: AppButton(
          label: 'Loading',
          isLoading: true,
          onTap: () {},
        ),
      ),
    );

    // Test 5: Disabled State
    goldenTest(
      'AppButton - Disabled',
      fileName: 'app_button_disabled',
      builder: () => buildThemeMatrix(
        name: 'Disabled',
        width: 300,
        height: 100,
        child: const AppButton(
          label: 'Disabled',
          onTap: null,
        ),
      ),
    );
  });
}