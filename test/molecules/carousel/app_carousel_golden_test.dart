import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../../test_utils/font_loader.dart';
import '../../test_utils/golden_test_matrix_factory.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppCarousel Golden Tests', () {
    goldenTest(
      'AppCarousel - Default State',
      fileName: 'carousel_default',
      builder: () => buildThemeMatrix(
        name: 'Default',
        width: 300.0,
        height: 350.0,
        child: AppCarousel(
          itemCount: 5,
          itemHeight: 280,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(200),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: AppText(
                  'Item ${index + 1}',
                  variant: AppTextVariant.headlineSmall,
                ),
              ),
            );
          },
        ),
      ),
    );

    goldenTest(
      'AppCarousel - At First Item',
      fileName: 'carousel_first_item',
      builder: () => buildThemeMatrix(
        name: 'First Item',
        width: 300.0,
        height: 350.0,
        child: AppCarousel(
          itemCount: 5,
          itemHeight: 280,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.green.shade200,
                    Colors.green.shade400,
                  ],
                ),
              ),
              child: Center(
                child: AppText(
                  'Item ${index + 1}',
                  variant: AppTextVariant.headlineSmall,
                ),
              ),
            );
          },
        ),
      ),
    );

    goldenTest(
      'AppCarousel - At Last Item',
      fileName: 'carousel_last_item',
      builder: () => buildThemeMatrix(
        name: 'Last Item',
        width: 300.0,
        height: 350.0,
        child: AppCarousel(
          itemCount: 5,
          itemHeight: 280,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.orange.shade200,
                    Colors.red.shade400,
                  ],
                ),
              ),
              child: Center(
                child: AppText(
                  'Item ${index + 1}',
                  variant: AppTextVariant.headlineSmall,
                ),
              ),
            );
          },
        ),
      ),
    );

    goldenTest(
      'AppCarousel - With Navigation Buttons',
      fileName: 'carousel_with_nav',
      builder: () => buildThemeMatrix(
        name: 'With Navigation',
        width: 300.0,
        height: 350.0,
        child: AppCarousel(
          itemCount: 5,
          itemHeight: 280,
          showNavigationButtons: true,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.purple.shade200,
                    Colors.indigo.shade400,
                  ],
                ),
              ),
              child: Center(
                child: AppText(
                  'Item ${index + 1}',
                  variant: AppTextVariant.headlineSmall,
                ),
              ),
            );
          },
        ),
      ),
    );
  });
}
