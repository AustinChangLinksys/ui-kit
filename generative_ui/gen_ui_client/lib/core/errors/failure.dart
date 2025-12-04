import 'package:equatable/equatable.dart';

/// Represents a failure in the application.
///
/// Sealed class hierarchy for type-safe error handling.
sealed class Failure extends Equatable {
  /// Human-readable error message.
  final String message;

  /// Optional error code for programmatic handling.
  final String? code;

  const Failure(this.message, {this.code});

  @override
  List<Object?> get props => [message, code];
}

/// Failure related to component registry operations.
final class RegistryFailure extends Failure {
  /// The component name that caused the failure.
  final String componentName;

  const RegistryFailure(super.message, {required this.componentName, super.code});

  @override
  List<Object?> get props => [message, code, componentName];
}

/// Failure related to theme operations.
final class ThemeFailure extends Failure {
  const ThemeFailure(super.message, {super.code});
}

/// Failure related to code generation (Future Phase).
final class CodeGenFailure extends Failure {
  /// The source that failed to generate.
  final String? source;

  const CodeGenFailure(super.message, {this.source, super.code});

  @override
  List<Object?> get props => [message, code, source];
}

/// Generic unexpected failure.
final class UnexpectedFailure extends Failure {
  /// The original exception, if available.
  final Object? originalException;

  const UnexpectedFailure(super.message, {this.originalException, super.code});

  @override
  List<Object?> get props => [message, code, originalException];
}
