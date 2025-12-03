abstract class ContentBlock {
  final String type;

  ContentBlock({required this.type});

  Map<String, dynamic> toMap();
}

class TextBlock extends ContentBlock {
  final String text;

  TextBlock({required this.text}) : super(type: 'text');

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'text': text,
      };

  factory TextBlock.fromMap(Map<String, dynamic> map) {
    return TextBlock(
      text: map['text'] as String? ?? '',
    );
  }
}

class ToolUseBlock extends ContentBlock {
  final String id;
  final String name;
  final Map<String, dynamic> input;

  ToolUseBlock({
    required this.id,
    required this.name,
    required this.input,
  }) : super(type: 'tool_use');

  @override
  Map<String, dynamic> toMap() => {
        'type': type,
        'id': id,
        'name': name,
        'input': input,
      };

  factory ToolUseBlock.fromMap(Map<String, dynamic> map) {
    return ToolUseBlock(
      id: map['id'] as String? ?? '',
      name: map['name'] as String? ?? '',
      input: map['input'] as Map<String, dynamic>? ?? {},
    );
  }
}
