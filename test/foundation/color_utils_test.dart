import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('ColorUtils', () {
    group('computeContrastColor', () {
      test('returns black for light backgrounds', () {
        // White background -> black text
        expect(
          ColorUtils.computeContrastColor(Colors.white),
          Colors.black,
        );

        // Light yellow background -> black text
        expect(
          ColorUtils.computeContrastColor(Colors.yellow),
          Colors.black,
        );

        // Light cyan background -> black text
        expect(
          ColorUtils.computeContrastColor(Colors.cyan.shade100),
          Colors.black,
        );
      });

      test('returns white for dark backgrounds', () {
        // Black background -> white text
        expect(
          ColorUtils.computeContrastColor(Colors.black),
          Colors.white,
        );

        // Dark blue background -> white text
        expect(
          ColorUtils.computeContrastColor(Colors.blue.shade900),
          Colors.white,
        );

        // Dark purple background -> white text
        expect(
          ColorUtils.computeContrastColor(Colors.purple.shade800),
          Colors.white,
        );
      });

      test('respects custom foreground colors', () {
        const customLight = Color(0xFFF5F5F5);
        const customDark = Color(0xFF212121);

        expect(
          ColorUtils.computeContrastColor(
            Colors.black,
            lightForeground: customLight,
            darkForeground: customDark,
          ),
          customLight,
        );

        expect(
          ColorUtils.computeContrastColor(
            Colors.white,
            lightForeground: customLight,
            darkForeground: customDark,
          ),
          customDark,
        );
      });

      test('respects custom threshold', () {
        // Mid-gray with default threshold (0.5)
        final midGray = Colors.grey.shade500;

        // Lower threshold -> favors light foreground
        expect(
          ColorUtils.computeContrastColor(midGray, threshold: 0.3),
          Colors.black,
        );

        // Higher threshold -> favors dark foreground
        expect(
          ColorUtils.computeContrastColor(midGray, threshold: 0.7),
          Colors.white,
        );
      });
    });

    group('computeContrastColorWithOpacity', () {
      test('returns contrast color with opacity applied', () {
        final result = ColorUtils.computeContrastColorWithOpacity(
          Colors.black,
          opacity: 0.5,
        );

        expect(result.a, closeTo(0.5, 0.01));
        expect(result.r, Colors.white.r);
        expect(result.g, Colors.white.g);
        expect(result.b, Colors.white.b);
      });

      test('respects custom foreground colors with opacity', () {
        final result = ColorUtils.computeContrastColorWithOpacity(
          Colors.white,
          opacity: 0.7,
          darkForeground: Colors.red,
        );

        expect(result.a, closeTo(0.7, 0.01));
        expect(result.r, Colors.red.r);
      });
    });

    group('isLightColor', () {
      test('returns true for light colors', () {
        expect(ColorUtils.isLightColor(Colors.white), isTrue);
        expect(ColorUtils.isLightColor(Colors.yellow), isTrue);
        expect(ColorUtils.isLightColor(Colors.lime.shade200), isTrue);
      });

      test('returns false for dark colors', () {
        expect(ColorUtils.isLightColor(Colors.black), isFalse);
        expect(ColorUtils.isLightColor(Colors.blue.shade900), isFalse);
        expect(ColorUtils.isLightColor(Colors.grey.shade800), isFalse);
      });

      test('respects custom threshold', () {
        final midGray = Colors.grey.shade500;
        expect(ColorUtils.isLightColor(midGray, threshold: 0.3), isTrue);
        expect(ColorUtils.isLightColor(midGray, threshold: 0.7), isFalse);
      });
    });

    group('isDarkColor', () {
      test('returns true for dark colors', () {
        expect(ColorUtils.isDarkColor(Colors.black), isTrue);
        expect(ColorUtils.isDarkColor(Colors.blue.shade900), isTrue);
      });

      test('returns false for light colors', () {
        expect(ColorUtils.isDarkColor(Colors.white), isFalse);
        expect(ColorUtils.isDarkColor(Colors.yellow), isFalse);
      });

      test('is inverse of isLightColor', () {
        final testColors = [
          Colors.white,
          Colors.black,
          Colors.red,
          Colors.green,
          Colors.blue,
          Colors.grey,
        ];

        for (final color in testColors) {
          expect(
            ColorUtils.isDarkColor(color),
            !ColorUtils.isLightColor(color),
          );
        }
      });
    });

    group('blend', () {
      test('blends two colors with ratio 0.0 returns first color', () {
        final result = ColorUtils.blend(Colors.red, Colors.blue, 0.0);
        // Compare color values, not MaterialColor type
        expect(result.r, Colors.red.r);
        expect(result.g, Colors.red.g);
        expect(result.b, Colors.red.b);
      });

      test('blends two colors with ratio 1.0 returns second color', () {
        final result = ColorUtils.blend(Colors.red, Colors.blue, 1.0);
        expect(result.r, Colors.blue.r);
        expect(result.g, Colors.blue.g);
        expect(result.b, Colors.blue.b);
      });

      test('blends two colors with ratio 0.5 returns midpoint', () {
        final result = ColorUtils.blend(Colors.black, Colors.white, 0.5);
        // Mid-gray
        expect(result.r, closeTo(0.5, 0.01));
        expect(result.g, closeTo(0.5, 0.01));
        expect(result.b, closeTo(0.5, 0.01));
      });

      test('clamps ratio to valid range', () {
        final resultNegative = ColorUtils.blend(Colors.red, Colors.blue, -0.5);
        expect(resultNegative.r, Colors.red.r);
        expect(resultNegative.g, Colors.red.g);
        expect(resultNegative.b, Colors.red.b);

        final resultOver = ColorUtils.blend(Colors.red, Colors.blue, 1.5);
        expect(resultOver.r, Colors.blue.r);
        expect(resultOver.g, Colors.blue.g);
        expect(resultOver.b, Colors.blue.b);
      });
    });

    group('semantic color integration', () {
      test('computes appropriate contrast for semantic success (green)', () {
        const successColor = Colors.green;
        final onSuccess = ColorUtils.computeContrastColor(successColor);
        // Green is typically mid-to-dark, should get white
        expect(ColorUtils.isDarkColor(successColor), isTrue);
        expect(onSuccess, Colors.white);
      });

      test('computes appropriate contrast for semantic warning (orange)', () {
        const warningColor = Colors.orange;
        final onWarning = ColorUtils.computeContrastColor(warningColor);
        // Orange luminance ~ 0.46, slightly dark, gets white text
        // This tests the actual behavior rather than assumptions
        final luminance = warningColor.computeLuminance();
        if (luminance > 0.5) {
          expect(onWarning, Colors.black);
        } else {
          expect(onWarning, Colors.white);
        }
      });

      test('computes appropriate contrast for semantic danger (red)', () {
        const dangerColor = Colors.red;
        final onDanger = ColorUtils.computeContrastColor(dangerColor);
        // Pure red is dark, should get white
        expect(onDanger, Colors.white);
      });
    });
  });
}
