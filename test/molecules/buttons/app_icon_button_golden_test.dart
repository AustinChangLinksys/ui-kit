import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import test utilities
import '../../test_utils/golden_test_matrix_factory.dart'; // ✨ Matrix factory
import '../../test_utils/font_loader.dart'; // ✨ Font loader

void main() {
  // 1. Setup: Load fonts (Constitution B.1)
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppIconButton StyleVariant Golden Tests', () {
    // Test 1: Filled Style (Default)
    goldenTest(
      'AppIconButton - Filled',
      fileName: 'app_icon_button_filled',
      builder: () => buildThemeMatrix(
        name: 'Filled',
        width: 100,
        height: 100,
        child: AppIconButton(
          icon: const Icon(Icons.home),
          onTap: () {},
          styleVariant: ButtonStyleVariant.filled,
        ),
      ),
    );

    // Test 2: Outline Style
    goldenTest(
      'AppIconButton - Outline',
      fileName: 'app_icon_button_outline',
      builder: () => buildThemeMatrix(
        name: 'Outline',
        width: 100,
        height: 100,
        child: AppIconButton.outline(
          icon: const Icon(Icons.settings),
          onTap: () {},
        ),
      ),
    );

    // Test 3: Icon-only (Text) Style
    goldenTest(
      'AppIconButton - Icon Only',
      fileName: 'app_icon_button_icon_only',
      builder: () => buildThemeMatrix(
        name: 'Icon Only',
        width: 100,
        height: 100,
        child: AppIconButton.icon(
          icon: const Icon(Icons.close),
          onTap: () {},
        ),
      ),
    );
  });

  group('AppIconButton SurfaceVariant Golden Tests', () {
    // Test 1: Primary (Highlight Variant)
    goldenTest(
      'AppIconButton - Primary',
      fileName: 'app_icon_button_primary',
      builder: () => buildThemeMatrix(
        name: 'Primary',
        width: 100,
        height: 100,
        child: AppIconButton.primary(
          icon: const Icon(Icons.add),
          onTap: () {},
        ),
      ),
    );

    // Test 2: Secondary (Tonal Variant)
    goldenTest(
      'AppIconButton - Secondary',
      fileName: 'app_icon_button_secondary',
      builder: () => buildThemeMatrix(
        name: 'Secondary',
        width: 100,
        height: 100,
        child: AppIconButton.secondary(
          icon: const Icon(Icons.favorite),
          onTap: () {},
        ),
      ),
    );

    // Test 3: Tertiary (Base Variant)
    goldenTest(
      'AppIconButton - Tertiary',
      fileName: 'app_icon_button_tertiary',
      builder: () => buildThemeMatrix(
        name: 'Tertiary',
        width: 100,
        height: 100,
        child: AppIconButton(
          icon: const Icon(Icons.home),
          onTap: () {},
          variant: SurfaceVariant.base,
        ),
      ),
    );

    // Test 4: Danger (Accent Variant)
    goldenTest(
      'AppIconButton - Danger',
      fileName: 'app_icon_button_danger',
      builder: () => buildThemeMatrix(
        name: 'Danger',
        width: 100,
        height: 100,
        child: AppIconButton.danger(
          icon: const Icon(Icons.delete),
          onTap: () {},
        ),
      ),
    );
  });

  group('AppIconButton State Golden Tests', () {
    // Test 1: Loading State
    goldenTest(
      'AppIconButton - Loading',
      fileName: 'app_icon_button_loading',
      builder: () => buildThemeMatrix(
        name: 'Loading',
        width: 100,
        height: 100,
        child: AppIconButton(
          icon: const Icon(Icons.add),
          isLoading: true,
          onTap: () {},
        ),
      ),
    );

    // Test 2: Disabled State
    goldenTest(
      'AppIconButton - Disabled',
      fileName: 'app_icon_button_disabled',
      builder: () => buildThemeMatrix(
        name: 'Disabled',
        width: 100,
        height: 100,
        child: const AppIconButton(
          icon: Icon(Icons.add),
          onTap: null,
        ),
      ),
    );

    // Test 3: Toggle Active State
    goldenTest(
      'AppIconButton - Toggle Active',
      fileName: 'app_icon_button_toggle_active',
      builder: () => buildThemeMatrix(
        name: 'Toggle Active',
        width: 100,
        height: 100,
        child: AppIconButton.toggle(
          icon: const Icon(Icons.volume_off),
          isActive: true,
          onTap: () {},
        ),
      ),
    );

    // Test 4: Toggle Inactive State
    goldenTest(
      'AppIconButton - Toggle Inactive',
      fileName: 'app_icon_button_toggle_inactive',
      builder: () => buildThemeMatrix(
        name: 'Toggle Inactive',
        width: 100,
        height: 100,
        child: AppIconButton.toggle(
          icon: const Icon(Icons.volume_up),
          isActive: false,
          onTap: () {},
        ),
      ),
    );
  });

  group('AppIconButton Size Golden Tests', () {
    // Test 1: All Sizes Comparison
    goldenTest(
      'AppIconButton - Sizes',
      fileName: 'app_icon_button_sizes',
      builder: () => buildThemeMatrix(
        name: 'Sizes',
        width: 300,
        height: 100,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            AppIconButton.small(
              icon: const Icon(Icons.home),
              onTap: () {},
            ),
            AppIconButton(
              icon: const Icon(Icons.home),
              size: AppButtonSize.medium,
              onTap: () {},
            ),
            AppIconButton.large(
              icon: const Icon(Icons.home),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  });

  group('AppIconButton Combined Variants Golden Tests', () {
    // Test: StyleVariant + SurfaceVariant combinations
    goldenTest(
      'AppIconButton - Outline Primary',
      fileName: 'app_icon_button_outline_primary',
      builder: () => buildThemeMatrix(
        name: 'Outline Primary',
        width: 100,
        height: 100,
        child: AppIconButton.outline(
          icon: const Icon(Icons.edit),
          variant: SurfaceVariant.highlight,
          onTap: () {},
        ),
      ),
    );

    goldenTest(
      'AppIconButton - Icon Primary',
      fileName: 'app_icon_button_icon_primary',
      builder: () => buildThemeMatrix(
        name: 'Icon Primary',
        width: 100,
        height: 100,
        child: AppIconButton.icon(
          icon: const Icon(Icons.close),
          variant: SurfaceVariant.highlight,
          onTap: () {},
        ),
      ),
    );
  });
}
