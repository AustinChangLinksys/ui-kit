import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Input area for the chat interface.
///
/// Provides a text field and send button for user message input.
class ChatInputArea extends StatefulWidget {
  /// Callback when user submits a message.
  final ValueChanged<String> onSubmit;

  /// Whether input is disabled (e.g., during loading).
  final bool enabled;

  /// Placeholder text for the input field.
  final String placeholder;

  const ChatInputArea({
    super.key,
    required this.onSubmit,
    this.enabled = true,
    this.placeholder = 'Type a message...',
  });

  @override
  State<ChatInputArea> createState() => _ChatInputAreaState();
}

class _ChatInputAreaState extends State<ChatInputArea> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isEmpty || !widget.enabled) return;

    widget.onSubmit(text);
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppSurface(
      variant: SurfaceVariant.elevated,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                enabled: widget.enabled,
                decoration: InputDecoration(
                  hintText: widget.placeholder,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: theme.colorScheme.surfaceContainerHighest,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                maxLines: null,
                minLines: 1,
                textInputAction: TextInputAction.send,
                onSubmitted: (_) => _handleSubmit(),
              ),
            ),
            const SizedBox(width: 12),
            AppIconButton(
              icon: const Icon(Icons.send),
              onTap: widget.enabled ? _handleSubmit : null,
              variant: SurfaceVariant.highlight,
              size: AppButtonSize.medium,
            ),
          ],
        ),
      ),
    );
  }
}
