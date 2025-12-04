import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/domain/entities/content_block.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/widgets/dynamic_builder.dart';
import 'package:generative_ui/src/presentation/widgets/fallback_card.dart';
import 'package:generative_ui/src/presentation/widgets/message_bubble.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Mock Registry
class MockRegistry implements IComponentRegistry {
  final Map<String, GenUiWidgetBuilder> _registry = {};

  @override
  void register(String componentName, GenUiWidgetBuilder builder) {
    _registry[componentName] = builder;
  }

  @override
  GenUiWidgetBuilder? lookup(String componentName) {
    return _registry[componentName];
  }

  @override
  List<String> getRegisteredComponents() {
    return _registry.keys.toList();
  }
}

void main() {
  late MockRegistry registry;
  late DynamicWidgetBuilder dynamicBuilder;

  setUp(() {
    registry = MockRegistry();
    dynamicBuilder = DynamicWidgetBuilder(registry: registry);
  });

  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(brightness: Brightness.light),
      home: Scaffold(
        body: child,
      ),
    );
  }

  group('DynamicWidgetBuilder', () {
    testWidgets('renders TextBlock as MessageBubble', (tester) async {
      final textBlock = TextBlock(text: 'Hello GenUI');

      await tester.pumpWidget(wrapWithTheme(Builder(
        builder: (context) => dynamicBuilder.buildBlock(textBlock, context),
      )));

      expect(find.byType(MessageBubble), findsOneWidget);
      expect(find.text('Hello GenUI'), findsOneWidget);
    });

    testWidgets('renders unknown ToolUseBlock as FallbackCard (Unsupported)',
        (tester) async {
      final toolBlock = ToolUseBlock(
        id: '123',
        name: 'UnknownComponent',
        input: {'foo': 'bar'},
      );

      await tester.pumpWidget(wrapWithTheme(Builder(
        builder: (context) => dynamicBuilder.buildBlock(toolBlock, context),
      )));

      expect(find.byType(FallbackCard), findsOneWidget);
      expect(find.text('Unsupported Component'), findsOneWidget);
      expect(find.text('Component: UnknownComponent'), findsOneWidget);
    });

    testWidgets('renders registered ToolUseBlock using builder',
        (tester) async {
      // Register a test component
      registry.register('TestCard', (context, props) {
        return Container(
          key: const Key('test-card'),
          child: Text(props['title'] ?? 'No Title'),
        );
      });

      final toolBlock = ToolUseBlock(
        id: '123',
        name: 'TestCard',
        input: {'title': 'My Test Card'},
      );

      await tester.pumpWidget(wrapWithTheme(Builder(
        builder: (context) => dynamicBuilder.buildBlock(toolBlock, context),
      )));

      expect(find.byKey(const Key('test-card')), findsOneWidget);
      expect(find.text('My Test Card'), findsOneWidget);
    });

    testWidgets(
        'catches builder exception and renders FallbackCard (RenderingError)',
        (tester) async {
      // Register a component that throws
      registry.register('ErrorCard', (context, props) {
        throw Exception('Builder failure');
      });

      final toolBlock = ToolUseBlock(
        id: '123',
        name: 'ErrorCard',
        input: {},
      );

      await tester.pumpWidget(wrapWithTheme(Builder(
        builder: (context) => dynamicBuilder.buildBlock(toolBlock, context),
      )));

      expect(find.byType(FallbackCard), findsOneWidget);
      expect(find.text('Component Error'), findsOneWidget);
      expect(find.text('Component: ErrorCard'), findsOneWidget);
      expect(find.textContaining('Builder failure'), findsOneWidget);
    });

    group('Type Conversion', () {
      test('safeString converts correctly', () {
        expect(DynamicWidgetBuilder.safeString('hello'), 'hello');
        expect(DynamicWidgetBuilder.safeString(123), '123');
        expect(DynamicWidgetBuilder.safeString(null, 'default'), 'default');
      });

      test('safeInt converts correctly', () {
        expect(DynamicWidgetBuilder.safeInt(123), 123);
        expect(DynamicWidgetBuilder.safeInt('456'), 456);
        expect(DynamicWidgetBuilder.safeInt(12.34), 12);
        expect(DynamicWidgetBuilder.safeInt(null, 99), 99);
        expect(DynamicWidgetBuilder.safeInt('invalid', 0), 0);
      });

      test('safeBool converts correctly', () {
        expect(DynamicWidgetBuilder.safeBool(true), true);
        expect(DynamicWidgetBuilder.safeBool('true'), true);
        expect(DynamicWidgetBuilder.safeBool('TRUE'), true);
        expect(DynamicWidgetBuilder.safeBool('yes'), true);
        expect(DynamicWidgetBuilder.safeBool(1), true);
        expect(DynamicWidgetBuilder.safeBool(0), false);
        expect(DynamicWidgetBuilder.safeBool('false'), false);
        expect(DynamicWidgetBuilder.safeBool(null), false);
      });

      test('safeEnum converts correctly', () {
        expect(
            DynamicWidgetBuilder.safeEnum(
                'value1', TestEnum.values, TestEnum.value2),
            TestEnum.value1);
        expect(
            DynamicWidgetBuilder.safeEnum(
                'VALUE1', TestEnum.values, TestEnum.value2),
            TestEnum.value1);
        expect(
            DynamicWidgetBuilder.safeEnum(
                'invalid', TestEnum.values, TestEnum.value2),
            TestEnum.value2);
        expect(
            DynamicWidgetBuilder.safeEnum(
                null, TestEnum.values, TestEnum.value2),
            TestEnum.value2);
      });
    });
  });
}

enum TestEnum { value1, value2 }
