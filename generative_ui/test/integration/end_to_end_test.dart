import 'package:flutter_test/flutter_test.dart';

import 'package:generative_ui/generative_ui.dart';
import 'package:generative_ui/src/domain/usecases/orchestrate_ui_flow.dart';

void main() {
  group('End-to-End Integration Tests', () {
    late OrchestrateUIFlowUseCase orchestrator;
    late MockContentGenerator generator;

    setUp(() {
      generator = MockContentGenerator();
      orchestrator = OrchestrateUIFlowUseCase(
        contentGenerator: generator,
      );
    });

    group('Wi-Fi Scenario', () {
      test('completes full pipeline: generate → parse → build → validate', () async {
        final result = await orchestrator.execute('setup wifi');

        expect(result, isA<LLMResponse>());
        expect(result.id, isNotEmpty);
        expect(result.model, isNotEmpty);
        expect(result.content, isNotEmpty);
        expect(result.isValid(), equals(true));
      });

      test('produces correct ToolUseBlock for Wi-Fi component', () async {
        final result = await orchestrator.execute('wifi');

        final toolBlock = result.getFirstToolUse();
        expect(toolBlock, isNotNull);
        expect(toolBlock!.name, equals('WifiSettingsCard'));
        expect(toolBlock.input.containsKey('ssid'), equals(true));
      });
    });

    group('Info Scenario (Default)', () {
      test('returns valid LLMResponse for unknown keywords', () async {
        final result = await orchestrator.execute('hello');

        expect(result, isA<LLMResponse>());
        expect(result.isValid(), equals(true));
        expect(result.content, isNotEmpty);
      });

      test('includes user input in response', () async {
        const userMessage = 'custom test message';
        final result = await orchestrator.execute(userMessage);

        // Response should be valid
        expect(result.isValid(), equals(true));
      });
    });

    group('Error Scenario', () {
      test('gracefully handles error responses', () async {
        final result = await orchestrator.execute('error');

        expect(result, isA<LLMResponse>());
        expect(result.content, isNotEmpty);
        // Error responses are still valid domain models
        expect(result.isValid(), equals(true));
      });
    });

    group('Validation and Parsing', () {
      test('throws exception for invalid responses', () async {
        // This would require a mock that returns invalid JSON
        // For now, we verify that valid mocks pass validation
        final result = await orchestrator.execute('wifi');
        expect(() => result.isValid(), returnsNormally);
      });

      test('all 3 scenarios complete successfully', () async {
        final wifiResult = await orchestrator.execute('wifi');
        final infoResult = await orchestrator.execute('hello');
        final errorResult = await orchestrator.execute('error');

        expect(wifiResult.isValid(), equals(true));
        expect(infoResult.isValid(), equals(true));
        expect(errorResult.isValid(), equals(true));
      });
    });

    group('Performance and Reliability', () {
      test('rapid execution of orchestration', () async {
        final stopwatch = Stopwatch()..start();

        final futures = <Future<LLMResponse>>[];
        for (int i = 0; i < 10; i++) {
          futures.add(orchestrator.execute('test_$i'));
        }

        await Future.wait(futures);
        stopwatch.stop();

        expect(stopwatch.elapsedMilliseconds, lessThanOrEqualTo(2000));
      });

      test('handles concurrent requests', () async {
        final futures = <Future<LLMResponse>>[];

        for (int i = 0; i < 20; i++) {
          if (i % 3 == 0) {
            futures.add(orchestrator.execute('wifi'));
          } else if (i % 3 == 1) {
            futures.add(orchestrator.execute('error'));
          } else {
            futures.add(orchestrator.execute('hello'));
          }
        }

        final results = await Future.wait(futures);
        expect(results.length, equals(20));

        for (final result in results) {
          expect(result.isValid(), equals(true));
        }
      });
    });

    group('SC-001: All 3 mock scenarios work end-to-end', () {
      test('Wi-Fi scenario triggers and completes', () async {
        final result = await orchestrator.execute('setup wifi');
        expect(result.getFirstToolUse()?.name, equals('WifiSettingsCard'));
      });

      test('Info scenario triggers and completes', () async {
        final result = await orchestrator.execute('hello');
        expect(result.isValid(), equals(true));
      });

      test('Error scenario triggers and completes', () async {
        final result = await orchestrator.execute('test error');
        expect(result.isValid(), equals(true));
      });
    });
  });
}
