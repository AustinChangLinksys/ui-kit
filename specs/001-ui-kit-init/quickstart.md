# Quickstart Guide: UI Kit Initialization

This guide provides the necessary steps to initialize the UI Kit project.

## Action Items

Please execute the following commands sequentially in your terminal:

1.  **Install dependencies**:
    ```bash
    flutter pub get
    cd widgetbook && flutter pub get && cd ..
    ```

2.  **Run code generators (initial build)**:
    (This will generate `app_layout.tailor.dart` and `assets.gen.dart`)
    ```bash
    dart run build_runner build -d
    ```

3.  **Verification**:
    Confirm that there are no red errors in the terminal and that `lib/src/foundation/gen/` folder successfully contains `assets.gen.dart` (even if assets are currently empty, the file should exist).