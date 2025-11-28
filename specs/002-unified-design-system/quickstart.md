# Quickstart: Unified Design System

## 1. Usage

```dart
// Using the generic AppCard (automatically adapts to theme)
AppCard(
  child: Text("Hello World"),
  onTap: () => print("Tapped"),
);

// Using the AppDialog
showDialog(
  context: context,
  builder: (_) => AppDialog(
    title: Text("Alert"),
    content: Text("Something happened."),
  ),
);
```

## 2. Switching Themes (Widgetbook)

1. Open Widgetbook.
2. **Theme Mode**: Use the standard "Theme" addon (Moon/Sun icon) to toggle Light/Dark.
3. **Design Language**: Use the "Knobs" panel to select "Design Language" (Glass, Brutal, Flat, Neumorphic).
4. Observe all components updating instantly.

## 3. Verifying Implementation

Run tests:
```bash
flutter test
```

Run Widgetbook:
```bash
flutter run -d chrome -t widgetbook/lib/main.dart
```