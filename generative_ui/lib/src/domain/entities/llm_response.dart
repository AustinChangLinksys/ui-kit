import 'content_block.dart';

class LLMResponse {
  final String id;
  final String model;
  final List<ContentBlock> content;
  final String? stopReason;

  LLMResponse({
    required this.id,
    required this.model,
    required this.content,
    this.stopReason,
  });

  ToolUseBlock? getFirstToolUse() {
    try {
      return content.whereType<ToolUseBlock>().first;
    } catch (e) {
      return null;
    }
  }

  bool hasToolUse() => getFirstToolUse() != null;

  bool isValid() {
    if (id.isEmpty || model.isEmpty || content.isEmpty) {
      return false;
    }

    for (final block in content) {
      if (block is ToolUseBlock) {
        if (block.id.isEmpty || block.name.isEmpty) {
          return false;
        }
      }
    }

    return true;
  }

  Map<String, dynamic> toMap() => {
        'id': id,
        'model': model,
        'content': content.map((block) => block.toMap()).toList(),
        if (stopReason != null) 'stop_reason': stopReason,
      };

  factory LLMResponse.fromMap(Map<String, dynamic> map) {
    final contentList = map['content'] as List? ?? [];
    final content = contentList.map((item) {
      final itemMap = item as Map<String, dynamic>;
      final type = itemMap['type'] as String?;

      if (type == 'tool_use') {
        return ToolUseBlock.fromMap(itemMap);
      } else {
        return TextBlock.fromMap(itemMap);
      }
    }).toList();

    return LLMResponse(
      id: map['id'] as String? ?? '',
      model: map['model'] as String? ?? '',
      content: content,
      stopReason: map['stop_reason'] as String?,
    );
  }
}
