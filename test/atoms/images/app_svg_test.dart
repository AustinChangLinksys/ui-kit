import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppSvg', () {
    group('AppSvg.asset', () {
      testWidgets('renders correctly in light mode', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: AppSvg.asset(
                svg: Assets.images.imgWiredMoveNodes,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('renders correctly in dark mode with invert strategy',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: AppSvg.asset(
                svg: Assets.images.imgWiredMoveNodes,
                darkStrategy: DarkModeStrategy.invert,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
        expect(find.byType(ColorFiltered), findsOneWidget);
      });

      testWidgets(
          'does not apply filter in dark mode when darkVariant provided',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: AppSvg.asset(
                svg: Assets.images.imgWiredMoveNodes,
                darkVariant: Assets.images.imgWiredMoveNodes,
                darkStrategy: DarkModeStrategy.invert,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
        // No ColorFiltered when darkVariant is provided
        expect(find.byType(ColorFiltered), findsNothing);
      });

      testWidgets('uses custom darkColorFilter when provided', (tester) async {
        const customFilter = ColorFilter.mode(Colors.blue, BlendMode.overlay);

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: AppSvg.asset(
                svg: Assets.images.imgWiredMoveNodes,
                darkColorFilter: customFilter,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(ColorFiltered), findsOneWidget);
      });
    });

    group('AppSvg.string', () {
      testWidgets('renders from SVG string', (tester) async {
        const svgString = '''
          <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="12" r="10" fill="blue"/>
          </svg>
        ''';

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppSvg.string(
                svgString: svgString,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
      });

      testWidgets('switches to dark SVG string in dark mode', (tester) async {
        const lightSvg = '''
          <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="12" r="10" fill="white"/>
          </svg>
        ''';
        const darkSvg = '''
          <svg viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg">
            <circle cx="12" cy="12" r="10" fill="black"/>
          </svg>
        ''';

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: AppSvg.string(
                svgString: lightSvg,
                darkSvgString: darkSvg,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(SvgPicture), findsOneWidget);
        // No filter applied when using variant switching
        expect(find.byType(ColorFiltered), findsNothing);
      });
    });

    group('DarkModeStrategy application', () {
      for (final strategy in DarkModeStrategy.values) {
        testWidgets('applies ${strategy.name} strategy in dark mode',
            (tester) async {
          await tester.pumpWidget(
            MaterialApp(
              theme: ThemeData.dark(),
              home: Scaffold(
                body: AppSvg.asset(
                  svg: Assets.images.imgWiredMoveNodes,
                  darkStrategy: strategy,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          );

          expect(find.byType(SvgPicture), findsOneWidget);

          if (strategy == DarkModeStrategy.none) {
            expect(find.byType(ColorFiltered), findsNothing);
          } else {
            expect(find.byType(ColorFiltered), findsOneWidget);
          }
        });
      }
    });
  });
}
