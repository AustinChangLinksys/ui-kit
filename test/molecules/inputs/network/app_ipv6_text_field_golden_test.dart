import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../../test_utils/font_loader.dart';
import '../../../test_utils/golden_test_matrix_factory.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppIPv6TextField Golden Tests', () {
    // 1. Default State (Empty)
    goldenTest(
      'AppIPv6TextField - Default',
      fileName: 'app_ipv6_text_field_default',
      builder: () => buildThemeMatrix(
        name: 'Default',
        width: 400.0,
        height: 100.0,
        child: const AppIPv6TextField(
          label: 'IPv6 Address',
          invalidFormatMessage: 'Invalid format',
          hintText: '2001:0db8:...',
        ),
      ),
    );

    // 2. Compact Value (With Content)
    goldenTest(
      'AppIPv6TextField - Compact Value',
      fileName: 'app_ipv6_text_field_compact',
      builder: () => buildThemeMatrix(
        name: 'Compact',
        width: 400.0,
        height: 100.0,
        child: AppIPv6TextField(
          label: 'IPv6 Client',
          invalidFormatMessage: 'Invalid format',
          controller: TextEditingController(text: '::1'),
        ),
      ),
    );

    // 3. Full Value
    goldenTest(
      'AppIPv6TextField - Full Value',
      fileName: 'app_ipv6_text_field_full',
      builder: () => buildThemeMatrix(
        name: 'Full',
        width: 400.0,
        height: 100.0,
        child: AppIPv6TextField(
          label: 'Host Address',
          invalidFormatMessage: 'Invalid format',
          controller: TextEditingController(
              text: '2001:0db8:0000:0000:0000:0000:0000:0001'),
        ),
      ),
    );
  });
}
