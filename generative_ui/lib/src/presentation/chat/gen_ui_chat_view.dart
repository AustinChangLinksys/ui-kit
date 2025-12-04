import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

import '../../domain/entities/chat_message.dart';
import '../../domain/entities/content_block.dart';
import '../../domain/entities/conversation_state.dart';
import '../../domain/entities/gen_tool.dart';
import '../../domain/entities/tool_action_output.dart';
import '../../domain/repositories/i_conversation_generator.dart';
import '../registry/component_registry.dart';
import '../widgets/dynamic_builder.dart';
import '../widgets/loading_indicator.dart';
import 'chat_controller.dart';
import 'chat_input_area.dart';

/// Main chat view widget for GenUI.
///
/// Integrates ChatController, message list, and input area to provide
/// a complete chat experience with dynamic UI component rendering.
class GenUiChatView extends StatefulWidget {
  /// Component registry for dynamic widget resolution.
  final IComponentRegistry registry;

  /// Content generator for AI communication.
  final IConversationGenerator generator;

  /// Optional system prompt for the AI.
  final String? systemPrompt;

  /// Optional tool definitions for the AI.
  final List<dynamic>? tools;

  /// Welcome message shown when no conversation has started.
  final String welcomeMessage;

  /// Welcome title shown in the welcome screen.
  final String welcomeTitle;

  const GenUiChatView({
    super.key,
    required this.registry,
    required this.generator,
    this.systemPrompt,
    this.tools,
    this.welcomeMessage = 'Start a conversation by typing a message below.',
    this.welcomeTitle = 'Welcome',
  });

  @override
  State<GenUiChatView> createState() => _GenUiChatViewState();
}

class _GenUiChatViewState extends State<GenUiChatView> {
  late final ChatController _controller;
  late final DynamicWidgetBuilder _builder;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller = ChatController(
      generator: widget.generator,
      systemPrompt: widget.systemPrompt,
      tools: widget.tools?.cast<GenTool>(),
    );
    _builder = DynamicWidgetBuilder(registry: widget.registry);
    _controller.addListener(_onStateChanged);
  }

  @override
  void dispose() {
    _controller.removeListener(_onStateChanged);
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onStateChanged() {
    setState(() {});
    // Scroll to bottom when new messages arrive
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _handleToolAction(String toolUseId, Map<String, dynamic> data) {
    final lastMessage = _controller.state.lastMessage;
    String componentName = 'Unknown';

    // Try to find the component name from the last assistant message
    if (lastMessage?.response != null) {
      final toolUse = lastMessage!.response!.content
          .whereType<ToolUseBlock>()
          .where((t) => t.id == toolUseId)
          .firstOrNull;
      if (toolUse != null) {
        componentName = toolUse.name;
      }
    }

    final action = ToolActionOutput(
      toolUseId: toolUseId,
      componentName: componentName,
      actionType: data['action'] as String? ?? 'unknown',
      data: Map<String, dynamic>.from(data)..remove('action'),
    );

    _controller.handleToolAction(action);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: _buildContent(),
        ),
        ChatInputArea(
          onSubmit: _controller.sendMessage,
          enabled: !_controller.isLoading,
        ),
      ],
    );
  }

  Widget _buildContent() {
    switch (_controller.viewState) {
      case ChatViewState.welcome:
        return _buildWelcomeState();
      case ChatViewState.loading:
        return _buildMessageListWithLoading();
      case ChatViewState.content:
        return _buildMessageList();
      case ChatViewState.error:
        return _buildErrorState();
    }
  }

  /// Welcome state UI - initial screen before conversation starts.
  Widget _buildWelcomeState() {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 64,
              color: theme.colorScheme.primary.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 16),
            AppText.headline(widget.welcomeTitle),
            const SizedBox(height: 8),
            AppText.body(
              widget.welcomeMessage,
              textAlign: TextAlign.center,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ],
        ),
      ),
    );
  }

  /// Loading state UI - message list with loading indicator at bottom.
  Widget _buildMessageListWithLoading() {
    return Column(
      children: [
        Expanded(child: _buildMessageList()),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: LoadingIndicator(),
        ),
      ],
    );
  }

  /// Content state UI - message list with mixed text bubbles and dynamic components.
  Widget _buildMessageList() {
    final messages = _controller.messages
        .where((m) => m.role != ChatRole.system)
        .toList();

    if (messages.isEmpty) {
      return _buildWelcomeState();
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        return _buildMessageItem(messages[index]);
      },
    );
  }

  /// Build a single message item.
  Widget _buildMessageItem(ChatMessage message) {
    final theme = Theme.of(context);
    const spacing = 12.0;

    if (message.isUser) {
      // User message - simple text bubble on the right
      return Padding(
        padding: const EdgeInsets.only(bottom: spacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(flex: 1),
            Flexible(
              flex: 3,
              child: AppSurface(
                variant: SurfaceVariant.highlight,
                child: Padding(
                  padding: const EdgeInsets.all(spacing),
                  child: AppText.body(message.displayText),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (message.isAssistant && message.response != null) {
      // Assistant message - render each content block
      return Padding(
        padding: const EdgeInsets.only(bottom: spacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: message.response!.content.map((block) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: spacing / 2),
                    child: _builder.buildBlock(
                      block,
                      context,
                      onAction: _handleToolAction,
                    ),
                  );
                }).toList(),
              ),
            ),
            const Spacer(flex: 1),
          ],
        ),
      );
    } else if (message.isToolResult) {
      // Tool result - subtle indicator
      return Padding(
        padding: const EdgeInsets.only(bottom: spacing),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(flex: 1),
            Flexible(
              flex: 3,
              child: AppSurface(
                variant: SurfaceVariant.base,
                child: Padding(
                  padding: const EdgeInsets.all(spacing / 2),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: spacing / 2),
                      AppText.caption(
                        'Action completed',
                        color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }

  /// Error state UI - error message with retry button.
  Widget _buildErrorState() {
    final theme = Theme.of(context);
    const spacing = 12.0;

    return Column(
      children: [
        if (_controller.messages.length > 1) Expanded(child: _buildMessageList()),
        if (_controller.messages.length <= 1) const Spacer(),
        Padding(
          padding: const EdgeInsets.all(spacing * 2),
          child: AppSurface(
            variant: SurfaceVariant.elevated,
            child: Padding(
              padding: const EdgeInsets.all(spacing),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: spacing),
                  AppText.body(
                    _controller.errorMessage ?? 'An error occurred',
                    textAlign: TextAlign.center,
                    color: theme.colorScheme.error,
                  ),
                  if (_controller.isRetryable) ...[
                    const SizedBox(height: spacing),
                    AppButton(
                      label: 'Retry',
                      onTap: _controller.retry,
                      variant: SurfaceVariant.highlight,
                    ),
                  ],
                  if (!_controller.isRetryable) ...[
                    const SizedBox(height: spacing / 2),
                    AppText.caption(
                      'Please check your configuration and try again.',
                      textAlign: TextAlign.center,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
        if (_controller.messages.length <= 1) const Spacer(),
      ],
    );
  }
}
