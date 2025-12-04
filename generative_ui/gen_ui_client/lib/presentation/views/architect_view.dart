import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:generative_ui/generative_ui.dart';

import '../../domain/entities/design_language.dart';
import '../../domain/entities/theme_state.dart';
import '../../main.dart';
import '../providers/theme_provider.dart';
import '../registry/ui_kit_component_registry.dart';

/// Main view for the Layout Architect application.
///
/// Displays the GenUI chat interface with theme controls in the app bar.
class ArchitectView extends ConsumerStatefulWidget {
  const ArchitectView({super.key});

  @override
  ConsumerState<ArchitectView> createState() => _ArchitectViewState();
}

/// Named color entry for seed color picker.
class _ColorEntry {
  final String name;
  final Color color;
  const _ColorEntry(this.name, this.color);
}

/// Available seed colors for theme customization.
const _seedColors = [
  _ColorEntry('Blue', Color(0xFF2196F3)),
  _ColorEntry('Purple', Color(0xFF9C27B0)),
  _ColorEntry('Pink', Color(0xFFE91E63)),
  _ColorEntry('Red', Color(0xFFF44336)),
  _ColorEntry('Orange', Color(0xFFFF9800)),
  _ColorEntry('Amber', Color(0xFFFFC107)),
  _ColorEntry('Green', Color(0xFF4CAF50)),
  _ColorEntry('Teal', Color(0xFF009688)),
  _ColorEntry('Cyan', Color(0xFF00BCD4)),
  _ColorEntry('Indigo', Color(0xFF3F51B5)),
];

class _ArchitectViewState extends ConsumerState<ArchitectView> {
  late final ComponentRegistry _registry;
  late final IConversationGenerator _generator;
  late final List<GenTool> _tools;
  bool _useMock = true;
  String? _initError;

  @override
  void initState() {
    super.initState();
    _initTools();
    _initRegistry();
    _initGenerator();
  }

  void _initTools() {
    _tools = UiKitComponentRegistry.createToolDefinitions();
  }

  void _initRegistry() {
    _registry = ComponentRegistry();
    UiKitComponentRegistry.registerAll(_registry);
  }

  void _initGenerator() {
    // Try to create AWS generator, fall back to mock
    try {
      final config = AWSConfig.fromEnvironment();
      debugPrint('AWS config loaded successfully: $config');
      _generator = AwsContentGenerator(config: config);
      _useMock = false;
      debugPrint('Using AwsContentGenerator');
    } on ConfigurationException catch (e) {
      debugPrint('AWS Config Failed: ${e.message}');
      debugPrint('Falling back to MockConversationGenerator');
      _generator = MockConversationGenerator();
      _initError = 'AWS credentials not configured. Using mock responses.';
    } catch (e) {
      debugPrint('Unexpected Error: $e');
      _generator = MockConversationGenerator();
      _initError = 'Unexpected error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeControllerProvider);
    final themeController = ref.read(themeControllerProvider.notifier);
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Architect'),
        actions: [
          // Seed color picker
          PopupMenuButton<Color>(
            icon: Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: themeState.seedColor,
                shape: BoxShape.circle,
                border: Border.all(
                  color: colorScheme.outline,
                  width: 2,
                ),
              ),
            ),
            tooltip: 'Seed Color',
            onSelected: themeController.setSeedColor,
            itemBuilder: (context) => _seedColors
                .map(
                  (colorEntry) => PopupMenuItem(
                    value: colorEntry.color,
                    child: Row(
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: colorEntry.color,
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: themeState.seedColor == colorEntry.color
                                  ? colorScheme.primary
                                  : Colors.transparent,
                              width: 2,
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          colorEntry.name,
                          style: TextStyle(
                            fontWeight: themeState.seedColor == colorEntry.color
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),

          // Design language dropdown
          PopupMenuButton<DesignLanguage>(
            icon: Icon(themeState.designLanguage.icon),
            tooltip: 'Design Language',
            onSelected: themeController.setDesignLanguage,
            itemBuilder: (context) => DesignLanguage.values
                .map(
                  (lang) => PopupMenuItem(
                    value: lang,
                    child: Row(
                      children: [
                        Icon(
                          lang.icon,
                          color: themeState.designLanguage == lang
                              ? colorScheme.primary
                              : null,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          lang.displayName,
                          style: TextStyle(
                            fontWeight: themeState.designLanguage == lang
                                ? FontWeight.bold
                                : null,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList(),
          ),

          // Brightness toggle
          IconButton(
            icon: Icon(
              themeState.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
            tooltip: themeState.isDarkMode ? 'Light Mode' : 'Dark Mode',
            onPressed: themeController.toggleBrightness,
          ),

          // Mode indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Center(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _useMock
                      ? Colors.orange.withValues(alpha: 0.2)
                      : Colors.green.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Text(
                  _useMock ? 'Mock Mode' : 'AWS Bedrock',
                  style: TextStyle(
                    color: _useMock ? Colors.orange : Colors.green,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // Show warning banner if using mock
          if (_initError != null)
            MaterialBanner(
              content: Text(_initError!),
              leading: const Icon(Icons.info_outline, color: Colors.orange),
              backgroundColor: Colors.orange.withValues(alpha: 0.1),
              actions: [
                TextButton(
                  onPressed: () => setState(() => _initError = null),
                  child: const Text('DISMISS'),
                ),
              ],
            ),
          // Main chat view
          Expanded(
            child: GenUiChatView(
              registry: _registry,
              generator: _generator,
              tools: _tools,
              systemPrompt: _buildSystemPrompt(themeState),
              welcomeTitle: 'Layout Architect',
              welcomeMessage:
                  'I can help you design UI layouts using the UI Kit components.\n\n'
                  'Try asking:\n'
                  '• "Create a login form"\n'
                  '• "Design a settings page"\n'
                  '• "Build a product card"',
            ),
          ),
        ],
      ),
    );
  }

  /// Builds a dynamic system prompt that includes current theme state.
  String _buildSystemPrompt(ThemeState themeState) {
    final seedColorHex =
        '#${themeState.seedColor.toARGB32().toRadixString(16).substring(2).toUpperCase()}';

    return '''
You are a Layout Architect - an AI assistant that designs UI layouts using UI Kit components.

**CRITICAL INSTRUCTION:**
- You MUST use tools to render UI components. NEVER just describe what you will create.
- When asked to design/create/build anything, IMMEDIATELY use the appropriate tool (Column, Row, AppCard, etc.) to render it.
- Do NOT say "I will create..." or "Here's a design..." without actually using a tool.
- Every design request MUST result in a tool_use, not just text.

**Current Theme Context:**
- Design Language: ${themeState.designLanguage.displayName}
- Color Scheme: $seedColorHex (seed color)
- Mode: ${themeState.isDarkMode ? 'Dark' : 'Light'}

The components will automatically render in ${themeState.designLanguage.displayName} style. Design your layouts knowing that:
${_getDesignLanguageGuidance(themeState.designLanguage)}

**Available Components (31 UI Kit + 9 Layout Containers):**

**Atoms (Basic building blocks):**
- AppSurface: Container with theme-aware background, borders, and shadows
- AppText: Theme-aware text with typography variants (displayLarge, headlineMedium, titleMedium, bodyMedium, bodySmall, labelMedium)
- AppIcon: Icon display component
- AppGap: Spacing component (size: xs, sm, md, lg, xl)
- AppDivider: Horizontal or vertical divider line
- AppSkeleton: Loading placeholder component

**Molecules - Buttons:**
- AppButton: Action button with label, icon, and variants (base, elevated, highlight)
- AppIconButton: Icon-only button

**Molecules - Inputs:**
- AppTextField: Single-line text input with hintText, obscureText
- AppTextFormField: Form-integrated text field with validation
- AppDropdown: Dropdown selection menu
- AppSlider: Range slider for numeric values

**Molecules - Selection:**
- AppCheckbox: Checkbox with label
- AppRadio: Radio button with label

**Molecules - Toggles:**
- AppSwitch: Toggle switch

**Molecules - Status:**
- AppBadge: Notification badge
- AppTag: Label tag for categorization
- AppAvatar: User avatar display

**Molecules - Feedback:**
- AppLoader: Loading indicator
- AppToast: Toast notification

**Molecules - Display:**
- AppTooltip: Hover/tap tooltip

**Molecules - Layout:**
- AppListTile: List item with leading icon, title, subtitle, trailing widget
- AppCard: Card container for grouping related content

**Molecules - Navigation:**
- AppNavigationBar: Bottom navigation bar
- AppNavigationRail: Side navigation rail

**Layout Containers:**
- Column: Vertical layout (mainAxisAlignment, crossAxisAlignment). Use AppGap for spacing.
- Row: Horizontal layout (mainAxisAlignment, crossAxisAlignment, expandChildren)
- Wrap: Wrapping flow layout
- Stack: Layered positioning
- Center: Center alignment
- Padding: Add padding around child
- SizedBox: Fixed size container
- Expanded: Expand to fill available space (use inside Row only)
- Flexible: Flexible sizing in layouts

**Layout Tips:**
- Use expandChildren: true on Row to make children fill equal width
- Do NOT use expandChildren on Column (causes layout errors in scroll contexts)
- Use AppGap between elements for consistent spacing
- Combine AppCard with Column/Row for structured layouts
- AppListTile works great for settings and list items

**REMINDER: Always use tools to render UI. Do not describe - just build it directly using the tools above.**
''';
  }

  /// Returns design language specific guidance for the AI.
  String _getDesignLanguageGuidance(DesignLanguage language) {
    switch (language) {
      case DesignLanguage.glass:
        return '- Glass style uses blur effects and transparency\n- Prefer subtle, elegant layouts\n- Works well with layered content';
      case DesignLanguage.brutal:
        return '- Brutal style uses bold borders and raw aesthetics\n- Embrace asymmetry and strong contrasts\n- Works well with chunky, impactful elements';
      case DesignLanguage.flat:
        return '- Flat style is clean and minimal\n- Use solid colors and clear hierarchy\n- Focus on simplicity and clarity';
      case DesignLanguage.neumorphic:
        return '- Neumorphic style uses soft shadows for depth\n- Keep layouts subtle and soft\n- Elements appear to extrude from the surface';
      case DesignLanguage.pixel:
        return '- Pixel style is retro and blocky\n- Use grid-aligned layouts\n- Embrace the nostalgic, game-like aesthetic';
    }
  }
}

/// Mock conversation generator for demo without AWS credentials.
class MockConversationGenerator implements IConversationGenerator {
  @override
  Future<LLMResponse> generateWithHistory(
    List<ChatMessage> messages, {
    List<GenTool>? tools,
    String? systemPrompt,
    bool forceToolUse = false,
  }) async {
    await Future.delayed(const Duration(milliseconds: 800));

    final lastUserMessage = messages.lastWhere(
      (m) => m.role == ChatRole.user && !m.isToolResult,
      orElse: () => ChatMessage.user(''),
    );

    final lastToolResult = messages.lastOrNull;
    if (lastToolResult != null && lastToolResult.isToolResult) {
      return _createConfirmationResponse();
    }

    final input = lastUserMessage.displayText.toLowerCase();

    if (input.contains('login') || input.contains('form')) {
      return _createLoginFormResponse();
    } else if (input.contains('card') || input.contains('product')) {
      return _createProductCardResponse();
    } else if (input.contains('settings') || input.contains('config')) {
      return _createSettingsResponse();
    } else {
      return _createTextResponse();
    }
  }

  LLMResponse _createLoginFormResponse() {
    return LLMResponse.fromMap({
      'id': 'msg_login_${DateTime.now().millisecondsSinceEpoch}',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'text',
          'text': "Here's a login form design using UI Kit components:",
        },
        {
          'type': 'tool_use',
          'id': 'tool_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'Column',
          'input': {
            'mainAxisAlignment': 'center',
            'crossAxisAlignment': 'stretch',
            'children': [
              {
                'type': 'AppText',
                'props': {'text': 'Welcome Back', 'variant': 'headlineMedium'},
              },
              {'type': 'AppGap', 'props': {'size': 24}},
              {
                'type': 'AppTextField',
                'props': {
                  'label': 'Email',
                  'hint': 'Enter your email',
                  'prefixIcon': 'email',
                },
              },
              {'type': 'AppGap', 'props': {'size': 16}},
              {
                'type': 'AppTextField',
                'props': {
                  'label': 'Password',
                  'hint': 'Enter your password',
                  'prefixIcon': 'lock',
                  'obscureText': true,
                },
              },
              {'type': 'AppGap', 'props': {'size': 24}},
              {
                'type': 'AppButton',
                'props': {'label': 'Sign In', 'variant': 'highlight'},
              },
            ],
          },
        },
      ],
      'stop_reason': 'tool_use',
    });
  }

  LLMResponse _createProductCardResponse() {
    return LLMResponse.fromMap({
      'id': 'msg_card_${DateTime.now().millisecondsSinceEpoch}',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'text',
          'text': "Here's a product card design:",
        },
        {
          'type': 'tool_use',
          'id': 'tool_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'AppCard',
          'input': {
            'title': 'Product Name',
            'subtitle': '\$99.99',
            'children': [
              {
                'type': 'Column',
                'props': {
                  'children': [
                    {
                      'type': 'AppText',
                      'props': {
                        'text': 'A great product description goes here.',
                        'variant': 'bodyMedium',
                      },
                    },
                    {'type': 'AppGap', 'props': {'size': 16}},
                    {
                      'type': 'Row',
                      'props': {
                        'mainAxisAlignment': 'spaceBetween',
                        'children': [
                          {
                            'type': 'AppTag',
                            'props': {'label': 'In Stock'},
                          },
                          {
                            'type': 'AppButton',
                            'props': {
                              'label': 'Add to Cart',
                              'variant': 'highlight',
                            },
                          },
                        ],
                      },
                    },
                  ],
                },
              },
            ],
          },
        },
      ],
      'stop_reason': 'tool_use',
    });
  }

  LLMResponse _createSettingsResponse() {
    return LLMResponse.fromMap({
      'id': 'msg_settings_${DateTime.now().millisecondsSinceEpoch}',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'text',
          'text': "Here's a settings page layout:",
        },
        {
          'type': 'tool_use',
          'id': 'tool_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'Column',
          'input': {
            'crossAxisAlignment': 'stretch',
            'children': [
              {
                'type': 'AppListTile',
                'props': {
                  'title': 'Dark Mode',
                  'subtitle': 'Enable dark theme',
                  'leading': 'dark_mode',
                  'trailing': 'switch',
                },
              },
              {'type': 'AppDivider', 'props': {}},
              {
                'type': 'AppListTile',
                'props': {
                  'title': 'Notifications',
                  'subtitle': 'Receive push notifications',
                  'leading': 'notifications',
                  'trailing': 'switch',
                },
              },
              {'type': 'AppDivider', 'props': {}},
              {
                'type': 'AppListTile',
                'props': {
                  'title': 'Language',
                  'subtitle': 'English',
                  'leading': 'language',
                  'trailing': 'chevron_right',
                },
              },
            ],
          },
        },
      ],
      'stop_reason': 'tool_use',
    });
  }

  LLMResponse _createTextResponse() {
    return LLMResponse.fromMap({
      'id': 'msg_text_${DateTime.now().millisecondsSinceEpoch}',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'text',
          'text':
              "I'm your Layout Architect assistant. I can help you design UI layouts using UI Kit components.\n\n"
                  "Try asking me to:\n"
                  "• **Create a login form** - User authentication UI\n"
                  "• **Design a product card** - E-commerce style cards\n"
                  "• **Build a settings page** - App configuration UI\n\n"
                  "What would you like me to design?",
        },
      ],
      'stop_reason': 'end_turn',
    });
  }

  LLMResponse _createConfirmationResponse() {
    return LLMResponse.fromMap({
      'id': 'msg_confirm_${DateTime.now().millisecondsSinceEpoch}',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'text',
          'text':
              "Great! The component has been updated. Would you like me to make any changes to the design?",
        },
      ],
      'stop_reason': 'end_turn',
    });
  }
}
