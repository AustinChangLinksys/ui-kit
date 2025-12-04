# Data Model: GenUI Phase 4 - Client Refactoring & Layout Architect

**Date**: 2025-12-04
**Status**: Complete

## Entity Overview

```
┌─────────────────────────────────────────────────────────────────┐
│                      gen_ui_client                               │
├─────────────────────────────────────────────────────────────────┤
│                                                                  │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────────┐  │
│  │ ThemeState   │    │ LayoutNode   │    │ CodeGenResult    │  │
│  │              │    │              │    │                  │  │
│  │ designLang   │    │ type         │    │ sourceCode       │  │
│  │ seedColor    │    │ props        │    │ isFormatted      │  │
│  │ brightness   │    │ children     │    │ error            │  │
│  └──────────────┘    └──────────────┘    └──────────────────┘  │
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐   │
│  │                  From generative_ui                      │   │
│  │  ChatMessage, LLMResponse, ToolUseBlock, GenTool        │   │
│  └─────────────────────────────────────────────────────────┘   │
│                                                                  │
└─────────────────────────────────────────────────────────────────┘
```

## Entities

### ThemeState (New - gen_ui_client)

Manages the current theme configuration for the application.

```dart
/// lib/domain/entities/theme_state.dart
enum DesignLanguage { glass, brutal, flat, neumorphic, pixel }

class ThemeState extends Equatable {
  final DesignLanguage designLanguage;
  final Color seedColor;
  final Brightness brightness;

  const ThemeState({
    this.designLanguage = DesignLanguage.glass,
    this.seedColor = const Color(0xFF2196F3), // Blue
    this.brightness = Brightness.light,
  });

  ThemeState copyWith({
    DesignLanguage? designLanguage,
    Color? seedColor,
    Brightness? brightness,
  }) => ThemeState(
    designLanguage: designLanguage ?? this.designLanguage,
    seedColor: seedColor ?? this.seedColor,
    brightness: brightness ?? this.brightness,
  );

  @override
  List<Object?> get props => [designLanguage, seedColor, brightness];
}
```

**Validation Rules**:
- seedColor: Any valid Color (ColorScheme.fromSeed handles edge cases)
- brightness: Must be Brightness.light or Brightness.dark
- designLanguage: Must be one of the 5 supported languages

### LayoutNode (New - gen_ui_client)

Represents a node in the AI-generated layout tree.

```dart
/// lib/domain/entities/layout_node.dart
class LayoutNode extends Equatable {
  final String type;
  final Map<String, dynamic> props;
  final List<LayoutNode> children;

  const LayoutNode({
    required this.type,
    this.props = const {},
    this.children = const [],
  });

  factory LayoutNode.fromJson(Map<String, dynamic> json) {
    return LayoutNode(
      type: json['type'] as String,
      props: Map<String, dynamic>.from(json['props'] ?? {}),
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => LayoutNode.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'type': type,
    'props': props,
    if (children.isNotEmpty) 'children': children.map((c) => c.toJson()).toList(),
  };

  @override
  List<Object?> get props => [type, this.props, children];
}
```

**Validation Rules**:
- type: Non-empty string matching a registered component name
- props: Key-value pairs matching component constructor parameters
- children: Only populated for layout components (Column, Row, Card, etc.)

### CodeGenResult (Future Phase - gen_ui_client)

> **Note**: This entity is defined for future code generation feature. Not implemented in Phase 4.

Result of code generation operation.

```dart
/// lib/domain/entities/code_gen_result.dart
class CodeGenResult extends Equatable {
  final String sourceCode;
  final bool isFormatted;
  final String? error;

  const CodeGenResult({
    required this.sourceCode,
    this.isFormatted = true,
    this.error,
  });

  bool get hasError => error != null;

  @override
  List<Object?> get props => [sourceCode, isFormatted, error];
}
```

### Reused from generative_ui

These entities are imported from the generative_ui package:

| Entity | Location | Usage |
|--------|----------|-------|
| ChatMessage | domain/entities/chat_message.dart | Conversation history |
| LLMResponse | domain/entities/llm_response.dart | AI response parsing |
| ToolUseBlock | domain/entities/content_block.dart | Dynamic component data |
| GenTool | domain/entities/gen_tool.dart | Tool definitions |
| ConversationState | domain/entities/conversation_state.dart | Chat view state |

## State Transitions

### ThemeState Transitions

```
┌─────────────┐  updateDesignLanguage()  ┌─────────────┐
│   Glass     │ ──────────────────────▶ │   Brutal    │
└─────────────┘                         └─────────────┘
       │                                       │
       │ updateSeedColor()                     │ updateBrightness()
       ▼                                       ▼
┌─────────────┐                         ┌─────────────┐
│ Glass+Red   │                         │ Brutal+Dark │
└─────────────┘                         └─────────────┘
```

### Layout Generation Flow

```
User Input ──▶ LLM Request ──▶ LLMResponse with ToolUse
                                      │
                                      ▼
                              Parse tool.input
                                      │
                                      ▼
                              LayoutNode.fromJson()
                                      │
                    ┌─────────────────┴─────────────────┐
                    │                                   │
                    ▼                                   ▼
            UiKitComponentRegistry              CodeGenService
            .build(layoutNode)                  .generate(layoutNode)
                    │                                   │
                    ▼                                   ▼
               Widget Tree                      CodeGenResult
```

## Relationships

```
ThemeState ──────────────────────────────────────┐
     │                                           │
     │ determines                                │ provides colors to
     ▼                                           ▼
AppDesignTheme ◀───────────────────────── ColorScheme.fromSeed
     │
     │ applied to
     ▼
UiKitComponentRegistry.build()
     │
     │ renders
     ▼
LayoutNode ──────────────▶ CodeGenService.generate()
     │                              │
     │ contains                     │ produces
     ▼                              ▼
[type, props, children]      CodeGenResult
```

## Data Volume Assumptions

| Entity | Expected Count | Notes |
|--------|----------------|-------|
| ThemeState | 1 | Singleton per app |
| LayoutNode | 1-50 per response | Typical UI has <50 widgets |
| ChatMessage | 10-100 per session | In-memory only |
| Registered Components | 31 | Fixed at build time |

## Indexes/Lookups

| Lookup | Structure | Complexity |
|--------|-----------|------------|
| Component by name | Map<String, ComponentBuilder> | O(1) |
| CodeGen template by name | Map<String, CodeGenTemplate> | O(1) |
| Theme by language | switch on enum | O(1) |
