import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart';

void main() {
  group('AnimationSpec', () {
    group('presets', () {
      test('instant has 0ms duration', () {
        expect(AnimationSpec.instant.duration, Duration.zero);
        expect(AnimationSpec.instant.curve, Curves.linear);
      });

      test('fast has 150ms duration', () {
        expect(AnimationSpec.fast.duration, const Duration(milliseconds: 150));
        expect(AnimationSpec.fast.curve, Curves.easeOut);
      });

      test('standard has 300ms duration', () {
        expect(AnimationSpec.standard.duration, const Duration(milliseconds: 300));
        expect(AnimationSpec.standard.curve, Curves.easeInOut);
      });

      test('slow has 500ms duration', () {
        expect(AnimationSpec.slow.duration, const Duration(milliseconds: 500));
        expect(AnimationSpec.slow.curve, Curves.easeOutExpo);
      });
    });

    group('withOverride', () {
      test('overrides duration only', () {
        const original = AnimationSpec.standard;
        final modified = original.withOverride(
          duration: const Duration(milliseconds: 100),
        );

        expect(modified.duration, const Duration(milliseconds: 100));
        expect(modified.curve, original.curve);
      });

      test('overrides curve only', () {
        const original = AnimationSpec.standard;
        final modified = original.withOverride(curve: Curves.bounceOut);

        expect(modified.duration, original.duration);
        expect(modified.curve, Curves.bounceOut);
      });

      test('overrides both values', () {
        const original = AnimationSpec.standard;
        final modified = original.withOverride(
          duration: const Duration(milliseconds: 200),
          curve: Curves.elasticOut,
        );

        expect(modified.duration, const Duration(milliseconds: 200));
        expect(modified.curve, Curves.elasticOut);
      });

      test('returns copy when no overrides specified', () {
        const original = AnimationSpec.standard;
        final copy = original.withOverride();

        expect(copy.duration, original.duration);
        expect(copy.curve, original.curve);
      });
    });

    group('copyWith', () {
      test('copies with new duration', () {
        const spec = AnimationSpec.standard;
        final copied = spec.copyWith(duration: const Duration(milliseconds: 400));

        expect(copied.duration, const Duration(milliseconds: 400));
        expect(copied.curve, spec.curve);
      });
    });

    group('equality', () {
      test('same values are equal', () {
        const a = AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        const b = AnimationSpec(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );

        expect(a, equals(b));
      });
    });
  });
}
