import '../entities/chat_message.dart';
import '../entities/gen_tool.dart';
import '../entities/llm_response.dart';

/// Interface for conversation-based content generation.
///
/// Extends the basic content generation concept to support multi-turn
/// conversations with full message history and tool definitions.
///
/// This interface is designed to be implemented by adapters that connect
/// to various LLM providers (e.g., AWS Bedrock, OpenAI, Anthropic API).
abstract class IConversationGenerator {
  /// Generate a response based on conversation history.
  ///
  /// Takes the complete [messages] history and optional [tools] definitions
  /// to generate a contextually appropriate response.
  ///
  /// Parameters:
  /// - [messages]: Complete conversation history in chronological order
  /// - [tools]: Optional list of available tools/functions the AI can invoke
  /// - [systemPrompt]: Optional system-level instructions for the AI
  ///
  /// Returns an [LLMResponse] containing the AI's response, which may include
  /// text content, tool use requests, or both.
  ///
  /// Throws:
  /// - [NetworkException] for connectivity issues
  /// - [AuthenticationException] for credential failures
  /// - [RateLimitException] when rate limits are exceeded
  /// - [ValidationException] for invalid requests
  /// - [GenUiException] for other errors
  Future<LLMResponse> generateWithHistory(
    List<ChatMessage> messages, {
    List<GenTool>? tools,
    String? systemPrompt,
  });
}
