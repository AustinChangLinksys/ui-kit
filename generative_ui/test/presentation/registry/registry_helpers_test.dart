import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/registry/registry_helpers.dart';
import 'package:generative_ui/src/presentation/widgets/demo_components.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() {
  late ComponentRegistry registry;

  setUp(() {
    registry = ComponentRegistry();
  });

  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(brightness: Brightness.light),
      home: Scaffold(body: child),
    );
  }

  group('Registry Helpers', () {
    testWidgets('registerWifiSettingsCard registers correctly and builds with props', (tester) async {
      registerWifiSettingsCard(registry);

      expect(registry.getRegisteredComponents(), contains('WifiSettingsCard'));

      final builder = registry.lookup('WifiSettingsCard');
      expect(builder, isNotNull);

      final props = {
        'ssid': 'Home Network',
        'security': 'WPA3',
        'isEnabled': true,
      };

      await tester.pumpWidget(wrapWithTheme(Builder(
        builder: (context) => builder!(context, props),
      )));

      expect(find.byType(WifiSettingsCard), findsOneWidget);
      expect(find.text('Home Network'), findsOneWidget); // SSID in text field
      expect(find.text('WPA3'), findsOneWidget); // Security in text field
    });

    testWidgets('registerInfoCard registers correctly and builds with props', (tester) async {
      registerInfoCard(registry);

      expect(registry.getRegisteredComponents(), contains('InfoCard'));

      final builder = registry.lookup('InfoCard');
      expect(builder, isNotNull);

      final props = {
        'title': 'Important Info',
        'message': 'This is a message.',
      };

      await tester.pumpWidget(wrapWithTheme(Builder(
        builder: (context) => builder!(context, props),
      )));

      expect(find.byType(InfoCard), findsOneWidget);
      expect(find.text('Important Info'), findsOneWidget);
      expect(find.text('This is a message.'), findsOneWidget);
    });

    testWidgets('WifiSettingsCard handles missing props with defaults', (tester) async {
      registerWifiSettingsCard(registry);
      final builder = registry.lookup('WifiSettingsCard')!;

      await tester.pumpWidget(wrapWithTheme(Builder(
        builder: (context) => builder(context, {}),
      )));

      expect(find.byType(WifiSettingsCard), findsOneWidget);
      expect(find.text('Unknown'), findsOneWidget); // Default SSID
      expect(find.text('Open'), findsOneWidget); // Default Security
    });
  });
}
