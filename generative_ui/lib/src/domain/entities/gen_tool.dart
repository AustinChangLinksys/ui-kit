class GenTool {
  final String name;
  final String description;
  final Map<String, dynamic> inputSchema;

  GenTool({
    required this.name,
    required this.description,
    required this.inputSchema,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'input_schema': inputSchema,
      };

  factory GenTool.fromJson(Map<String, dynamic> json) {
    return GenTool(
      name: json['name'] as String? ?? '',
      description: json['description'] as String? ?? '',
      inputSchema: json['input_schema'] as Map<String, dynamic>? ?? {},
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GenTool &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          description == other.description &&
          inputSchema == other.inputSchema;

  @override
  int get hashCode => name.hashCode ^ description.hashCode ^ inputSchema.hashCode;
}
