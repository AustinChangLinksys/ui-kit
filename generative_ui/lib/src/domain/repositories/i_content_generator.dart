abstract class IContentGenerator {
  /// Generate content based on user input
  ///
  /// Precondition: userInput must be a non-empty string
  /// Postcondition: returns a valid JSON string representing LLM response
  ///
  /// Returns a Future<String> containing JSON response
  /// Throws [ContentGenerationException] if generation fails
  Future<String> generate(String userInput);
}
