import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/layout/widgets/page_bottom_bar.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Golden tests for extracted PageBottomBar widget
void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('PageBottomBar Golden Tests', () {
    goldenTest(
      'PageBottomBar - Save/Cancel Actions',
      fileName: 'page_bottom_bar_save_cancel',
      builder: () => buildThemeMatrix(
        name: 'Save/Cancel',
        width: 400,
        height: 120,
        child: PageBottomBar(
          config: PageBottomBarConfig(
            positiveLabel: 'Save',
            negativeLabel: 'Cancel',
            onPositiveTap: () {},
            onNegativeTap: () {},
            isPositiveEnabled: true,
          ),
        ),
      ),
    );

    goldenTest(
      'PageBottomBar - Single Button (Positive Only)',
      fileName: 'page_bottom_bar_single',
      builder: () => buildThemeMatrix(
        name: 'Single Button',
        width: 400,
        height: 120,
        child: PageBottomBar(
          config: PageBottomBarConfig(
            positiveLabel: 'Continue',
            onPositiveTap: () {},
            isPositiveEnabled: true,
          ),
        ),
      ),
    );

    goldenTest(
      'PageBottomBar - Disabled Positive',
      fileName: 'page_bottom_bar_disabled_positive',
      builder: () => buildThemeMatrix(
        name: 'Disabled Positive',
        width: 400,
        height: 120,
        child: PageBottomBar(
          config: PageBottomBarConfig(
            positiveLabel: 'Submit',
            negativeLabel: 'Back',
            onPositiveTap: () {},
            onNegativeTap: () {},
            isPositiveEnabled: false,
          ),
        ),
      ),
    );

    goldenTest(
      'PageBottomBar - Disabled Negative',
      fileName: 'page_bottom_bar_disabled_negative',
      builder: () => buildThemeMatrix(
        name: 'Disabled Negative',
        width: 400,
        height: 120,
        child: PageBottomBar(
          config: PageBottomBarConfig(
            positiveLabel: 'Confirm',
            negativeLabel: 'Cancel',
            onPositiveTap: () {},
            onNegativeTap: () {},
            isPositiveEnabled: true,
            isNegativeEnabled: false,
          ),
        ),
      ),
    );

    goldenTest(
      'PageBottomBar - Destructive Action',
      fileName: 'page_bottom_bar_destructive',
      builder: () => buildThemeMatrix(
        name: 'Destructive',
        width: 400,
        height: 120,
        child: PageBottomBar(
          config: PageBottomBarConfig(
            positiveLabel: 'Delete',
            negativeLabel: 'Cancel',
            onPositiveTap: () {},
            onNegativeTap: () {},
            isPositiveEnabled: true,
            isDestructive: true,
          ),
        ),
      ),
    );
  });
}
