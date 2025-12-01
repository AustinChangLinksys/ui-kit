import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/forms/app_text_form_field.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppTextFormField Golden Tests', () {
    goldenTest(
      'AppTextFormField - Idle',
      fileName: 'app_text_form_field_idle',
      builder: () => buildThemeMatrix(
        name: 'Idle',
        width: 300,
        height: 100,
        child: AppTextFormField(
          hintText: 'Idle state',
        ),
      ),
    );

    goldenTest(
      'AppTextFormField - Error',
      fileName: 'app_text_form_field_error',
      builder: () => buildThemeMatrix(
        name: 'Error',
        width: 300,
        height: 120, // Slightly taller for error text
        child: Form(
          autovalidateMode: AutovalidateMode.always,
          child: AppTextFormField(
            initialValue: '',
            hintText: 'Error state',
            validator: (value) => 'This field is required',
          ),
        ),
      ),
    );

    goldenTest(
      'AppTextFormField - Disabled',
      fileName: 'app_text_form_field_disabled',
      builder: () => buildThemeMatrix(
        name: 'Disabled',
        width: 300,
        height: 100,
        child: AppTextFormField(
          enabled: false,
          initialValue: 'Disabled content',
        ),
      ),
    );
  });
}
