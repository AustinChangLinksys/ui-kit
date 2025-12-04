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
      'AppCarousel - Default (Item 1) with Navigation',
      fileName: 'carousel_default_item1',
      builder: () => buildThemeMatrix(
        name: 'Default\n(Item 1/5)\nPrev: Disabled',
        width: 300.0,
        height: 400.0,
        child: AppCarousel(
          itemCount: 5,
          itemHeight: 280,
          showNavigationButtons: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(200),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.blue.shade900,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    'Item ${index + 1}',
                    fontWeight: FontWeight.bold,
                    variant: AppTextVariant.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  AppText(
                    'of 5',
                    variant: AppTextVariant.bodySmall,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    goldenTest(
      'AppCarousel - Middle Item (Item 3)',
      fileName: 'carousel_middle_item3',
      builder: () => buildThemeMatrix(
        name: 'Middle\n(Item 3/5)\nBoth Enabled',
        width: 300.0,
        height: 400.0,
        child: AppCarousel(
          itemCount: 5,
          itemHeight: 280,
          showNavigationButtons: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.green.shade200,
                    Colors.green.shade600,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.green.shade900,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    'Item ${index + 1}',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    variant: AppTextVariant.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AppText(
                      'Scroll: Both Directions',
                      color: Colors.white,
                      variant: AppTextVariant.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    goldenTest(
      'AppCarousel - Last Item (Item 5)',
      fileName: 'carousel_last_item5',
      builder: () => buildThemeMatrix(
        name: 'Last\n(Item 5/5)\nNext: Disabled',
        width: 300.0,
        height: 400.0,
        child: AppCarousel(
          itemCount: 5,
          itemHeight: 280,
          showNavigationButtons: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.orange.shade300,
                    Colors.red.shade600,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.red.shade900,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    'Item ${index + 1}',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    variant: AppTextVariant.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AppText(
                      'Reached End',
                      color: Colors.white,
                      variant: AppTextVariant.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );

    goldenTest(
      'AppCarousel - Loop Mode Enabled',
      fileName: 'carousel_loop_mode',
      builder: () => buildThemeMatrix(
        name: 'Loop Mode\nCycles Back',
        width: 300.0,
        height: 400.0,
        child: AppCarousel(
          itemCount: 5,
          itemHeight: 280,
          scrollBehavior: CarouselScrollBehavior.loop,
          showNavigationButtons: true,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.purple.shade300,
                    Colors.indigo.shade600,
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: Colors.indigo.shade900,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    'Item ${index + 1}',
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    variant: AppTextVariant.headlineSmall,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.black26,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: AppText(
                      'Infinite Loop',
                      color: Colors.white,
                      variant: AppTextVariant.bodySmall,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  });
}
