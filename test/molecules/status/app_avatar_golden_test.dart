import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppAvatar Golden Tests', () {
    // Test 1: Avatar fallback with initials (standard sizes)
    goldenTest(
      'AppAvatar - Initials Fallback (Standard & Large)',
      fileName: 'app_avatar_initials_fallback',
      builder: () => buildThemeMatrix(
        name: 'Initials Fallback',
        width: 200,
        height: 100,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Standard size (40px) with initials
            AppAvatar(
              initials: 'AB',
              size: 40,
              imageUrl: null,
            ),
            // Large size (56px) with initials
            AppAvatar(
              initials: 'CD',
              size: 56,
              imageUrl: null,
            ),
          ],
        ),
      ),
    );

    // Test 2: Avatar with single character initials
    goldenTest(
      'AppAvatar - Single Character Initials',
      fileName: 'app_avatar_single_char',
      builder: () => buildThemeMatrix(
        name: 'Single Character',
        width: 200,
        height: 100,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Single character fallback
            AppAvatar(
              initials: 'X',
              size: 40,
              imageUrl: null,
            ),
            // Single character at large size
            AppAvatar(
              initials: 'Y',
              size: 56,
              imageUrl: null,
            ),
          ],
        ),
      ),
    );

    // Test 3: Avatar with empty/long initials edge cases
    goldenTest(
      'AppAvatar - Edge Cases (Empty & Truncated)',
      fileName: 'app_avatar_edge_cases',
      builder: () => buildThemeMatrix(
        name: 'Edge Cases',
        width: 250,
        height: 100,
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Empty initials (fallback to empty circle)
            AppAvatar(
              initials: '',
              size: 40,
              imageUrl: null,
            ),
            // Long initials (should truncate to 2 chars)
            AppAvatar(
              initials: 'ABCD',
              size: 40,
              imageUrl: null,
            ),
            // Three characters (should show first 2)
            AppAvatar(
              initials: 'XYZ',
              size: 56,
              imageUrl: null,
            ),
          ],
        ),
      ),
    );
  });
}