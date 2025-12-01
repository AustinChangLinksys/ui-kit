import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/feedback/app_loader.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppLoader Golden Tests', () {
    goldenTest(
      'AppLoader - Circular Indeterminate',
      fileName: 'app_loader_circular_indeterminate',
      builder: () => buildThemeMatrix(
        name: 'Circular Indeterminate',
        width: 200,
        height: 100,
        child: AppLoader(variant: LoaderVariant.circular),
      ),
    );

    goldenTest(
      'AppLoader - Circular Determinate',
      fileName: 'app_loader_circular_determinate',
      builder: () => buildThemeMatrix(
        name: 'Circular Determinate',
        width: 200,
        height: 100,
        child: AppLoader(variant: LoaderVariant.circular, value: 0.75),
      ),
    );

    goldenTest(
      'AppLoader - Linear Indeterminate',
      fileName: 'app_loader_linear_indeterminate',
      builder: () => buildThemeMatrix(
        name: 'Linear Indeterminate',
        width: 200,
        height: 100,
        child: SizedBox(
          width: 150,
          child: AppLoader(variant: LoaderVariant.linear),
        ),
      ),
    );

    goldenTest(
      'AppLoader - Linear Determinate',
      fileName: 'app_loader_linear_determinate',
      builder: () => buildThemeMatrix(
        name: 'Linear Determinate',
        width: 200,
        height: 100,
        child: SizedBox(
          width: 150,
          child: AppLoader(variant: LoaderVariant.linear, value: 0.5),
        ),
      ),
    );
  });
}