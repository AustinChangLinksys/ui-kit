import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/domain/entities/llm_response.dart';
import 'package:generative_ui/src/domain/entities/content_block.dart';
import 'package:generative_ui/src/domain/usecases/orchestrate_ui_flow.dart';
import 'package:generative_ui/src/domain/repositories/i_content_generator.dart';
import 'package:generative_ui/src/presentation/gen_ui_wrapper.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/widgets/gen_ui_container.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Mocks
class MockContentGenerator implements IContentGenerator {
  @override
  Future<String> generate(String prompt) async => '';
}

class MockOrchestrator extends OrchestrateUIFlowUseCase {
  MockOrchestrator() : super(contentGenerator: MockContentGenerator());
  
  @override
  Future<LLMResponse> execute(String userInput) async {
    return LLMResponse(id: '1', model: 'test', content: [TextBlock(text: 'Wrapper Test')]);
  }
}

void main() {
  late ComponentRegistry registry;
  late MockOrchestrator orchestrator;

  setUp(() {
    registry = ComponentRegistry();
    orchestrator = MockOrchestrator();
  });

  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(brightness: Brightness.light),
      home: Scaffold(body: child),
    );
  }

  testWidgets('GenUiWrapper mounts GenUiContainer', (tester) async {
    await tester.pumpWidget(wrapWithTheme(GenUiWrapper(
      registry: registry,
      orchestrator: orchestrator,
    )));

    expect(find.byType(GenUiContainer), findsOneWidget);
  });

  testWidgets('GenUiWrapper passes onComplete to GenUiContainer', (tester) async {
    bool completed = false;
    await tester.pumpWidget(wrapWithTheme(GenUiWrapper(
      registry: registry,
      orchestrator: orchestrator,
      onComplete: () => completed = true,
    )));

    final containerState = tester.state<GenUiContainerState>(find.byType(GenUiContainer));
    containerState.sendMessage('test');
    await tester.pump(); // loading
    await tester.pump(); // data

    expect(completed, isTrue);
  });
}
