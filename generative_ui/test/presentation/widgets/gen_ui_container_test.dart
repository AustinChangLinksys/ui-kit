import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/domain/entities/content_block.dart';
import 'package:generative_ui/src/domain/entities/llm_response.dart';
import 'package:generative_ui/src/domain/repositories/i_content_generator.dart';
import 'package:generative_ui/src/domain/usecases/orchestrate_ui_flow.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/widgets/error_display.dart';
import 'package:generative_ui/src/presentation/widgets/gen_ui_container.dart';
import 'package:generative_ui/src/presentation/widgets/loading_indicator.dart';
import 'package:generative_ui/src/presentation/widgets/message_bubble.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Mock Generator
class MockContentGenerator implements IContentGenerator {
  @override
  Future<String> generate(String prompt) async => '';
}

// Mock Orchestrator
class MockOrchestrator extends OrchestrateUIFlowUseCase {
  MockOrchestrator() : super(contentGenerator: MockContentGenerator());

  bool shouldFail = false;
  LLMResponse? responseToReturn;
  int delayMs = 0;

  @override
  Future<LLMResponse> execute(String userInput) async {
    if (delayMs > 0) await Future.delayed(Duration(milliseconds: delayMs));
    if (shouldFail) throw Exception('Mock Error');
    return responseToReturn ?? LLMResponse(id: '1', model: 'test', content: []);
  }
}

void main() {
  late ComponentRegistry registry;
  late MockOrchestrator mockOrchestrator;

  setUp(() {
    registry = ComponentRegistry();
    mockOrchestrator = MockOrchestrator();
  });

  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(brightness: Brightness.light),
      home: Scaffold(body: child),
    );
  }

  group('GenUiContainer State Management', () {
    testWidgets('Initial state renders nothing (SizedBox)', (tester) async {
      await tester.pumpWidget(wrapWithTheme(GenUiContainer(
        registry: registry,
        orchestrator: mockOrchestrator,
      )));

      // Should find GenUiContainer but no Loading or Error or Data
      expect(find.byType(LoadingIndicator), findsNothing);
      expect(find.byType(ErrorDisplay), findsNothing);
      expect(find.byType(MessageBubble), findsNothing);
    });

    testWidgets('sendMessage triggers loading then data', (tester) async {
      mockOrchestrator.responseToReturn = LLMResponse(
        id: '1',
        model: 'test',
        content: [TextBlock(text: 'Success')],
      );
      mockOrchestrator.delayMs = 50;

      await tester.pumpWidget(wrapWithTheme(GenUiContainer(
        registry: registry,
        orchestrator: mockOrchestrator,
      )));

      final state = tester.state<GenUiContainerState>(find.byType(GenUiContainer));
      
      // Trigger
      state.sendMessage('hello');
      await tester.pump(); // Rebuild to show loading
      expect(find.byType(LoadingIndicator), findsOneWidget);

      // Finish
      await tester.pump(const Duration(milliseconds: 50));
      
      // Verify Data
      expect(find.byType(MessageBubble), findsOneWidget);
      expect(find.text('Success'), findsOneWidget);
    });

    testWidgets('sendMessage failure triggers error and retry works', (tester) async {
      mockOrchestrator.shouldFail = true;

      await tester.pumpWidget(wrapWithTheme(GenUiContainer(
        registry: registry,
        orchestrator: mockOrchestrator,
      )));

      final state = tester.state<GenUiContainerState>(find.byType(GenUiContainer));
      state.sendMessage('fail');
      await tester.pump();

      expect(find.byType(ErrorDisplay), findsOneWidget);
      expect(find.textContaining('Mock Error'), findsOneWidget);

      // Retry logic
      mockOrchestrator.shouldFail = false;
      mockOrchestrator.responseToReturn = LLMResponse(id: '2', model: 'test', content: [TextBlock(text: 'Retry Success')]);
      
      await tester.tap(find.text('Retry'));
      await tester.pump(); // loading
      await tester.pump(); // data (if immediate) or wait if delayed. mock delay is 0 by default.

      expect(find.text('Retry Success'), findsOneWidget);
    });

    testWidgets('Renders initialResponse if provided', (tester) async {
      final response = LLMResponse(
        id: 'init', 
        model: 'test', 
        content: [TextBlock(text: 'Initial Data')]
      );

      await tester.pumpWidget(wrapWithTheme(GenUiContainer(
        registry: registry,
        orchestrator: mockOrchestrator,
        initialResponse: response,
      )));

      expect(find.text('Initial Data'), findsOneWidget);
    });
  });
}