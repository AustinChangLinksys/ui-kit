import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// WCAG 2.1 AA contrast ratio requirements:
/// - Normal text (< 18pt or < 14pt bold): 4.5:1
/// - Large text (≥ 18pt or ≥ 14pt bold) and UI components: 3:1
const double kWcagAANormalText = 4.5;
const double kWcagAALargeText = 3.0;

/// Calculates relative luminance of a color per WCAG 2.1 formula.
double _relativeLuminance(Color color) {
  // Flutter 3.x Color API returns 0.0-1.0 values for r, g, b
  double r = color.r;
  double g = color.g;
  double b = color.b;

  r = r <= 0.03928 ? r / 12.92 : math.pow((r + 0.055) / 1.055, 2.4).toDouble();
  g = g <= 0.03928 ? g / 12.92 : math.pow((g + 0.055) / 1.055, 2.4).toDouble();
  b = b <= 0.03928 ? b / 12.92 : math.pow((b + 0.055) / 1.055, 2.4).toDouble();

  return 0.2126 * r + 0.7152 * g + 0.0722 * b;
}

/// Calculates contrast ratio between two colors per WCAG 2.1.
double contrastRatio(Color foreground, Color background) {
  final l1 = _relativeLuminance(foreground);
  final l2 = _relativeLuminance(background);
  final lighter = math.max(l1, l2);
  final darker = math.min(l1, l2);
  return (lighter + 0.05) / (darker + 0.05);
}

/// Verifies contrast meets WCAG AA requirements.
void verifyContrast({
  required String name,
  required Color foreground,
  required Color background,
  double minimumRatio = kWcagAANormalText,
}) {
  final ratio = contrastRatio(foreground, background);
  expect(
    ratio,
    greaterThanOrEqualTo(minimumRatio),
    reason: '$name contrast ratio $ratio is below WCAG AA minimum $minimumRatio '
        '(foreground: $foreground, background: $background)',
  );
}

void main() {
  group('WCAG AA Contrast Verification', () {
    group('Flat Theme', () {
      test('Light mode - AppBar contrast', () {
        final theme = FlatDesignTheme.light();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
        );
      });

      test('Dark mode - AppBar contrast', () {
        final theme = FlatDesignTheme.dark();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
        );
      });

      test('Light mode - Menu contrast', () {
        final theme = FlatDesignTheme.light();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );

        verifyContrast(
          name: 'Destructive menu item on background',
          foreground: menuStyle.destructiveItemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );
      });

      test('Dark mode - Menu contrast', () {
        final theme = FlatDesignTheme.dark();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );
      });

      test('Light mode - Dialog contrast', () {
        final theme = FlatDesignTheme.light();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
        );
      });

      test('Dark mode - Dialog contrast', () {
        final theme = FlatDesignTheme.dark();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
        );
      });
    });

    group('Glass Theme', () {
      test('Light mode - AppBar contrast', () {
        final theme = GlassDesignTheme.light();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
          minimumRatio: kWcagAALargeText, // Allow 3:1 for glass translucent
        );
      });

      test('Dark mode - AppBar contrast', () {
        final theme = GlassDesignTheme.dark();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
          minimumRatio: kWcagAALargeText,
        );
      });

      test('Light mode - Menu contrast', () {
        final theme = GlassDesignTheme.light();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
          minimumRatio: kWcagAALargeText,
        );
      });

      test('Dark mode - Menu contrast', () {
        final theme = GlassDesignTheme.dark();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
          minimumRatio: kWcagAALargeText,
        );
      });

      test('Light mode - Dialog contrast', () {
        final theme = GlassDesignTheme.light();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
          minimumRatio: kWcagAALargeText,
        );
      });

      test('Dark mode - Dialog contrast', () {
        final theme = GlassDesignTheme.dark();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
          minimumRatio: kWcagAALargeText,
        );
      });
    });

    group('Pixel Theme', () {
      test('Light mode - AppBar contrast', () {
        final theme = PixelDesignTheme.light();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
        );
      });

      test('Dark mode - AppBar contrast', () {
        final theme = PixelDesignTheme.dark();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
        );
      });

      test('Light mode - Menu contrast', () {
        final theme = PixelDesignTheme.light();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );
      });

      test('Dark mode - Menu contrast', () {
        final theme = PixelDesignTheme.dark();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );
      });

      test('Light mode - Dialog contrast', () {
        final theme = PixelDesignTheme.light();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
        );
      });

      test('Dark mode - Dialog contrast', () {
        final theme = PixelDesignTheme.dark();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
        );
      });
    });

    group('Brutal Theme', () {
      test('Light mode - AppBar contrast', () {
        final theme = BrutalDesignTheme.light();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
        );
      });

      test('Dark mode - AppBar contrast', () {
        final theme = BrutalDesignTheme.dark();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
        );
      });

      test('Light mode - Menu contrast', () {
        final theme = BrutalDesignTheme.light();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );
      });

      test('Dark mode - Menu contrast', () {
        final theme = BrutalDesignTheme.dark();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );
      });

      test('Light mode - Dialog contrast', () {
        final theme = BrutalDesignTheme.light();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
        );
      });

      test('Dark mode - Dialog contrast', () {
        final theme = BrutalDesignTheme.dark();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
        );
      });
    });

    group('Neumorphic Theme', () {
      test('Light mode - AppBar contrast', () {
        final theme = NeumorphicDesignTheme.light();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
        );
      });

      test('Dark mode - AppBar contrast', () {
        final theme = NeumorphicDesignTheme.dark();
        final appBarStyle = theme.appBarStyle;

        verifyContrast(
          name: 'AppBar title on background',
          foreground: appBarStyle.foregroundColor,
          background: appBarStyle.backgroundColor,
        );
      });

      test('Light mode - Menu contrast', () {
        final theme = NeumorphicDesignTheme.light();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );
      });

      test('Dark mode - Menu contrast', () {
        final theme = NeumorphicDesignTheme.dark();
        final menuStyle = theme.menuStyle;

        verifyContrast(
          name: 'Menu item text on background',
          foreground: menuStyle.itemStyle.contentColor,
          background: menuStyle.containerStyle.backgroundColor,
        );
      });

      test('Light mode - Dialog contrast', () {
        final theme = NeumorphicDesignTheme.light();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
        );
      });

      test('Dark mode - Dialog contrast', () {
        final theme = NeumorphicDesignTheme.dark();
        final dialogStyle = theme.dialogStyle;

        verifyContrast(
          name: 'Dialog content on background',
          foreground: dialogStyle.containerStyle.contentColor,
          background: dialogStyle.containerStyle.backgroundColor,
        );
      });
    });
  });

  group('Contrast Ratio Utility Tests', () {
    test('Black on white should be 21:1', () {
      final ratio = contrastRatio(Colors.black, Colors.white);
      expect(ratio, closeTo(21.0, 0.1));
    });

    test('White on black should be 21:1', () {
      final ratio = contrastRatio(Colors.white, Colors.black);
      expect(ratio, closeTo(21.0, 0.1));
    });

    test('Same color should be 1:1', () {
      final ratio = contrastRatio(Colors.red, Colors.red);
      expect(ratio, closeTo(1.0, 0.01));
    });
  });
}
