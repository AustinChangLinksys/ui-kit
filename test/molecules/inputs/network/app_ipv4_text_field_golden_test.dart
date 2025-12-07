import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/inputs/network/app_ipv4_text_field.dart';
import '../../../test_utils/font_loader.dart';
import '../../../test_utils/golden_test_matrix_factory.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppIpv4TextField Golden Tests', () {
    goldenTest(
      'AppIpv4TextField - Default State',
      fileName: 'app_ipv4_text_field_default',
      builder: () => buildThemeMatrix(
        name: 'Default',
        width: 400.0,
        height: 100.0,
        child: AppIpv4TextField(),
      ),
    );

    // Error state test - No Layout Shift Policy
    // Error shown via icon + tooltip, not text below
    goldenTest(
      'AppIpv4TextField - Error State',
      fileName: 'app_ipv4_text_field_error',
      builder: () => buildThemeMatrix(
        name: 'Error',
        width: 450.0,
        height: 100.0,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: AppIpv4TextField(
            label: 'IP Address',
            validator: (_) => 'Invalid IP address format',
          ),
        ),
      ),
    );
  });
}
