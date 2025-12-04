import 'package:flutter/material.dart';
import 'package:generative_ui/src/domain/entities/content_block.dart';
import 'package:generative_ui/src/presentation/registry/component_registry.dart';
import 'package:generative_ui/src/presentation/widgets/fallback_card.dart';
import 'package:generative_ui/src/presentation/widgets/message_bubble.dart';

/// Core rendering engine for transforming LLMResponse blocks into Flutter widgets
///
/// DynamicWidgetBuilder handles:
/// 1. **TextBlock rendering** → MessageBubble
/// 2. **ToolUseBlock rendering** → Registry lookup + component instantiation
/// 3. **Error handling** → FallbackCard with error isolation (error boundary pattern)
/// 4. **Type conversion** → JSON props → Dart widget parameters
///
/// Error Boundary:
/// - Each block is rendered in try-catch isolation
/// - Rendering errors return FallbackCard for that block only
/// - Other blocks continue to render normally
/// - Prevents cascade failures when one component crashes
class DynamicWidgetBuilder {
  /// Component registry for ToolUseBlock lookup
  final IComponentRegistry registry;

  const DynamicWidgetBuilder({required this.registry});

  /// Build a widget for a content block
  ///
  /// Parameters:
  /// - [block]: ContentBlock to render (TextBlock or ToolUseBlock)
  /// - [context]: BuildContext for theming and context
  ///
  /// Returns: Flutter widget, or FallbackCard on error
  Widget buildBlock(ContentBlock block, BuildContext context) {
    try {
      if (block is TextBlock) {
        return _buildTextBlock(block, context);
      } else if (block is ToolUseBlock) {
        return _buildToolUseBlock(block, context);
      } else {
        // Unknown block type
        return FallbackCard(
          errorType: FallbackErrorType.renderingError,
          componentName: 'Unknown block type',
          propsData: const {},
          message: 'Block type not recognized: ${block.runtimeType}',
        );
      }
    } catch (e) {
      // Error boundary: catch all exceptions per block
      return FallbackCard(
        errorType: FallbackErrorType.renderingError,
        componentName: block is ToolUseBlock ? (block).name : 'TextBlock',
        propsData: block is ToolUseBlock ? (block).input : {},
        message: 'Rendering error: ${e.toString()}',
      );
    }
  }

  /// Build a TextBlock as a MessageBubble
  Widget _buildTextBlock(TextBlock block, BuildContext context) {
    return MessageBubble(text: block.text);
  }

  /// Build a ToolUseBlock by looking up in registry and instantiating
  Widget _buildToolUseBlock(ToolUseBlock block, BuildContext context) {
    // Look up component builder in registry
    final builder = registry.lookup(block.name);

    if (builder == null) {
      // Component not found in registry
      return FallbackCard(
        errorType: FallbackErrorType.unsupported,
        componentName: block.name,
        propsData: block.input,
        message: 'Component "${block.name}" is not registered',
      );
    }

    // Instantiate component with props
    return builder(context, block.input);
  }

  // --- Type Conversion Helpers ---

  /// Safely extract a String property
  static String safeString(dynamic value, [String defaultValue = '']) {
    if (value == null) return defaultValue;
    return value.toString();
  }

  /// Safely extract an int property
  static int safeInt(dynamic value, [int defaultValue = 0]) {
    if (value == null) return defaultValue;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is String) return int.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  /// Safely extract a double property
  static double safeDouble(dynamic value, [double defaultValue = 0.0]) {
    if (value == null) return defaultValue;
    if (value is double) return value;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? defaultValue;
    return defaultValue;
  }

  /// Safely extract a bool property
  static bool safeBool(dynamic value, [bool defaultValue = false]) {
    if (value == null) return defaultValue;
    if (value is bool) return value;
    if (value is String) {
      final lower = value.toLowerCase();
      return lower == 'true' || lower == '1' || lower == 'yes';
    }
    if (value is num) return value != 0;
    return defaultValue;
  }

  /// Safely extract an Enum property
  static T safeEnum<T extends Enum>(
      dynamic value, List<T> values, T defaultValue) {
    if (value == null) return defaultValue;
    // Assuming value is string name of enum
    final strVal = value.toString().split('.').last.toLowerCase();
    try {
      return values.firstWhere((e) => e.name.toLowerCase() == strVal);
    } catch (_) {
      return defaultValue;
    }
  }
}
