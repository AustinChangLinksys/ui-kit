# Widgetbook Workspace for UI Kit Library

This is a dedicated Widgetbook environment for interactively showcasing and testing UI components from the `ui_kit_library` package. It provides a visual catalog of all developed atoms, molecules, and organisms, allowing developers and designers to see components in various states and configurations.

## 🚀 Getting Started

### Running the Widgetbook

To view the UI components in your browser:

1.  Navigate to this directory:
    ```bash
    cd widgetbook
    ```
2.  Run the Flutter application, preferably targeting Chrome for web preview:
    ```bash
    flutter run -d chrome
    ```
    (You can also use other devices or emulators, e.g., `flutter run -d <your_device_id>`)

### Generating Widgetbook Use Cases

If you add new stories or modify existing ones, you'll need to run the Widgetbook generator:

```bash
cd widgetbook
dart run build_runner build --delete-conflicting-outputs
```

## 🌐 Demo

You can find a live demo of this Widgetbook instance at:
[https://austinchanglinksys.github.io/ui-kit/](https://austinchanglinksys.github.io/ui-kit/)