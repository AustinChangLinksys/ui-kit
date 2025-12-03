import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:generative_ui/src/domain/entities/content_block.dart';
import 'package:generative_ui/src/domain/entities/llm_response.dart';
import 'package:generative_ui/src/domain/repositories/i_content_generator.dart';
import 'package:generative_ui/src/domain/usecases/orchestrate_ui_flow.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/registry/registry_helpers.dart';
import 'package:generative_ui/src/presentation/widgets/dynamic_builder.dart';
import 'package:generative_ui/src/presentation/widgets/error_display.dart';
import 'package:generative_ui/src/presentation/widgets/gen_ui_container.dart';
import 'package:generative_ui/src/presentation/widgets/loading_indicator.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Standard Golden Test (No Alchemist) to avoid complex pump/semantics issues
// Alchemist is great but finicky with complex widget trees in some environments.
// Fallback to standard flutter_test matchesGoldenFile.

class MockOrchestrator extends OrchestrateUIFlowUseCase {
  MockOrchestrator() : super(contentGenerator: MockContentGenerator());
  @override
  Future<LLMResponse> execute(String userInput) {
    return Future.value(LLMResponse(id: 'mock', model: 'test', content: []));
  }
}
class MockContentGenerator implements IContentGenerator {
  @override
  Future<String> generate(String prompt) async => '';
}

void main() {
  late ComponentRegistry registry;
  late DynamicWidgetBuilder builder;

  setUp(() {
    registry = ComponentRegistry();
    builder = DynamicWidgetBuilder(registry: registry);
    registerWifiSettingsCard(registry);
    registerInfoCard(registry);
  });

  Widget buildWrapper(Widget child) {
    return MaterialApp(
      theme: AppTheme.create(brightness: Brightness.light),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: child,
        ),
      ),
    );
  }

  testWidgets('Golden: GenUI Widgets', (tester) async {
    await tester.pumpWidget(buildWrapper(
      Column(
        children: [
          Builder(builder: (ctx) => builder.buildBlock(
            ToolUseBlock(
              id: '1',
              name: 'WifiSettingsCard',
              input: {'ssid': 'MyWifi', 'security': 'WPA3', 'isEnabled': true},
            ),
            ctx,
          )),
          const SizedBox(height: 16),
          Builder(builder: (ctx) => builder.buildBlock(
            ToolUseBlock(
              id: '2',
              name: 'InfoCard',
              input: {'title': 'Info', 'message': 'Hello World', 'icon': 'info'},
            ),
            ctx,
          )),
          const SizedBox(height: 16),
          // LoadingIndicator has infinite animation, causing pumpAndSettle timeout.
          // Mocking it or removing it for this static golden.
          const Text('Loading Indicator Placeholder'), 
        ],
      )
    ));

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/gen_ui_widgets.png'),
    );
  });

  testWidgets('Golden: Mixed Layout', (tester) async {
    await tester.pumpWidget(buildWrapper(
      GenUiContainer(
        registry: registry,
        orchestrator: MockOrchestrator(),
        initialResponse: LLMResponse(
          id: 'mix', 
          model: 't', 
          content: [
            TextBlock(text: 'Configuring...'),
            ToolUseBlock(
              id: 't1', 
              name: 'WifiSettingsCard', 
              input: {'ssid': 'Mixed', 'security': 'Open'}
            ),
            TextBlock(text: 'Done.'),
          ],
        ),
      ),
    ));

    await tester.pumpAndSettle();

    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('goldens/gen_ui_mixed_layout.png'),
    );
  });
}