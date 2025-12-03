import 'package:alchemist/alchemist.dart';
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

import '../../utils/golden_test_utils.dart';

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
  final theme = AppTheme.create(brightness: Brightness.light);

  setUp(() {
    registry = ComponentRegistry();
    builder = DynamicWidgetBuilder(registry: registry);
    registerWifiSettingsCard(registry);
    registerInfoCard(registry);
  });

  group('GenUI Goldens', () {
    goldenTest(
      'Widgets (Safe Mode)',
      fileName: 'gen_ui_widgets',
      pumpBeforeTest: (tester) async {
        await tester.pump(); 
      },
      builder: () {
        return GoldenTestGroup(
          children: [
            buildSafeScenario(
              name: 'WifiSettingsCard',
              theme: theme,
              width: 600, // Significantly increased width
              height: 300,
              child: Builder(builder: (ctx) => builder.buildBlock(
                ToolUseBlock(
                  id: '1',
                  name: 'WifiSettingsCard',
                  input: {'ssid': 'MyWifi', 'security': 'WPA3', 'isEnabled': true},
                ),
                ctx,
              )),
            ),
            buildSafeScenario(
              name: 'InfoCard',
              theme: theme,
              width: 600,
              height: 200,
              child: Builder(builder: (ctx) => builder.buildBlock(
                ToolUseBlock(
                  id: '2',
                  name: 'InfoCard',
                  input: {'title': 'Info', 'message': 'Hello World', 'icon': 'info'},
                ),
                ctx,
              )),
            ),
            buildSafeScenario(
              name: 'MessageBubble (AI)',
              theme: theme,
              width: 600,
              child: Builder(builder: (ctx) => builder.buildBlock(
                TextBlock(text: 'This is an AI response.'),
                ctx,
              )),
            ),
            buildSafeScenario(
              name: 'FallbackCard (Unsupported)',
              theme: theme,
              width: 600,
              child: Builder(builder: (ctx) => builder.buildBlock(
                ToolUseBlock(id: '3', name: 'Unknown', input: {}),
                ctx,
              )),
            ),
            buildSafeScenario(
              name: 'LoadingIndicator (Frozen)',
              theme: theme,
              child: const LoadingIndicator(),
            ),
            buildSafeScenario(
              name: 'ErrorDisplay',
              theme: theme,
              width: 600,
              height: 300,
              child: ErrorDisplay(message: 'Error occurred', onRetry: () {}),
            ),
          ],
        );
      },
    );

    goldenTest(
      'Mixed Layout',
      fileName: 'gen_ui_mixed_layout',
      pumpBeforeTest: (tester) async {
        await tester.pump();
      },
      builder: () {
        return GoldenTestGroup(
          children: [
            buildSafeScenario(
              name: 'Mixed Content Container',
              theme: theme,
              width: 600, // Sufficient width
              height: 800, // Tall enough for mixed content list
              child: GenUiContainer(
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
            ),
          ],
        );
      },
    );
  });
}
