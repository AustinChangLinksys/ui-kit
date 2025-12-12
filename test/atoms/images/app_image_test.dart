import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('AppImage', () {
    group('AppImage.asset', () {
      testWidgets('renders correctly in light mode', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.light(),
            home: Scaffold(
              body: AppImage.asset(
                image: Assets.images.devices.routerMx6200,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
      });

      testWidgets('renders correctly in dark mode with dimming strategy',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: AppImage.asset(
                image: Assets.images.devices.routerMx6200,
                darkStrategy: DarkModeStrategy.dimming,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
        expect(find.byType(ColorFiltered), findsOneWidget);
      });

      testWidgets(
          'does not apply filter in dark mode when darkVariant provided',
          (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: AppImage.asset(
                image: Assets.images.devices.routerMx6200,
                darkVariant: Assets.images.devices.routerMx6200,
                darkStrategy: DarkModeStrategy.dimming,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
        // No ColorFiltered when darkVariant is provided
        expect(find.byType(ColorFiltered), findsNothing);
      });

      testWidgets('uses custom darkColorFilter when provided', (tester) async {
        const customFilter = ColorFilter.mode(Colors.red, BlendMode.overlay);

        await tester.pumpWidget(
          MaterialApp(
            theme: ThemeData.dark(),
            home: Scaffold(
              body: AppImage.asset(
                image: Assets.images.devices.routerMx6200,
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

    group('AppImage.network', () {
      // Note: Network image tests are skipped because Flutter testing
      // environment returns 400 for all HTTP requests.
      // Real network functionality should be tested via integration tests.
      testWidgets('creates widget with network provider', (tester) async {
        // Just verify the widget builds - actual network loading
        // cannot be tested in unit test environment
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImage.network(
                url: 'https://example.com/test.png',
                placeholder: const CircularProgressIndicator(),
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        // In test environment, network images fail but widget should still exist
        await tester.pump();
        expect(find.byType(Image), findsOneWidget);
      }, skip: true); // Network tests require HTTP mocking
    });

    group('AppImage.memory', () {
      testWidgets('renders from bytes', (tester) async {
        // Create a minimal valid PNG (1x1 transparent pixel)
        final bytes = Uint8List.fromList([
          0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A, // PNG signature
          0x00, 0x00, 0x00, 0x0D, 0x49, 0x48, 0x44, 0x52, // IHDR chunk
          0x00, 0x00, 0x00, 0x01, 0x00, 0x00, 0x00, 0x01,
          0x08, 0x06, 0x00, 0x00, 0x00, 0x1F, 0x15, 0xC4, 0x89,
          0x00, 0x00, 0x00, 0x0A, 0x49, 0x44, 0x41, 0x54, // IDAT chunk
          0x78, 0x9C, 0x63, 0x00, 0x01, 0x00, 0x00, 0x05, 0x00, 0x01,
          0x0D, 0x0A, 0x2D, 0xB4,
          0x00, 0x00, 0x00, 0x00, 0x49, 0x45, 0x4E, 0x44, // IEND chunk
          0xAE, 0x42, 0x60, 0x82,
        ]);

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImage.memory(
                bytes: bytes,
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
      });
    });

    group('AppImage.provider', () {
      testWidgets('accepts any ImageProvider', (tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: AppImage.provider(
                imageProvider: const AssetImage(
                  'assets/images/devices/router-mx6200.png',
                  package: 'ui_kit_library',
                ),
                width: 100,
                height: 100,
              ),
            ),
          ),
        );

        expect(find.byType(Image), findsOneWidget);
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
                body: AppImage.asset(
                  image: Assets.images.devices.routerMx6200,
                  darkStrategy: strategy,
                  width: 100,
                  height: 100,
                ),
              ),
            ),
          );

          expect(find.byType(Image), findsOneWidget);

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
