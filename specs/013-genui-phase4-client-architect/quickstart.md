# Quickstart: GenUI Phase 4 - gen_ui_client

**Date**: 2025-12-04

## Prerequisites

1. Flutter SDK 3.x installed
2. AWS Bedrock access with Claude model enabled
3. UI Kit library cloned and dependencies resolved

## Setup

### 1. Navigate to gen_ui_client

```bash
cd generative_ui/gen_ui_client
```

### 2. Install Dependencies

```bash
flutter pub get
```

### 3. Configure AWS Credentials

Create `assets/.env` (gitignored):

```env
AWS_ACCESS_KEY_ID=your_access_key
AWS_SECRET_ACCESS_KEY=your_secret_key
AWS_REGION=us-east-1
BEDROCK_MODEL_ID=anthropic.claude-3-5-sonnet-20241022-v2:0
```

### 4. Run Code Generation

```bash
dart run build_runner build --delete-conflicting-outputs
```

### 5. Launch the App

```bash
# Chrome recommended for Glass effects
flutter run -d chrome

# Or iOS/Android
flutter run
```

## Project Structure

```
gen_ui_client/
├── lib/
│   ├── main.dart                    # ProviderScope + MaterialApp
│   ├── core/errors/                 # ContractException, Failure
│   ├── domain/
│   │   ├── entities/               # ThemeState, LayoutNode, CodeGenResult
│   │   └── services/               # ICodeGenService interface
│   ├── data/
│   │   └── services/               # DartCodeGenService
│   └── presentation/
│       ├── providers/              # theme_provider.dart, architect_provider.dart
│       ├── registry/               # ui_kit_component_registry.dart
│       └── views/                  # architect_view.dart
├── assets/
│   ├── .env                        # AWS credentials (gitignored)
│   └── system_prompt.txt           # Layout Architect persona
└── test/
```

## Key Files

### main.dart

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'assets/.env');

  runApp(
    ProviderScope(
      child: GenUiClientApp(),
    ),
  );
}
```

### theme_provider.dart

```dart
@riverpod
class ThemeController extends _$ThemeController {
  @override
  ThemeState build() => const ThemeState();

  void setDesignLanguage(DesignLanguage lang) {
    state = state.copyWith(designLanguage: lang);
  }

  void setSeedColor(Color color) {
    state = state.copyWith(seedColor: color);
  }

  void toggleBrightness() {
    state = state.copyWith(
      brightness: state.brightness == Brightness.light
          ? Brightness.dark
          : Brightness.light,
    );
  }
}
```

### ui_kit_component_registry.dart

```dart
class UiKitComponentRegistry {
  static Widget build(
    String name,
    BuildContext context,
    Map<String, dynamic> props, {
    void Function(Map<String, dynamic>)? onAction,
  }) {
    final builder = _builders[name];
    if (builder == null) {
      return _buildErrorFallback(name, context);
    }
    return builder(context, props, onAction: onAction);
  }

  static final Map<String, ComponentBuilder> _builders = {
    'AppButton': _buildAppButton,
    'AppTextField': _buildAppTextField,
    // ... 29 more
  };
}
```

## Testing the Setup

1. **Theme Switching**: Tap the color circles in the app bar to change seed colors
2. **Design Language**: Use the dropdown to switch between Glass/Brutal/Flat/Neumorphic/Pixel
3. **AI Interaction**: Type "Create a login form" to see AI-generated layout
4. **Code Export**: Switch to the Code tab to see generated Dart code

## Troubleshooting

### Mock Mode Active

If you see "Mock Mode" in the app bar, check:
- `.env` file exists in `assets/`
- All 4 environment variables are set
- AWS credentials are valid

### Theme Not Updating

Ensure components use `Theme.of(context)` or `ref.watch(themeControllerProvider)`:
```dart
final theme = Theme.of(context).extension<AppDesignTheme>();
```

### Component Not Rendering

Check the component is registered in `UiKitComponentRegistry._builders`:
```dart
// Add missing component
'AppNewComponent': _buildAppNewComponent,
```

## Next Steps

1. Read [data-model.md](./data-model.md) for entity details
2. Review [contracts/component-props.md](./contracts/component-props.md) for prop schemas
3. Run `flutter test` to verify setup
