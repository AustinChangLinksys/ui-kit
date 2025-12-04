# Quickstart Guide: GenUI Phase 3

**Feature**: 012-genui-phase3-aws-client
**Date**: 2025-12-04

## Prerequisites

1. **Phase 1 & 2 Complete**: GenUI orchestrator and rendering engine functional
2. **AWS Account**: With Bedrock access enabled
3. **IAM Credentials**: Access key with `bedrock:InvokeModel` permission
4. **Model Access**: Claude model enabled in AWS Bedrock console

## Setup

### 1. Install Dependencies

Update `generative_ui/pubspec.yaml`:

```yaml
dependencies:
  flutter:
    sdk: flutter
  ui_kit_library:
    path: ../

  # AWS Connectivity
  aws_common: ^0.7.11
  aws_signature_v4: ^0.6.9
  http: ^1.2.1

  # Configuration
  flutter_dotenv: ^5.1.0
```

Run:
```bash
cd generative_ui
flutter pub get
```

### 2. Configure Credentials

Create `generative_ui/assets/.env`:

```ini
AWS_ACCESS_KEY_ID=AKIA...your-access-key...
AWS_SECRET_ACCESS_KEY=...your-secret-key...
AWS_REGION=us-east-1
BEDROCK_MODEL_ID=anthropic.claude-3-5-sonnet-20241022-v2:0
```

**Security**: Ensure `.env` is in `.gitignore`:

```bash
echo "assets/.env" >> generative_ui/.gitignore
```

### 3. Register Assets

Update `generative_ui/pubspec.yaml` flutter section:

```yaml
flutter:
  uses-material-design: true
  assets:
    - assets/ai_config.json
    - assets/.env
```

### 4. Initialize in App

```dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: 'assets/.env');

  runApp(const MyApp());
}
```

## Basic Usage

### Integrate GenUiChatView

```dart
import 'package:generative_ui/generative_ui.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Create component registry
    final registry = ComponentRegistry();

    // Register your UI components
    registry.register('WifiSettingsCard', (context, props, {onAction}) {
      return WifiSettingsCard(
        ssid: props['ssid'] as String? ?? '',
        security: props['security'] as String? ?? 'Open',
        isEnabled: props['isEnabled'] as bool? ?? false,
        onSave: onAction != null
            ? (data) => onAction({'action': 'save', ...data})
            : null,
        onCancel: onAction != null
            ? () => onAction({'action': 'cancel'})
            : null,
      );
    });

    registry.register('InfoCard', (context, props, {onAction}) {
      return InfoCard(
        title: props['title'] as String? ?? 'Info',
        message: props['message'] as String? ?? '',
        type: props['type'] as String? ?? 'info',
      );
    });

    return GenUiChatView(
      registry: registry,
      systemPrompt: 'You are a helpful network configuration assistant.',
    );
  }
}
```

### Custom Generator Configuration

```dart
// For advanced usage, create generator directly
final generator = AwsContentGenerator(
  config: AWSConfig.fromEnvironment(),
);

// Or with mock for testing
final mockGenerator = MockContentGenerator();
```

## Component Integration

### Implementing onAction Callback

Components that support user actions must call `onAction`:

```dart
class WifiSettingsCard extends StatefulWidget {
  final String ssid;
  final String security;
  final bool isEnabled;
  final void Function(Map<String, dynamic>)? onSave;
  final VoidCallback? onCancel;

  // ...

  @override
  Widget build(BuildContext context) {
    return AppSurface(
      variant: SurfaceVariant.elevated,
      child: Column(
        children: [
          // Form fields...

          Row(
            children: [
              AppButton(
                label: 'Cancel',
                onPressed: widget.onCancel,
              ),
              AppButton(
                label: 'Save',
                variant: ButtonVariant.primary,
                onPressed: () {
                  widget.onSave?.call({
                    'ssid': _ssidController.text,
                    'security': _selectedSecurity,
                    'isEnabled': _isEnabled,
                    'password': _passwordController.text,
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
```

### Registry Builder Signature

```dart
typedef GenUiWidgetBuilder = Widget Function(
  BuildContext context,
  Map<String, dynamic> props, {
  void Function(Map<String, dynamic>)? onAction,
});
```

## Testing

### With Mock Generator

```dart
void main() {
  testWidgets('Chat flow with mock', (tester) async {
    final registry = ComponentRegistry();
    // Register test components...

    await tester.pumpWidget(
      MaterialApp(
        home: GenUiChatView(
          registry: registry,
          generator: MockContentGenerator(), // Use mock
        ),
      ),
    );

    // Enter message
    await tester.enterText(find.byType(TextField), 'Setup WiFi');
    await tester.tap(find.byType(IconButton)); // Send button
    await tester.pumpAndSettle();

    // Verify component rendered
    expect(find.byType(WifiSettingsCard), findsOneWidget);
  });
}
```

### Integration Test with Real AWS

```dart
// Only run with real credentials
@Tags(['integration'])
void main() {
  test('E2E with AWS Bedrock', () async {
    await dotenv.load(fileName: 'assets/.env');

    final generator = AwsContentGenerator(
      config: AWSConfig.fromEnvironment(),
    );

    final response = await generator.generateWithHistory([
      ChatMessage.user('What can you help me with?'),
    ], tools: [/* tool definitions */]);

    expect(response.content, isNotEmpty);
  });
}
```

## Troubleshooting

### Common Errors

| Error | Cause | Solution |
|-------|-------|----------|
| `ConfigurationException: AWS_ACCESS_KEY_ID not set` | Missing .env file | Create .env with credentials |
| `403 AccessDeniedException` | IAM permissions | Add `bedrock:InvokeModel` to IAM policy |
| `403 Access denied: Model not available` | Model not enabled | Enable model in Bedrock console |
| `429 ThrottlingException` | Rate limit hit | Add retry with backoff |
| `Network connection failed` | No internet | Check connectivity |

### IAM Policy Example

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "bedrock:InvokeModel"
      ],
      "Resource": [
        "arn:aws:bedrock:*::foundation-model/anthropic.claude-*"
      ]
    }
  ]
}
```

### Debug Logging

```dart
// Enable verbose logging
final generator = AwsContentGenerator(
  config: AWSConfig.fromEnvironment(),
  enableLogging: true, // Logs request/response (sanitized)
);
```

## Architecture Overview

```
┌─────────────────────────────────────────────────────────┐
│                     GenUiChatView                       │
│  ┌─────────────────────────────────────────────────┐   │
│  │              ChatController                      │   │
│  │  - ConversationState                            │   │
│  │  - Message history                              │   │
│  │  - Tool action handling                         │   │
│  └─────────────────────────────────────────────────┘   │
│                          │                              │
│                          ▼                              │
│  ┌─────────────────────────────────────────────────┐   │
│  │           IConversationGenerator                │   │
│  │  ├─ AwsContentGenerator (production)            │   │
│  │  └─ MockContentGenerator (testing)              │   │
│  └─────────────────────────────────────────────────┘   │
│                          │                              │
│                          ▼                              │
│  ┌─────────────────────────────────────────────────┐   │
│  │           DynamicWidgetBuilder                  │   │
│  │  - TextBlock → MessageBubble                    │   │
│  │  - ToolUseBlock → Registry.lookup() → Widget    │   │
│  └─────────────────────────────────────────────────┘   │
│                          │                              │
│                          ▼                              │
│  ┌─────────────────────────────────────────────────┐   │
│  │           ComponentRegistry                     │   │
│  │  - WifiSettingsCard                             │   │
│  │  - InfoCard                                     │   │
│  │  - ErrorCard                                    │   │
│  │  - (custom components)                          │   │
│  └─────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

## Next Steps

1. **Run E2E Demo**: Follow flow in spec SC-001
2. **Add More Components**: Extend registry with domain-specific cards
3. **Customize Prompts**: Tune system prompt for your use case
4. **Monitor Usage**: Track token usage from response.usage
