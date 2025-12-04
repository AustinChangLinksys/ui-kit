import 'package:equatable/equatable.dart';

/// Represents a node in an AI-generated layout tree.
///
/// Each node corresponds to a UI component with a type name,
/// properties map, and optional children for container components.
///
/// Example JSON structure:
/// ```json
/// {
///   "type": "Column",
///   "props": { "mainAxisAlignment": "center" },
///   "children": [
///     { "type": "AppButton", "props": { "label": "Click Me" } }
///   ]
/// }
/// ```
class LayoutNode extends Equatable {
  /// The component type name (e.g., 'AppButton', 'Column').
  final String type;

  /// Properties to pass to the component constructor.
  final Map<String, dynamic> properties;

  /// Child nodes for container components (Column, Row, Card, etc.).
  final List<LayoutNode> children;

  /// Creates a layout node with the given type, properties, and children.
  const LayoutNode({
    required this.type,
    this.properties = const {},
    this.children = const [],
  });

  /// Creates a LayoutNode from a JSON map.
  ///
  /// Throws [FormatException] if the 'type' field is missing.
  factory LayoutNode.fromJson(Map<String, dynamic> json) {
    final type = json['type'];
    if (type == null || type is! String) {
      throw FormatException(
        'LayoutNode requires a "type" field of type String',
        json,
      );
    }

    return LayoutNode(
      type: type,
      properties: Map<String, dynamic>.from(json['props'] ?? {}),
      children: (json['children'] as List<dynamic>?)
              ?.map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  /// Converts this node to a JSON map.
  Map<String, dynamic> toJson() => {
        'type': type,
        'props': properties,
        if (children.isNotEmpty)
          'children': children.map((c) => c.toJson()).toList(),
      };

  /// Whether this node has children.
  bool get hasChildren => children.isNotEmpty;

  /// Creates a copy of this node with the given fields replaced.
  LayoutNode copyWith({
    String? type,
    Map<String, dynamic>? properties,
    List<LayoutNode>? children,
  }) {
    return LayoutNode(
      type: type ?? this.type,
      properties: properties ?? this.properties,
      children: children ?? this.children,
    );
  }

  @override
  List<Object?> get props => [type, properties, children];

  @override
  String toString() => 'LayoutNode(type: $type, properties: $properties, '
      'children: ${children.length})';
}
