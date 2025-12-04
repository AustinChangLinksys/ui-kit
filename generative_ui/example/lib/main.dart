import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:generative_ui/generative_ui.dart';
import 'package:ui_kit_library/ui_kit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  try {
    await dotenv.load(fileName: 'assets/.env');
  } catch (e) {
    debugPrint('Warning: Could not load .env file: $e');
    debugPrint('Using mock generator instead.');
  }

  runApp(const GenUiExampleApp());
}

class GenUiExampleApp extends StatelessWidget {
  const GenUiExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenUI Phase 3 Demo',
      theme: AppTheme.create(brightness: Brightness.light),
      darkTheme: AppTheme.create(brightness: Brightness.dark),
      themeMode: ThemeMode.system,
      builder: (context, child) {
        return GlobalEffectsOverlay(
          child: child ?? const SizedBox.shrink(),
        );
      },
      home: const ChatDemoScreen(),
    );
  }
}

class ChatDemoScreen extends StatefulWidget {
  const ChatDemoScreen({super.key});

  @override
  State<ChatDemoScreen> createState() => _ChatDemoScreenState();
}

class _ChatDemoScreenState extends State<ChatDemoScreen> {
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
    _tools = [
      GenTool(
        name: 'WifiSettingsCard',
        description: 'Display Wi-Fi configuration card with editable fields. '
            'Use this when the user wants to configure or setup WiFi settings.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'ssid': {
              'type': 'string',
              'description': 'The network name (SSID)',
            },
            'security': {
              'type': 'string',
              'description': 'Security type (e.g., WPA2, WPA3, Open)',
            },
            'isEnabled': {
              'type': 'boolean',
              'description': 'Whether WiFi is enabled',
            },
          },
          'required': ['ssid'],
        },
      ),
      GenTool(
        name: 'InfoCard',
        description: 'Display an informational message card. '
            'Use this to show general information, tips, or status messages.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'title': {
              'type': 'string',
              'description': 'The card title',
            },
            'message': {
              'type': 'string',
              'description': 'The informational message to display',
            },
            'icon': {
              'type': 'string',
              'description': 'Optional icon name',
            },
          },
          'required': ['title', 'message'],
        },
      ),
      GenTool(
        name: 'ConfirmationCard',
        description: 'Display a confirmation/status card after an action. '
            'Use this to show success or error status after user completes an action.',
        inputSchema: {
          'type': 'object',
          'properties': {
            'title': {
              'type': 'string',
              'description': 'The confirmation title',
            },
            'message': {
              'type': 'string',
              'description': 'The confirmation message',
            },
            'isSuccess': {
              'type': 'boolean',
              'description': 'Whether this is a success (true) or error (false) confirmation',
            },
          },
          'required': ['title', 'message'],
        },
      ),
    ];
  }

  void _initRegistry() {
    _registry = ComponentRegistry();

    // Register demo components with action support
    _registry.register('WifiSettingsCard', (context, props, {onAction}) {
      return WifiSettingsCard(
        ssid: props['ssid'] as String? ?? 'Unknown',
        security: props['security'] as String? ?? 'Open',
        isEnabled: props['isEnabled'] as bool? ?? false,
        onSave: onAction != null
            ? (data) => onAction({'action': 'save', ...data})
            : null,
        onCancel: onAction != null ? () => onAction({'action': 'cancel'}) : null,
      );
    });

    _registry.register('InfoCard', (context, props, {onAction}) {
      return InfoCard(
        title: props['title'] as String? ?? 'Info',
        message: props['message'] as String? ?? '',
        iconName: props['icon'] as String?,
      );
    });

    _registry.register('ConfirmationCard', (context, props, {onAction}) {
      return ConfirmationCard(
        title: props['title'] as String? ?? 'Status',
        message: props['message'] as String? ?? '',
        isSuccess: props['isSuccess'] as bool? ?? true,
        onDismiss: onAction != null ? () => onAction({'action': 'dismiss'}) : null,
      );
    });
  }

  void _initGenerator() {
    // Debug: print all dotenv values
    debugPrint('=== Dotenv Debug ===');
    debugPrint('isInitialized: ${dotenv.isInitialized}');
    debugPrint('All env keys: ${dotenv.env.keys.toList()}');
    debugPrint('AWS_ACCESS_KEY_ID: "${dotenv.env['AWS_ACCESS_KEY_ID']}" (length: ${dotenv.env['AWS_ACCESS_KEY_ID']?.length ?? 0})');
    debugPrint('AWS_SECRET_ACCESS_KEY: "${dotenv.env['AWS_SECRET_ACCESS_KEY'] != null ? '***hidden***' : 'null'}" (length: ${dotenv.env['AWS_SECRET_ACCESS_KEY']?.length ?? 0})');
    debugPrint('AWS_REGION: "${dotenv.env['AWS_REGION']}"');
    debugPrint('BEDROCK_MODEL_ID: "${dotenv.env['BEDROCK_MODEL_ID']}"');
    debugPrint('====================');

    // Try to create AWS generator, fall back to mock
    try {
      final config = AWSConfig.fromEnvironment();
      debugPrint('AWS config loaded successfully: $config');
      _generator = AwsContentGenerator(config: config);
      _useMock = false;
      debugPrint('Using AwsContentGenerator');
    } on ConfigurationException catch (e, stackTrace) {
      debugPrint('=== AWS Config Failed ===');
      debugPrint('Error: ${e.message}');
      debugPrint('Missing key: ${e.missingKey}');
      debugPrint('StackTrace: $stackTrace');
      debugPrint('Falling back to MockConversationGenerator');
      debugPrint('=========================');
      _generator = MockConversationGenerator();
      _initError = 'AWS credentials not configured. Using mock responses.';
    } catch (e, stackTrace) {
      debugPrint('=== Unexpected Error ===');
      debugPrint('Error: $e');
      debugPrint('StackTrace: $stackTrace');
      debugPrint('========================');
      _generator = MockConversationGenerator();
      _initError = 'Unexpected error: $e';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GenUI Chat Demo'),
        actions: [
          // Toggle indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
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
              systemPrompt: _systemPrompt,
              welcomeTitle: 'GenUI Demo',
              welcomeMessage:
                  'Try asking:\n• "Setup WiFi"\n• "Show network info"\n• "Configure guest network"',
            ),
          ),
        ],
      ),
    );
  }

  static const String _systemPrompt = '''
You are a helpful network configuration assistant. You can help users configure their network settings.

Available tools:
- WifiSettingsCard: Display Wi-Fi configuration with editable fields (ssid, security, isEnabled)
- InfoCard: Display informational messages (title, message, icon)
- ConfirmationCard: Show success/error status after actions (title, message, isSuccess)

When a user asks about WiFi or network setup, use WifiSettingsCard.
When showing general information, use InfoCard.
After a user completes an action (like saving settings), respond with a ConfirmationCard.

Be conversational and helpful. Use the tools when appropriate to provide interactive UI.
''';
}

/// Mock conversation generator for demo without AWS credentials.
///
/// Simulates AI responses with tool use to demonstrate the closed-loop
/// interaction pattern.
class MockConversationGenerator implements IConversationGenerator {
  @override
  Future<LLMResponse> generateWithHistory(
    List<ChatMessage> messages, {
    List<GenTool>? tools,
    String? systemPrompt,
  }) async {
    // Simulate network latency
    await Future.delayed(const Duration(milliseconds: 800));

    // Get the last user message
    final lastUserMessage = messages.lastWhere(
      (m) => m.role == ChatRole.user && !m.isToolResult,
      orElse: () => ChatMessage.user(''),
    );

    // Check if this is a tool result response
    final lastToolResult = messages.lastOrNull;
    if (lastToolResult != null && lastToolResult.isToolResult) {
      return _createConfirmationResponse();
    }

    // Route based on keywords
    final input = lastUserMessage.displayText.toLowerCase();

    if (input.contains('wifi') ||
        input.contains('setup') ||
        input.contains('network') ||
        input.contains('guest')) {
      return _createWifiSettingsResponse();
    } else if (input.contains('info') || input.contains('status')) {
      return _createInfoResponse(lastUserMessage.displayText);
    } else {
      return _createTextResponse(lastUserMessage.displayText);
    }
  }

  LLMResponse _createWifiSettingsResponse() {
    return LLMResponse.fromMap({
      'id': 'msg_wifi_${DateTime.now().millisecondsSinceEpoch}',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'text',
          'text':
              "I'll help you configure your Wi-Fi settings. Please review and modify the settings below:",
        },
        {
          'type': 'tool_use',
          'id': 'tool_wifi_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'WifiSettingsCard',
          'input': {
            'ssid': 'MyNetwork',
            'security': 'WPA2',
            'isEnabled': true,
          },
        },
      ],
      'stop_reason': 'tool_use',
    });
  }

  LLMResponse _createInfoResponse(String query) {
    return LLMResponse.fromMap({
      'id': 'msg_info_${DateTime.now().millisecondsSinceEpoch}',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'tool_use',
          'id': 'tool_info_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'InfoCard',
          'input': {
            'title': 'Network Status',
            'message':
                'Your network is currently active and functioning normally. Connected devices: 5.',
            'icon': 'network_check',
          },
        },
      ],
      'stop_reason': 'tool_use',
    });
  }

  LLMResponse _createTextResponse(String query) {
    return LLMResponse.fromMap({
      'id': 'msg_text_${DateTime.now().millisecondsSinceEpoch}',
      'model': 'claude-3-mock',
      'content': [
        {
          'type': 'text',
          'text':
              "I'm your network configuration assistant. I can help you with:\n\n"
                  "• **WiFi Setup** - Configure your wireless network\n"
                  "• **Network Info** - View current network status\n"
                  "• **Guest Network** - Set up a separate network for guests\n\n"
                  "What would you like to do?",
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
          'type': 'tool_use',
          'id': 'tool_confirm_${DateTime.now().millisecondsSinceEpoch}',
          'name': 'ConfirmationCard',
          'input': {
            'title': 'Settings Saved',
            'message':
                'Your network settings have been updated successfully. The changes will take effect immediately.',
            'isSuccess': true,
          },
        },
      ],
      'stop_reason': 'tool_use',
    });
  }
}
