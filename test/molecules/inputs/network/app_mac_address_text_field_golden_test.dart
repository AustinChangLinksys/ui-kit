import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/inputs/network/app_mac_address_text_field.dart';
import '../../../test_utils/font_loader.dart';
import '../../../test_utils/golden_test_matrix_factory.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppMacAddressTextField Golden Tests', () {
    goldenTest(
      'AppMacAddressTextField - Default State',
      fileName: 'app_mac_address_text_field_default',
      builder: () => buildThemeMatrix(
        name: 'Default',
        width: 300.0,
        height: 100.0,
        child: const AppMacAddressTextField(
          label: 'MAC Address',
          invalidFormatMessage: 'Invalid format',
        ),
      ),
    );

    // Error State - No Layout Shift Policy
    // Error shown via icon + tooltip, not text below
    goldenTest(
      'AppMacAddressTextField - Error State',
      fileName: 'app_mac_address_text_field_error',
      builder: () => buildThemeMatrix(
        name: 'Error',
        width: 300.0,
        height: 100.0,
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: AppMacAddressTextField(
            label: 'MAC Address',
            invalidFormatMessage: 'Invalid MAC format',
            controller: TextEditingController(text: 'XX:XX'),
          ),
        ),
      ),
    );
  });
}
