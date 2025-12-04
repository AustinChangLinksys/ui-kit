// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/registry/registry_helpers.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  group('Registry Integration', () {
    late ComponentRegistry registry;

    setUp(() {
      registry = ComponentRegistry();
    });

    test('Performance: Register and lookup 100 components in <10ms', () {
      final stopwatch = Stopwatch()..start();
      
      for (int i = 0; i < 100; i++) {
        registry.register('Component$i', (ctx, props, {onAction}) => Container());
      }

      final registerTime = stopwatch.elapsedMilliseconds;
      
      stopwatch.reset();
      for (int i = 0; i < 100; i++) {
        registry.lookup('Component$i');
      }
      final lookupTime = stopwatch.elapsedMilliseconds;

      print('Register 100: ${registerTime}ms, Lookup 100: ${lookupTime}ms');
      expect(lookupTime, lessThan(10)); 
    });

    testWidgets('App Initialization: Registers demo components and renders', (tester) async {
      // Simulate App Init
      registerWifiSettingsCard(registry);
      registerInfoCard(registry);

      // Verify
      expect(registry.lookup('WifiSettingsCard'), isNotNull);
      expect(registry.lookup('InfoCard'), isNotNull);

      // Render
      await tester.pumpWidget(MaterialApp(
        theme: AppTheme.create(brightness: Brightness.light),
        home: Scaffold(
          body: Builder(builder: (context) {
             final builder = registry.lookup('WifiSettingsCard')!;
             return builder(context, {'ssid': 'Integration', 'security': 'WPA2'});
          }),
        ),
      ));

      expect(find.text('Integration'), findsOneWidget);
    });
  });
}
