import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('DarkModeStrategy', () {
    test('getColorFilterForStrategy returns null for none', () {
      final result = getColorFilterForStrategy(DarkModeStrategy.none);
      expect(result, isNull);
    });

    test('getColorFilterForStrategy returns ColorFilter for dimming', () {
      final result = getColorFilterForStrategy(DarkModeStrategy.dimming);
      expect(result, isNotNull);
      expect(result, isA<ColorFilter>());
    });

    test('getColorFilterForStrategy returns ColorFilter for invert', () {
      final result = getColorFilterForStrategy(DarkModeStrategy.invert);
      expect(result, isNotNull);
      expect(result, isA<ColorFilter>());
    });

    test('getColorFilterForStrategy returns ColorFilter for desaturate', () {
      final result = getColorFilterForStrategy(DarkModeStrategy.desaturate);
      expect(result, isNotNull);
      expect(result, isA<ColorFilter>());
    });

    test('getColorFilterForStrategy returns ColorFilter for lowContrast', () {
      final result = getColorFilterForStrategy(DarkModeStrategy.lowContrast);
      expect(result, isNotNull);
      expect(result, isA<ColorFilter>());
    });

    test('all strategies in enum have corresponding filter implementation', () {
      for (final strategy in DarkModeStrategy.values) {
        // Should not throw
        final result = getColorFilterForStrategy(strategy);
        if (strategy == DarkModeStrategy.none) {
          expect(result, isNull, reason: '${strategy.name} should return null');
        } else {
          expect(result, isNotNull,
              reason: '${strategy.name} should return a ColorFilter');
        }
      }
    });
  });

  group('DarkModeStrategy enum values', () {
    test('contains expected strategies', () {
      expect(
          DarkModeStrategy.values,
          containsAll([
            DarkModeStrategy.none,
            DarkModeStrategy.dimming,
            DarkModeStrategy.invert,
            DarkModeStrategy.desaturate,
            DarkModeStrategy.lowContrast,
          ]));
    });

    test('has exactly 5 strategies', () {
      expect(DarkModeStrategy.values.length, equals(5));
    });
  });
}
