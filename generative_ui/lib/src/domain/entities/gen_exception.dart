/// Base exception class for all GenUI errors.
///
/// Provides a standardized way to handle errors with retryable status.
abstract class GenUiException implements Exception {
  final String message;

  /// Whether this error can be resolved by retrying the operation.
  bool get isRetryable => false;

  GenUiException(this.message);

  @override
  String toString() => '$runtimeType: $message';
}

/// @deprecated Use [GenUiException] instead. Kept for backward compatibility.
typedef GenException = GenUiException;

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

// ============================================================================
// Phase 3: AWS Integration Exceptions
// ============================================================================

/// Exception for network connectivity issues.
///
/// Network errors are typically retryable as they may be transient.
class NetworkException extends GenUiException {
  final Exception? cause;

  NetworkException(super.message, {this.cause});

  @override
  bool get isRetryable => true;
}

/// Exception for authentication and authorization failures.
///
/// These are NOT retryable without user intervention (e.g., refreshing credentials).
class AuthenticationException extends GenUiException {
  final int? statusCode;

  AuthenticationException(super.message, {this.statusCode});

  @override
  bool get isRetryable => false;
}

/// Exception for rate limiting (HTTP 429).
///
/// Rate limit errors are retryable after a delay.
class RateLimitException extends GenUiException {
  final Duration? retryAfter;

  RateLimitException({
    String message = 'Rate limit exceeded',
    this.retryAfter,
  }) : super(message);

  @override
  bool get isRetryable => true;
}

/// Exception for missing or invalid configuration.
///
/// Configuration errors are NOT retryable without fixing the configuration.
class ConfigurationException extends GenUiException {
  final String? missingKey;

  ConfigurationException(super.message, {this.missingKey});

  @override
  bool get isRetryable => false;
}

/// Exception for request validation failures (HTTP 400).
class ValidationException extends GenUiException {
  final Map<String, dynamic>? details;

  ValidationException(super.message, {this.details});

  @override
  bool get isRetryable => false;
}

/// Exception for server errors (HTTP 5xx).
///
/// Server errors are typically retryable as they may be temporary.
class ServerException extends GenUiException {
  final int? statusCode;

  ServerException(super.message, {this.statusCode});

  @override
  bool get isRetryable => true;
}

/// Generic exception for unknown or unclassified errors.
class GenericException extends GenUiException {
  final bool _isRetryable;

  GenericException(super.message, {bool isRetryable = false})
      : _isRetryable = isRetryable;

  @override
  bool get isRetryable => _isRetryable;
}
