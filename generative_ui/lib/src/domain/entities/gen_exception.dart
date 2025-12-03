abstract class GenException implements Exception {
  final String message;

  GenException(this.message);

  @override
  String toString() => message;
}

class ParsingException extends GenException {
  final String? originalInput;

  ParsingException(String message, {this.originalInput}) : super(message);
}

class ToolUseValidationException extends GenException {
  final dynamic toolBlock;

  ToolUseValidationException(String message, {this.toolBlock})
      : super(message);
}

class ContentGenerationException extends GenException {
  final dynamic rawResponse;

  ContentGenerationException(String message, {this.rawResponse})
      : super(message);
}
