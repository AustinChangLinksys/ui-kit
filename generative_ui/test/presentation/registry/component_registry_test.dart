import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';

Widget _testBuilder(
  BuildContext context,
  Map<String, dynamic> props, {
  GenUiActionCallback? onAction,
}) =>
    const SizedBox();

Widget _textBuilder1(
  BuildContext context,
  Map<String, dynamic> props, {
  GenUiActionCallback? onAction,
}) =>
    const Text('Builder1');

Widget _textBuilder2(
  BuildContext context,
  Map<String, dynamic> props, {
  GenUiActionCallback? onAction,
}) =>
    const Text('Builder2');

void main() {
  group('ComponentRegistry', () {
    late ComponentRegistry registry;

    setUp(() {
      registry = ComponentRegistry();
    });

    test('register and lookup returns builder', () {
      // Arrange
      const componentName = 'TestComponent';

      // Act
      registry.register(componentName, _testBuilder);
      final result = registry.lookup(componentName);

      // Assert
      expect(result, equals(_testBuilder));
    });

    test('lookup returns null for unregistered component', () {
      // Arrange
      const componentName = 'UnregisteredComponent';

      // Act
      final result = registry.lookup(componentName);

      // Assert
      expect(result, isNull);
    });

    test('getRegisteredComponents returns all registered names', () {
      // Arrange
      registry.register('Component1', _testBuilder);
      registry.register('Component2', _testBuilder);
      registry.register('Component3', _testBuilder);

      // Act
      final components = registry.getRegisteredComponents();

      // Assert
      expect(components, containsAll(['Component1', 'Component2', 'Component3']));
      expect(components.length, equals(3));
    });

    test('registry returns empty list when no components registered', () {
      // Act
      final components = registry.getRegisteredComponents();

      // Assert
      expect(components, isEmpty);
    });

    test('lookup performance with 100 components', () {
      // Arrange
      for (int i = 0; i < 100; i++) {
        registry.register('Component$i', _testBuilder);
      }

      // Act & Assert - Verify lookup completes in acceptable time
      final stopwatch = Stopwatch()..start();
      for (int i = 0; i < 1000; i++) {
        registry.lookup('Component50');
      }
      stopwatch.stop();

      // Verify 1000 lookups complete in less than 10ms
      // (This is typically ~0.01ms per lookup, but we allow margin for test overhead)
      expect(stopwatch.elapsedMilliseconds, lessThan(10),
          reason: 'Registry lookup should be O(1) and complete quickly');
    });

    test('duplicate registration replaces previous builder', () {
      // Arrange
      const componentName = 'TestComponent';

      // Act
      registry.register(componentName, _textBuilder1);
      registry.register(componentName, _textBuilder2);
      final result = registry.lookup(componentName);

      // Assert
      expect(result, equals(_textBuilder2));
    });

    test('case sensitivity in component names', () {
      // Arrange
      registry.register('TestComponent', _testBuilder);

      // Act
      final exactMatch = registry.lookup('TestComponent');
      final lowercase = registry.lookup('testcomponent');

      // Assert
      expect(exactMatch, isNotNull);
      expect(lowercase, isNull);
    });
  });
}
