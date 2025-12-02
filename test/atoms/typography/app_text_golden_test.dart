import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/atoms/typography/app_text.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppText Golden Tests', () {
    goldenTest(
      'AppText Matrix',
      fileName: 'app_text_matrix',
      builder: () => buildThemeMatrix(
        name: 'AppText',
        width: 350, // Text tests require more width
        height: 600, // Height extended to accommodate all levels
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Semantic Factories (semantic shortcuts - most common)
            const _SectionHeader('Semantic Aliases'),
            AppText.headline('Headline (H3)'),
            AppText.subhead('Subhead (Subtitle2)'),
            AppText.body(
                'Body text: The quick brown fox jumps over the lazy dog.'),
            AppText.caption('Caption (Helper text)'),
            AppText.tiny('Tiny (Tags/Timestamp)'),

            const Divider(height: 24),

            // 2. Material 3 Standard Levels (standard levels - precise control)
            const _SectionHeader('Material 3 Scale'),
            AppText.displaySmall('Display Small'),
            AppText.headlineSmall('Headline Small'),
            AppText.titleMedium('Title Medium'),
            AppText.labelLarge('Label Large (Button)'),
            AppText.bodySmall('Body Small'),

            const Divider(height: 24),

            // 3. Custom Extensions (custom extensions)
            const _SectionHeader('Custom / Overrides'),
            AppText.bodyExtraSmall('Body Extra Small (10sp)'),
            // Test color override
            AppText.body('Colored Text (Primary)', color: Colors.blue), // Use a fixed color for golden tests
            // Test weight override
            const AppText('Bold Body Text', fontWeight: FontWeight.w900),
          ],
        ),
      ),
    );
  });
}

// Helper for test subtitles
class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.grey.withValues(alpha: 0.5),
          fontSize: 10,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
        ),
      ),
    );
  }
}