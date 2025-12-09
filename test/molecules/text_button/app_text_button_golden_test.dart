import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import test utilities
import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  // 1. Setup: Load fonts
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppTextButton Golden Tests', () {
    // Test 1: Basic Enabled State
    goldenTest(
      'AppTextButton - Enabled',
      fileName: 'app_text_button_enabled',
      builder: () => buildThemeMatrix(
        name: 'Enabled',
        width: 250,
        height: 80,
        child: AppTextButton(
          text: 'Text Button',
          onTap: () {},
        ),
      ),
    );

    // Test 2: Disabled State
    goldenTest(
      'AppTextButton - Disabled',
      fileName: 'app_text_button_disabled',
      builder: () => buildThemeMatrix(
        name: 'Disabled',
        width: 250,
        height: 80,
        child: const AppTextButton(
          text: 'Disabled',
          onTap: null,
        ),
      ),
    );

    // Test 3: Loading State
    goldenTest(
      'AppTextButton - Loading',
      fileName: 'app_text_button_loading',
      builder: () => buildThemeMatrix(
        name: 'Loading',
        width: 250,
        height: 80,
        child: AppTextButton(
          text: 'Loading',
          isLoading: true,
          onTap: () {},
        ),
      ),
    );

    // Test 4: Different Sizes
    goldenTest(
      'AppTextButton - Sizes',
      fileName: 'app_text_button_sizes',
      builder: () => buildThemeMatrix(
        name: 'Sizes',
        width: 350,
        height: 180,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppTextButton(
              text: 'Small',
              size: AppButtonSize.small,
              onTap: () {},
            ),
            AppTextButton(
              text: 'Medium',
              size: AppButtonSize.medium,
              onTap: () {},
            ),
            AppTextButton(
              text: 'Large',
              size: AppButtonSize.large,
              onTap: () {},
            ),
          ],
        ),
      ),
    );

    // Test 5: With Icons
    goldenTest(
      'AppTextButton - With Icons',
      fileName: 'app_text_button_icons',
      builder: () => buildThemeMatrix(
        name: 'With Icons',
        width: 300,
        height: 120,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppTextButton(
              text: 'Leading Icon',
              icon: Icons.arrow_forward,
              iconPosition: AppButtonIconPosition.leading,
              onTap: () {},
            ),
            AppTextButton(
              text: 'Trailing Icon',
              icon: Icons.save,
              iconPosition: AppButtonIconPosition.trailing,
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  });
}
