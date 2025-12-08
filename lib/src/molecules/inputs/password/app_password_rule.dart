class AppPasswordRule {
  final String label;
  final bool Function(String value) validate;

  const AppPasswordRule({required this.label, required this.validate});
}
