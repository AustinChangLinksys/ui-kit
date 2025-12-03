import '../entities/gen_exception.dart';
import '../entities/llm_response.dart';
import '../entities/content_block.dart';
import '../repositories/i_content_generator.dart';
import '../../data/utils/response_parser.dart';

class OrchestrateUIFlowUseCase {
  final IContentGenerator contentGenerator;

  OrchestrateUIFlowUseCase({required this.contentGenerator});

  /// Orchestrate the complete flow: Generate → Parse → Build → Validate
  Future<LLMResponse> execute(String userInput) async {
    try {
      // Step 1: Generate raw response
      final rawResponse = await contentGenerator.generate(userInput);

      // Step 2: Parse JSON
      final parsedMap = ResponseParser.parse(rawResponse);

      // Step 3: Build LLMResponse domain model
      final llmResponse = LLMResponse.fromMap(parsedMap);

      // Step 4: Validate
      _validateResponse(llmResponse);

      return llmResponse;
    } catch (e) {
      if (e is GenException) {
        rethrow;
      }
      throw ContentGenerationException(
        'Orchestration failed: ${e.toString()}',
      );
    }
  }

  // /// Build LLMResponse from parsed Claude format
  // LLMResponse _buildResponse(Map<String, dynamic> map) {
  //   return LLMResponse.fromMap(map);
  // }

  /// Validate response meets requirements
  void _validateResponse(LLMResponse response) {
    if (!response.isValid()) {
      throw ToolUseValidationException(
        'Invalid LLMResponse: missing required fields',
        toolBlock: response,
      );
    }

    // Validate tool use blocks if present
    for (final block in response.content) {
      if (block is ToolUseBlock) {
        if (block.id.isEmpty || block.name.isEmpty) {
          throw ToolUseValidationException(
            'Invalid ToolUseBlock: id or name is empty',
            toolBlock: block,
          );
        }
      }
    }
  }
}
