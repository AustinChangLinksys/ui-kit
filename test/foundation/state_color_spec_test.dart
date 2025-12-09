import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/state_color_spec.dart';

void main() {
  group('StateColorSpec', () {
    final spec = StateColorSpec(
      active: Colors.blue,
      inactive: Colors.grey,
      hover: Colors.lightBlue,
      pressed: Colors.indigo,
      disabled: Colors.grey.withValues(alpha: 0.5),
      error: Colors.red,
    );

    group('resolve', () {
      test('returns active color when isActive is true', () {
        final color = spec.resolve(isActive: true);
        expect(color, Colors.blue);
      });

      test('returns inactive color when isActive is false', () {
        final color = spec.resolve(isActive: false);
        expect(color, Colors.grey);
      });

      test('returns disabled color when isDisabled is true', () {
        final color = spec.resolve(isActive: true, isDisabled: true);
        expect(color, Colors.grey.withValues(alpha: 0.5));
      });

      test('returns error color when hasError is true', () {
        final color = spec.resolve(isActive: false, hasError: true);
        expect(color, Colors.red);
      });

      test('error takes priority over disabled', () {
        final color = spec.resolve(
          isActive: true,
          isDisabled: true,
          hasError: true,
        );
        expect(color, Colors.red);
      });

      test('disabled takes priority over active/inactive', () {
        final color = spec.resolve(isActive: true, isDisabled: true);
        expect(color, Colors.grey.withValues(alpha: 0.5));
      });

      test('falls back to inactive when disabled is null', () {
        const specNoDisabled = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
        );
        final color = specNoDisabled.resolve(isActive: false, isDisabled: true);
        expect(color, Colors.grey);
      });

      test('ignores error when error color is null', () {
        const specNoError = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
        );
        final color = specNoError.resolve(isActive: true, hasError: true);
        expect(color, Colors.blue);
      });

      test('returns hover color when isHovered is true', () {
        final color = spec.resolve(isActive: false, isHovered: true);
        expect(color, Colors.lightBlue);
      });

      test('returns pressed color when isPressed is true', () {
        final color = spec.resolve(isActive: false, isPressed: true);
        expect(color, Colors.indigo);
      });

      test('pressed takes priority over hover', () {
        final color = spec.resolve(
          isActive: false,
          isHovered: true,
          isPressed: true,
        );
        expect(color, Colors.indigo);
      });

      test('disabled takes priority over pressed and hover', () {
        final color = spec.resolve(
          isActive: true,
          isHovered: true,
          isPressed: true,
          isDisabled: true,
        );
        expect(color, Colors.grey.withValues(alpha: 0.5));
      });

      test('falls back to active/inactive when hover is null', () {
        const specNoHover = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
        );
        final color = specNoHover.resolve(isActive: true, isHovered: true);
        expect(color, Colors.blue);
      });

      test('falls back to active/inactive when pressed is null', () {
        const specNoPressed = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
        );
        final color = specNoPressed.resolve(isActive: false, isPressed: true);
        expect(color, Colors.grey);
      });
    });

    group('withOverride', () {
      test('overrides active color only', () {
        final modified = spec.withOverride(active: Colors.green);

        expect(modified.active, Colors.green);
        expect(modified.inactive, spec.inactive);
        expect(modified.disabled, spec.disabled);
        expect(modified.error, spec.error);
      });

      test('overrides all colors', () {
        final modified = spec.withOverride(
          active: Colors.green,
          inactive: Colors.black,
          hover: Colors.teal,
          pressed: Colors.cyan,
          disabled: Colors.brown,
          error: Colors.orange,
        );

        expect(modified.active, Colors.green);
        expect(modified.inactive, Colors.black);
        expect(modified.hover, Colors.teal);
        expect(modified.pressed, Colors.cyan);
        expect(modified.disabled, Colors.brown);
        expect(modified.error, Colors.orange);
      });

      test('overrides hover color only', () {
        final modified = spec.withOverride(hover: Colors.teal);

        expect(modified.hover, Colors.teal);
        expect(modified.active, spec.active);
        expect(modified.inactive, spec.inactive);
        expect(modified.pressed, spec.pressed);
      });

      test('overrides pressed color only', () {
        final modified = spec.withOverride(pressed: Colors.cyan);

        expect(modified.pressed, Colors.cyan);
        expect(modified.active, spec.active);
        expect(modified.inactive, spec.inactive);
        expect(modified.hover, spec.hover);
      });

      test('returns copy when no overrides specified', () {
        final copy = spec.withOverride();

        expect(copy.active, spec.active);
        expect(copy.inactive, spec.inactive);
        expect(copy.hover, spec.hover);
        expect(copy.pressed, spec.pressed);
        expect(copy.disabled, spec.disabled);
        expect(copy.error, spec.error);
      });
    });

    group('equality', () {
      test('same values are equal', () {
        const a = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
        );
        const b = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
        );

        expect(a, equals(b));
      });

      test('same values with hover/pressed are equal', () {
        const a = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
          hover: Colors.lightBlue,
          pressed: Colors.indigo,
        );
        const b = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
          hover: Colors.lightBlue,
          pressed: Colors.indigo,
        );

        expect(a, equals(b));
      });

      test('different hover values are not equal', () {
        const a = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
          hover: Colors.lightBlue,
        );
        const b = StateColorSpec(
          active: Colors.blue,
          inactive: Colors.grey,
          hover: Colors.teal,
        );

        expect(a, isNot(equals(b)));
      });
    });
  });
}
