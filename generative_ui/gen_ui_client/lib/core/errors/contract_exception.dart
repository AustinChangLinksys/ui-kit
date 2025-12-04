/// Exception thrown when a contract validation fails.
///
/// Used by the component registry when prop validation fails
/// or when required parameters are missing.
class ContractException implements Exception {
  /// The error message describing the contract violation.
  final String message;

  /// The component or entity that violated the contract.
  final String? component;

  /// The specific field or property that caused the violation.
  final String? field;

  const ContractException(
    this.message, {
    this.component,
    this.field,
  });

  @override
  String toString() {
    final buffer = StringBuffer('ContractException: $message');
    if (component != null) {
      buffer.write(' (component: $component');
      if (field != null) {
        buffer.write(', field: $field');
      }
      buffer.write(')');
    } else if (field != null) {
      buffer.write(' (field: $field)');
    }
    return buffer.toString();
  }
}
