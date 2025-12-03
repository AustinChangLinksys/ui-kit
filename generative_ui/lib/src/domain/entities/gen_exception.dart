abstract class GenException implements Exception {
  final String message;

  GenException(this.message);

  @override
  String toString() => message;
}

class ParsingException extends GenException {
  final String? originalInput;

  ParsingException(super.message, {this.originalInput});
}

class ToolUseValidationException extends GenException {
  final dynamic toolBlock;

  ToolUseValidationException(super.message, {this.toolBlock});
}

class ContentGenerationException extends GenException {
  final dynamic rawResponse;

  ContentGenerationException(super.message, {this.rawResponse});
}
