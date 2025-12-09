import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:alchemist/alchemist.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

void main() {
  // Constitution B.1: Load real fonts
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppStyledText Golden Tests', () {
    // Constitution B.2: Safe Mode Protocol
    goldenTest(
      'AppStyledText - XML Tags',
      fileName: 'app_styled_text_xml_tags',
      builder: () => buildThemeMatrix(
        name: 'XML Tags',
        width: 400.0, // B.2.1: Explicit constraints
        height: 120.0,
        child: const AppStyledText(
          text: 'This is <b>bold</b>, <i>italic</i>, <u>underlined</u>, '
              '<color>colored</color>, <large>large</large>, and <small>small</small> text.',
        ),
      ),
    );

    goldenTest(
      'AppStyledText - Parametrized Tags',
      fileName: 'app_styled_text_parametrized',
      builder: () => buildThemeMatrix(
        name: 'Parametrized',
        width: 400.0,
        height: 100.0,
        child: AppStyledText(
          text: 'Agree to {{terms:Terms of Service}} and {{privacy:Privacy Policy}}.',
          onTapHandlers: {
            'terms': () {},
            'privacy': () {},
          },
        ),
      ),
    );

    goldenTest(
      'AppStyledText - Mixed Format',
      fileName: 'app_styled_text_mixed',
      builder: () => buildThemeMatrix(
        name: 'Mixed Format',
        width: 400.0,
        height: 120.0,
        child: AppStyledText(
          text: 'Welcome <b>{{username:John Doe}}</b>! '
              'Please read our <i>updated</i> {{terms:Terms}} and {{privacy:Privacy Policy}}.',
          onTapHandlers: {
            'username': () {},
            'terms': () {},
            'privacy': () {},
          },
        ),
      ),
    );

    goldenTest(
      'AppStyledText - Theme Adaptation',
      fileName: 'app_styled_text_theme_adaptive',
      builder: () => buildThemeMatrix(
        name: 'Theme Adaptive Links',
        width: 350.0,
        height: 100.0,
        child: AppStyledText(
          text: 'Click {{link:this link}} to continue.',
          onTapHandlers: {
            'link': () {},
          },
        ),
      ),
    );

    goldenTest(
      'AppStyledText - Long Text with Wrapping',
      fileName: 'app_styled_text_wrapping',
      builder: () => buildThemeMatrix(
        name: 'Text Wrapping',
        width: 250.0,
        height: 150.0,
        child: AppStyledText(
          text: 'This is a <b>very long</b> piece of text that should '
              'wrap properly across <i>multiple lines</i> with various '
              '<color>styled elements</color> and {{link:clickable links}} '
              'distributed throughout the content.',
          onTapHandlers: {
            'link': () {},
          },
        ),
      ),
    );

    goldenTest(
      'AppStyledText - Custom Text Alignment',
      fileName: 'app_styled_text_alignment',
      builder: () => buildThemeMatrix(
        name: 'Text Alignment',
        width: 300.0,
        height: 200.0,
        child: const Column(
          children: [
            AppStyledText(
              text: '<b>Left aligned</b> with {{link:clickable}} text.',
              textAlign: TextAlign.start,
            ),
            SizedBox(height: 20),
            AppStyledText(
              text: '<i>Center aligned</i> styled text content.',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            AppStyledText(
              text: '<u>Right aligned</u> text with <color>colors</color>.',
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  });
}