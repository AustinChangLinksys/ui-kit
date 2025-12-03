# Quickstart: GenUI Component Registration

This guide demonstrates how to register UI Kit components with GenUI so they can be dynamically rendered based on LLM responses.

## 1. Initialize Registry

Create a `ComponentRegistry` instance during your app initialization.

```dart
import 'package:flutter/material.dart';
import 'package:generative_ui/generative_ui.dart';

void main() {
  // 1. Create Registry
  final registry = ComponentRegistry();

  // 2. Register Components
  // Use helper functions or manual registration
  registerWifiSettingsCard(registry);
  registerInfoCard(registry);

  // Manual registration example
  registry.register('MyCustomWidget', (context, props) {
    return Text(props['text'] ?? 'Default');
  });

  runApp(MyApp(registry: registry));
}
```

## 2. Pass Registry to GenUI

Pass the configured registry to the `GenUiWrapper` (or `GenUiContainer` depending on your integration level).

```dart
class MyApp extends StatelessWidget {
  final ComponentRegistry registry;

  const MyApp({required this.registry});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: GenUiWrapper(
          registry: registry,
          orchestrator: OrchestrateUIFlowUseCase(
             contentGenerator: MockContentGenerator(),
          ),
        ),
      ),
    );
  }
}
```

## 3. Verify Registration

You can verify components are registered using `lookup`:

```dart
if (registry.lookup('WifiSettingsCard') != null) {
  print('WifiSettingsCard is ready to render!');
}
```
