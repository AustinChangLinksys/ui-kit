import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
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

    // Test 1: Primary Action (Highlight Variant)
    goldenTest(
      'AppButton - Primary',
      fileName: 'app_button_primary',
      builder: () => buildThemeMatrix(
        name: 'Primary',
        width: 300,
        height: 100,
        child: AppButton(
          label: 'Confirm',
          onTap: () {},
          variant: SurfaceVariant.highlight,
        ),
      ),
    );

    // Test 2: Secondary Action (Tonal Variant)
    goldenTest(
      'AppButton - Secondary',
      fileName: 'app_button_secondary',
      builder: () => buildThemeMatrix(
        name: 'Secondary',
        width: 300,
        height: 100,
        child: AppButton(
          label: 'Save Draft',
          onTap: () {},
          variant: SurfaceVariant.tonal,
        ),
      ),
    );

    // Test 3: Tertiary Action (Base Variant)
    goldenTest(
      'AppButton - Tertiary',
      fileName: 'app_button_tertiary',
      builder: () => buildThemeMatrix(
        name: 'Tertiary',
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

  group('AppButton Outline Variants Golden Tests', () {
    // Test 1: Primary Outline Button
    goldenTest(
      'AppButton.primaryOutline - Primary',
      fileName: 'app_button_outline_primary',
      builder: () => buildThemeMatrix(
        name: 'Primary Outline',
        width: 300,
        height: 100,
        child: AppButton.primaryOutline(
          label: 'Primary Action',
          onTap: () {},
        ),
      ),
    );

    // Test 2: Secondary Outline Button
    goldenTest(
      'AppButton.secondaryOutline - Secondary',
      fileName: 'app_button_outline_secondary',
      builder: () => buildThemeMatrix(
        name: 'Secondary Outline',
        width: 300,
        height: 100,
        child: AppButton.secondaryOutline(
          label: 'Secondary Action',
          onTap: () {},
        ),
      ),
    );

    // Test 3: Danger Outline Button
    goldenTest(
      'AppButton.dangerOutline - Danger',
      fileName: 'app_button_outline_danger',
      builder: () => buildThemeMatrix(
        name: 'Danger Outline',
        width: 300,
        height: 100,
        child: AppButton.dangerOutline(
          label: 'Delete Item',
          onTap: () {},
        ),
      ),
    );

    // Test 4: Outline Button Disabled State
    goldenTest(
      'AppButton.primaryOutline - Disabled',
      fileName: 'app_button_outline_disabled',
      builder: () => buildThemeMatrix(
        name: 'Outline Disabled',
        width: 300,
        height: 100,
        child: const AppButton.primaryOutline(
          label: 'Disabled',
          onTap: null,
        ),
      ),
    );

    // Test 5: Outline Button with Icons
    goldenTest(
      'AppButton.outline - With Icons',
      fileName: 'app_button_outline_icons',
      builder: () => buildThemeMatrix(
        name: 'Outline Icons',
        width: 500,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton.primaryOutline(
              label: 'Download',
              icon: const Icon(Icons.download),
              iconPosition: AppButtonIconPosition.leading,
              onTap: () {},
            ),
            AppButton.secondaryOutline(
              label: 'Upload',
              icon: const Icon(Icons.upload),
              iconPosition: AppButtonIconPosition.trailing,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  });

  group('AppButton.text() Golden Tests', () {
    // Test 1: Text Button Enabled State
    goldenTest(
      'AppButton.text - Enabled',
      fileName: 'app_text_button_enabled',
      builder: () => buildThemeMatrix(
        name: 'Text Enabled',
        width: 250,
        height: 80,
        child: AppButton.text(
          label: 'Text Button',
          onTap: () {},
        ),
      ),
    );

    // Test 2: Text Button Disabled State
    goldenTest(
      'AppButton.text - Disabled',
      fileName: 'app_text_button_disabled',
      builder: () => buildThemeMatrix(
        name: 'Text Disabled',
        width: 250,
        height: 80,
        child: const AppButton.text(
          label: 'Disabled',
          onTap: null,
        ),
      ),
    );

    // Test 3: Text Button Loading State
    goldenTest(
      'AppButton.text - Loading',
      fileName: 'app_text_button_loading',
      builder: () => buildThemeMatrix(
        name: 'Text Loading',
        width: 250,
        height: 80,
        child: AppButton.text(
          label: 'Loading',
          isLoading: true,
          onTap: () {},
        ),
      ),
    );

    // Test 4: Text Button Different Sizes
    goldenTest(
      'AppButton.text - Sizes',
      fileName: 'app_text_button_sizes',
      builder: () => buildThemeMatrix(
        name: 'Text Sizes',
        width: 350,
        height: 250,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton.text(
              label: 'Small',
              size: AppButtonSize.small,
              onTap: () {},
            ),
            AppButton.text(
              label: 'Medium',
              size: AppButtonSize.medium,
              onTap: () {},
            ),
            AppButton.text(
              label: 'Large',
              size: AppButtonSize.large,
              onTap: () {},
            ),
          ],
        ),
      ),
    );

    // Test 5: Text Button With Icons
    goldenTest(
      'AppButton.text - With Icons',
      fileName: 'app_text_button_icons',
      builder: () => buildThemeMatrix(
        name: 'Text Icons',
        width: 300,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppButton.text(
              label: 'Leading Icon',
              icon: const Icon(Icons.arrow_forward),
              iconPosition: AppButtonIconPosition.leading,
              onTap: () {},
            ),
            AppButton.text(
              label: 'Trailing Icon',
              icon: const Icon(Icons.save),
              iconPosition: AppButtonIconPosition.trailing,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  });
}