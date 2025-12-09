import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/overlay_spec.dart';

void main() {
  group('OverlaySpec', () {
    group('presets', () {
      test('standard has no blur and standard animation', () {
        expect(OverlaySpec.standard.scrimColor, const Color(0x8A000000));
        expect(OverlaySpec.standard.blurStrength, 0.0);
        expect(OverlaySpec.standard.animation.duration, AnimationSpec.standard.duration);
      });

      test('glass has blur and slow animation', () {
        expect(OverlaySpec.glass.scrimColor, const Color(0x42000000));
        expect(OverlaySpec.glass.blurStrength, 10.0);
        expect(OverlaySpec.glass.animation.duration, AnimationSpec.slow.duration);
      });

      test('pixel has no blur and instant animation', () {
        expect(OverlaySpec.pixel.scrimColor, const Color(0xDE000000));
        expect(OverlaySpec.pixel.blurStrength, 0.0);
        expect(OverlaySpec.pixel.animation.duration, Duration.zero);
      });
    });

    group('withOverride', () {
      test('overrides scrimColor only', () {
        const original = OverlaySpec.standard;
        final modified = original.withOverride(scrimColor: Colors.red);

        expect(modified.scrimColor, Colors.red);
        expect(modified.blurStrength, original.blurStrength);
        expect(modified.animation, original.animation);
      });

      test('overrides blurStrength only', () {
        const original = OverlaySpec.standard;
        final modified = original.withOverride(blurStrength: 5.0);

        expect(modified.scrimColor, original.scrimColor);
        expect(modified.blurStrength, 5.0);
        expect(modified.animation, original.animation);
      });

      test('overrides animation only', () {
        const original = OverlaySpec.standard;
        final modified = original.withOverride(animation: AnimationSpec.fast);

        expect(modified.scrimColor, original.scrimColor);
        expect(modified.blurStrength, original.blurStrength);
        expect(modified.animation, AnimationSpec.fast);
      });

      test('overrides all values', () {
        const original = OverlaySpec.standard;
        final modified = original.withOverride(
          scrimColor: Colors.blue,
          blurStrength: 15.0,
          animation: AnimationSpec.slow,
        );

        expect(modified.scrimColor, Colors.blue);
        expect(modified.blurStrength, 15.0);
        expect(modified.animation, AnimationSpec.slow);
      });

      test('returns copy when no overrides specified', () {
        const original = OverlaySpec.standard;
        final copy = original.withOverride();

        expect(copy.scrimColor, original.scrimColor);
        expect(copy.blurStrength, original.blurStrength);
        expect(copy.animation, original.animation);
      });
    });

    group('nested animation override', () {
      test('can override nested animation properties', () {
        const original = OverlaySpec.standard;
        final newAnimation = original.animation.withOverride(
          duration: const Duration(milliseconds: 200),
        );
        final modified = original.withOverride(animation: newAnimation);

        expect(modified.animation.duration, const Duration(milliseconds: 200));
        expect(modified.animation.curve, original.animation.curve);
      });
    });
  });
}
