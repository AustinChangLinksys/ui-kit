import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppDialog Golden Tests', () {
    // Test 1: Simple dialog with title and content
    goldenTest(
      'AppDialog - Simple',
      fileName: 'app_dialog_simple',
      builder: () => buildThemeMatrix(
        name: 'Simple',
        width: 350,
        height: 150,
        child: const AppDialog(
          titleText: 'Dialog Title',
          content: Text('This is the dialog content message.'),
        ),
      ),
    );

    // Test 2: Dialog with actions
    goldenTest(
      'AppDialog - With Actions',
      fileName: 'app_dialog_with_actions',
      builder: () => buildThemeMatrix(
        name: 'With Actions',
        width: 380,
        height: 220,
        child: AppDialog(
          titleText: 'Confirm Action',
          content: const Text('Are you sure you want to proceed?'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Confirm'),
            ),
          ],
        ),
      ),
    );

    // Test 3: Dialog with icon
    goldenTest(
      'AppDialog - With Icon',
      fileName: 'app_dialog_with_icon',
      builder: () => buildThemeMatrix(
        name: 'With Icon',
        width: 350,
        height: 280,
        child: AppDialog(
          icon: Icons.warning_amber_rounded,
          titleText: 'Warning',
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );

    // Test 4: Dialog with custom title widget
    goldenTest(
      'AppDialog - Custom Title',
      fileName: 'app_dialog_custom_title',
      builder: () => buildThemeMatrix(
        name: 'Custom Title',
        width: 380,
        height: 220,
        child: AppDialog(
          title: const Row(
            children: [
              Icon(Icons.info, size: 24),
              SizedBox(width: 8),
              Text(
                'Information',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          content: const Text('Here is some important information.'),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('OK'),
            ),
          ],
        ),
      ),
    );

    // Test 5: Content-only dialog (no title)
    goldenTest(
      'AppDialog - Content Only',
      fileName: 'app_dialog_content_only',
      builder: () => buildThemeMatrix(
        name: 'Content Only',
        width: 350,
        height: 120,
        child: const AppDialog(
          content: Text(
            'This dialog has no title, just content.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );

    // Test 6: Long content dialog
    goldenTest(
      'AppDialog - Long Content',
      fileName: 'app_dialog_long_content',
      builder: () => buildThemeMatrix(
        name: 'Long Content',
        width: 350,
        height: 300,
        child: AppDialog(
          titleText: 'Terms and Conditions',
          scrollable: true,
          content: const SizedBox(
            height: 100,
            child: SingleChildScrollView(
              child: Text(
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris.',
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {},
              child: const Text('Decline'),
            ),
            TextButton(
              onPressed: () {},
              child: const Text('Accept'),
            ),
          ],
        ),
      ),
    );
  });
}
