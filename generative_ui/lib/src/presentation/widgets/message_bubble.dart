import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Widget for rendering TextBlock content as a chat bubble
///
/// MessageBubble displays text content in a chat-like style:
/// - Left-aligned with soft background styling
/// - Uses UI Kit AppSurface for visual consistency
/// - Supports multiple lines and text wrapping
/// - Styled per active design theme
///
/// Typically rendered by DynamicWidgetBuilder when processing TextBlock objects
/// from Phase 1's LLMResponse.
class MessageBubble extends StatelessWidget {
  /// Text content to display in the bubble
  final String text;

  /// Whether this is a user message (affects styling)
  /// Defaults to false (GenUI response)
  final bool isUserMessage;

  const MessageBubble({
    required this.text,
    this.isUserMessage = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return Align(
      alignment: isUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: AppSurface(
        style: isUserMessage ? theme.surfaceHighlight : theme.surfaceSecondary,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.8,
          ),
          // Note: AppSurface applies background color/border via its internal decoration based on style.
          // If we need overrides, we might do it here, but sticking to SurfaceStyle is better.
          // However, the original code had specific opacity logic.
          // We will trust the SurfaceStyle for now or apply a subtle overlay if needed.
          // For now, I'll stick to the original logic but using correct context.
          decoration: BoxDecoration(
            color: isUserMessage
                ? colorScheme.primary.withValues(alpha: 0.1)
                : colorScheme.surfaceContainer.withValues(alpha: 0.5),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isUserMessage
                  ? colorScheme.primary.withValues(alpha: 0.2)
                  : colorScheme.outlineVariant.withValues(alpha: 0.3),
              width: 1,
            ),
          ),
          child: AppText.bodyMedium(
            text,
            color: colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
