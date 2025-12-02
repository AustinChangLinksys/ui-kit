import 'package:alchemist/alchemist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/molecules/feedback/app_toast.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppToast Golden Tests', () {
    goldenTest(
      'AppToast - Success',
      fileName: 'app_toast_success',
      builder: () => buildThemeMatrix(
        name: 'Success',
        width: 300,
        height: 420,
        child: const AppToast(
          type: ToastType.success,
          title: 'Success',
          description: 'Operation completed.',
        ),
      ),
    );

    goldenTest(
      'AppToast - Error',
      fileName: 'app_toast_error',
      builder: () => buildThemeMatrix(
        name: 'Error',
        width: 300,
        height: 420,
        child: const AppToast(
          type: ToastType.error,
          title: 'Error',
          description: 'Something went wrong.',
        ),
      ),
    );

    goldenTest(
      'AppToast - Info',
      fileName: 'app_toast_info',
      builder: () => buildThemeMatrix(
        name: 'Info',
        width: 300,
        height: 420,
        child: const AppToast(
          type: ToastType.info,
          title: 'Information',
        ),
      ),
    );
  });
}