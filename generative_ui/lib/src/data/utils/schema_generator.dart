class SchemaField {
  final String name;
  final String type; // "string", "integer", "boolean", "object", "array"
  final String? description;
  final bool required;
  final List<String>? enumValues;

  SchemaField({
    required this.name,
    required this.type,
    this.description,
    this.required = false,
    this.enumValues,
  });

  Map<String, dynamic> toSchema() => {
        'type': type,
        if (description != null) 'description': description,
        if (enumValues != null && enumValues!.isNotEmpty) 'enum': enumValues,
      };
}

class SchemaGenerator {
  /// Generate JSON Schema Draft 7 compatible schema for a component
  static Map<String, dynamic> generateSchema({
    required String componentName,
    required Map<String, SchemaField> fields,
  }) {
    final properties = <String, dynamic>{};
    final required = <String>[];

    for (final entry in fields.entries) {
      properties[entry.key] = entry.value.toSchema();
      if (entry.value.required) {
        required.add(entry.key);
      }
    }

    return {
      'type': 'object',
      'title': componentName,
      'properties': properties,
      if (required.isNotEmpty) 'required': required,
    };
  }

  /// Validate schema conforms to JSON Schema Draft 7
  static bool isValidSchema(Map<String, dynamic> schema) {
    // Basic JSON Schema Draft 7 validation
    if (schema['type'] != 'object') return false;
    if (!schema.containsKey('properties')) return false;

    final properties = schema['properties'];
    if (properties is! Map) return false;

    return true;
  }
}
