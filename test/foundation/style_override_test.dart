import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/src/foundation/style_override.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/animation_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/overlay_spec.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/shared/state_color_spec.dart';

void main() {
  group('StyleOverride', () {
    group('maybeOf', () {
      testWidgets('returns null when no StyleOverride in tree', (tester) async {
        StyleOverride? result;

        await tester.pumpWidget(
          Builder(
            builder: (context) {
              result = StyleOverride.maybeOf(context);
              return const SizedBox();
            },
          ),
        );

        expect(result, isNull);
      });

      testWidgets('returns StyleOverride when present', (tester) async {
        StyleOverride? result;

        await tester.pumpWidget(
          StyleOverride(
            animationSpec: AnimationSpec.fast,
            child: Builder(
              builder: (context) {
                result = StyleOverride.maybeOf(context);
                return const SizedBox();
              },
            ),
          ),
        );

        expect(result, isNotNull);
        expect(result!.animationSpec, AnimationSpec.fast);
      });
    });

    group('resolveSpec', () {
      testWidgets('returns AnimationSpec when available', (tester) async {
        AnimationSpec? result;

        await tester.pumpWidget(
          StyleOverride(
            animationSpec: AnimationSpec.slow,
            child: Builder(
              builder: (context) {
                result = StyleOverride.resolveSpec<AnimationSpec>(context);
                return const SizedBox();
              },
            ),
          ),
        );

        expect(result, AnimationSpec.slow);
      });

      testWidgets('returns null when spec type not provided', (tester) async {
        StateColorSpec? result;

        await tester.pumpWidget(
          StyleOverride(
            animationSpec: AnimationSpec.fast, // Only animation, no state colors
            child: Builder(
              builder: (context) {
                result = StyleOverride.resolveSpec<StateColorSpec>(context);
                return const SizedBox();
              },
            ),
          ),
        );

        expect(result, isNull);
      });

      testWidgets('returns OverlaySpec when available', (tester) async {
        OverlaySpec? result;

        await tester.pumpWidget(
          StyleOverride(
            overlaySpec: OverlaySpec.glass,
            child: Builder(
              builder: (context) {
                result = StyleOverride.resolveSpec<OverlaySpec>(context);
                return const SizedBox();
              },
            ),
          ),
        );

        expect(result, OverlaySpec.glass);
      });
    });

    group('nested overrides', () {
      testWidgets('inner override takes precedence', (tester) async {
        AnimationSpec? result;

        await tester.pumpWidget(
          StyleOverride(
            animationSpec: AnimationSpec.slow,
            child: StyleOverride(
              animationSpec: AnimationSpec.fast,
              child: Builder(
                builder: (context) {
                  result = StyleOverride.resolveSpec<AnimationSpec>(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(result, AnimationSpec.fast);
      });

      testWidgets('partial inner override does not affect other specs', (tester) async {
        AnimationSpec? animResult;
        OverlaySpec? overlayResult;

        await tester.pumpWidget(
          StyleOverride(
            animationSpec: AnimationSpec.slow,
            overlaySpec: OverlaySpec.glass,
            child: StyleOverride(
              animationSpec: AnimationSpec.fast, // Only override animation
              child: Builder(
                builder: (context) {
                  animResult = StyleOverride.resolveSpec<AnimationSpec>(context);
                  overlayResult = StyleOverride.resolveSpec<OverlaySpec>(context);
                  return const SizedBox();
                },
              ),
            ),
          ),
        );

        expect(animResult, AnimationSpec.fast);
        // Inner StyleOverride doesn't have overlaySpec, so it returns null
        // (the inner StyleOverride shadows the outer one)
        expect(overlayResult, isNull);
      });
    });

    group('updateShouldNotify', () {
      test('returns true when animationSpec changes', () {
        const oldWidget = StyleOverride(
          animationSpec: AnimationSpec.fast,
          child: SizedBox(),
        );
        const newWidget = StyleOverride(
          animationSpec: AnimationSpec.slow,
          child: SizedBox(),
        );

        expect(newWidget.updateShouldNotify(oldWidget), isTrue);
      });

      test('returns false when nothing changes', () {
        const oldWidget = StyleOverride(
          animationSpec: AnimationSpec.fast,
          child: SizedBox(),
        );
        const newWidget = StyleOverride(
          animationSpec: AnimationSpec.fast,
          child: SizedBox(),
        );

        expect(newWidget.updateShouldNotify(oldWidget), isFalse);
      });
    });
  });
}
