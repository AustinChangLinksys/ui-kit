import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/domain/entities/content_block.dart';
import 'package:generative_ui/src/domain/entities/llm_response.dart';
import 'package:generative_ui/src/domain/repositories/i_content_generator.dart';
import 'package:generative_ui/src/domain/usecases/orchestrate_ui_flow.dart';
import 'package:generative_ui/src/presentation/gen_ui_wrapper.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/registry/registry_helpers.dart';
import 'package:generative_ui/src/presentation/widgets/dynamic_builder.dart';
import 'package:generative_ui/src/presentation/widgets/fallback_card.dart';
import 'package:generative_ui/src/presentation/widgets/gen_ui_container.dart';
import 'package:generative_ui/src/presentation/widgets/loading_indicator.dart';
import 'package:ui_kit_library/ui_kit.dart';

class MockContentGenerator implements IContentGenerator {
  @override
  Future<String> generate(String prompt) async => '';
}

class MockOrchestrator extends OrchestrateUIFlowUseCase {
  MockOrchestrator() : super(contentGenerator: MockContentGenerator());

  LLMResponse? responseToReturn;
  int delayMs = 0;

  @override
  Future<LLMResponse> execute(String userInput) async {
    if (delayMs > 0) await Future.delayed(Duration(milliseconds: delayMs));
    return responseToReturn ?? LLMResponse(id: '1', model: 'test', content: []);
  }
}

void main() {
  late ComponentRegistry registry;
  late DynamicWidgetBuilder builder;
  late MockOrchestrator orchestrator;

  setUp(() {
    registry = ComponentRegistry();
    builder = DynamicWidgetBuilder(registry: registry);
    orchestrator = MockOrchestrator();
    registerWifiSettingsCard(registry);
  });

  Widget wrapWithTheme(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(brightness: Brightness.light),
      home: Scaffold(body: child),
    );
  }

  testWidgets('E2E: Full flow state transitions (Setup Wi-Fi)', (tester) async {
    orchestrator.responseToReturn = LLMResponse(
      id: 'wifi-flow',
      model: 'gpt-4',
      content: [
        ToolUseBlock(
          id: 'tool-1',
          name: 'WifiSettingsCard',
          input: {'ssid': 'MyWifi', 'security': 'WPA2'},
        )
      ],
    );
    orchestrator.delayMs = 50;

    await tester.pumpWidget(wrapWithTheme(GenUiContainer(
      registry: registry,
      orchestrator: orchestrator,
    )));

    final state = tester.state<GenUiContainerState>(find.byType(GenUiContainer));
    
    // Trigger
    state.sendMessage('Setup Wi-Fi');
    await tester.pump();
    
    // Verify Loading
    expect(find.byType(LoadingIndicator), findsOneWidget);

    // Finish
    await tester.pump(const Duration(milliseconds: 50));
    
    // Verify Data (WifiSettingsCard)
    expect(find.text('MyWifi'), findsOneWidget);
  });

  testWidgets('E2E: Renders WifiSettingsCard from ToolUseBlock with props', (tester) async {
    final block = ToolUseBlock(
      id: 'tool-1',
      name: 'WifiSettingsCard',
      input: {
        'ssid': 'E2E Network',
        'security': 'WPA3',
        'isEnabled': true,
      },
    );

    await tester.pumpWidget(wrapWithTheme(Builder(
      builder: (context) => builder.buildBlock(block, context),
    )));

    expect(find.text('E2E Network'), findsOneWidget);
    expect(find.text('WPA3'), findsOneWidget);
  });

  testWidgets('E2E: Renders FallbackCard for unknown component', (tester) async {
    final block = ToolUseBlock(
      id: 'tool-2',
      name: 'UnknownComp',
      input: {},
    );

    await tester.pumpWidget(wrapWithTheme(Builder(
      builder: (context) => builder.buildBlock(block, context),
    )));

    expect(find.byType(FallbackCard), findsOneWidget);
    expect(find.text('Unsupported Component'), findsOneWidget);
  });

  testWidgets('E2E: Renders FallbackCard for builder error', (tester) async {
    registry.register('BadComp', (context, props) => throw 'Error');
    
    final block = ToolUseBlock(
      id: 'tool-3',
      name: 'BadComp',
      input: {},
    );

    await tester.pumpWidget(wrapWithTheme(Builder(
      builder: (context) => builder.buildBlock(block, context),
    )));

    expect(find.byType(FallbackCard), findsOneWidget);
    expect(find.text('Component Error'), findsOneWidget);
  });

  testWidgets('E2E: Renders mixed content sequence (Text -> Wifi -> Text)', (tester) async {
    final response = LLMResponse(
      id: 'mixed-1',
      model: 'gpt-4',
      content: [
        TextBlock(text: 'Opening Wi-Fi settings...'),
        ToolUseBlock(
          id: 'tool-mix',
          name: 'WifiSettingsCard',
          input: {'ssid': 'Mixed Net', 'security': 'WEP'},
        ),
        TextBlock(text: 'Please configure your network.'),
      ],
    );

    await tester.pumpWidget(wrapWithTheme(GenUiContainer(
      initialResponse: response,
      registry: registry,
      orchestrator: orchestrator,
    )));

    expect(find.text('Opening Wi-Fi settings...'), findsOneWidget);
    expect(find.text('Mixed Net'), findsOneWidget);
    expect(find.text('Please configure your network.'), findsOneWidget);
  });

  testWidgets('E2E: GenUiWrapper integration', (tester) async {
    orchestrator.responseToReturn = LLMResponse(
      id: 'wrap', model: 't', content: [TextBlock(text: 'From Wrapper')]
    );

    await tester.pumpWidget(wrapWithTheme(GenUiWrapper(
      registry: registry,
      orchestrator: orchestrator,
    )));

    // Trigger via finding state
    final state = tester.state<GenUiContainerState>(find.byType(GenUiContainer));
    state.sendMessage('go');
    await tester.pumpAndSettle();

    expect(find.text('From Wrapper'), findsOneWidget);
  });
}