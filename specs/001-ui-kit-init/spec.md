# Feature Specification: UI Kit Initialization

**Feature Branch**: `001-ui-kit-init`  
**Created**: November 27, 2025  
**Status**: Draft  
**Input**: User description: "----- 1. Dependency Management (Dependencies) ----- Please modify pubspec.yaml in the project root directory, replacing dependencies and dev_dependencies with the following content. This ensures we adhere to Charter 2.2 (Dependency Purity) and do not include any business logic packages. [File Name: pubspec.yaml] name: ui\_kit\_library description: A high-cohesion, theme-driven UI component library. version: 0.0.1 homepage: [https://your-repo-url.com](https://www.google.com/search?q=https://your-repo-url.com) environment: sdk: '\>=3.2.0 \<4.0.0' flutter: "\>=3.22.0" dependencies: flutter: sdk: flutter # \--- Foundation --- intl: ^0.19.0 # Formatting google\_fonts: ^6.1.0 # Font management vector\_math: ^2.1.4 # Vector operations # \--- UI & Animation --- flutter\_svg: ^2.0.9 # SVG support (Charter 5.2) rive: ^0.13.4 # Complex state animation (Charter 6.1) flutter\_animate: ^4.5.0 # Micro-interactions (Charter 6.1) # \--- Theming Automation --- theme\_tailor\_annotation: ^2.0.0 # Automatically generate ThemeExtension (Charter 3.3) dev\_dependencies: flutter\_test: sdk: flutter flutter\_lints: ^3.0.0 # \--- Generators --- build\_runner: ^2.4.8 # Core generator theme\_tailor: ^2.0.0 # Theme generation logic flutter\_gen\_runner: ^5.4.0 # Assets generation logic (Charter 5.1) # \--- Widgetbook (憲章 12.1) --- widgetbook: ^3.0.0 widgetbook\_annotation: ^3.0.0 widgetbook\_generator: ^3.0.0 # \--- Assets Config (憲章 5.1) --- flutter\_gen: output: lib/src/foundation/gen/ # Generated file location line\_length: 80 integrations: flutter\_svg: true rive: true # \--- Assets Declaration --- flutter: uses-material-design: true assets: - assets/icons/ - assets/images/ - assets/anims/ ----- 2. Directory Structure (Directory Structure) ----- Please create the following folder structure according to Charter 2.3 (Atomic Design): ui\_kit\_library/ ├── assets/ # Root assets │ ├── icons/ # Place SVG (remove fill color) │ ├── images/ # Place WebP/PNG │ └── anims/ # Place .riv files │ ├── lib/ │ ├── ui\_kit\_library.dart # Barrel File (for export) │ └── src/ │ ├── foundation/ # Foundation layer │ │ ├── gen/ # (準備給 flutter\_gen 自動生成的空資料夾) │ │ └── theme/ # 主題定義 │ ├── atoms/ # 原子元件 (Button, Icon) │ ├── molecules/ # 分子元件 (ListTile) │ ├── organisms/ # 組織元件 (AppBar) │ └── layout/ # 佈局工具 (Responsive) │ └── widgetbook/ # 獨立的 Widgetbook App (如果尚未建立請看步驟 4) ├── analysis\_options.yaml ├── pubspec.yaml └── lib/ └── main.dart ----- 3. 基礎程式碼實作 (Boilerplate Implementation) ----- 請協助建立以下兩個核心檔案，以確立 憲章 3.3 (自動化) 與 憲章 7.2 (佈局配置) 的實作範本。 3.1 佈局定義 [檔案路徑: lib/src/foundation/theme/app\_layout.dart] import 'package:flutter/material.dart'; import 'package:theme\_tailor\_annotation/theme\_tailor\_annotation.dart'; part 'app\_layout.tailor.dart'; @Tailor(themes: ['regular']) class _\$AppLayout { // Breakpoints static double breakpointMobile = 600; static double breakpointTablet = 900; static double breakpointDesktop = 1200; // Grid System static int maxColumns = 12; static double gutter = 16.0; static double margin = 24.0; } 3.2 主題工廠 [檔案路徑: lib/src/foundation/theme/app\_theme.dart] import 'package:flutter/material.dart'; import 'app\_layout.dart'; // 引入上面的 Layout class AppTheme { /// 支援動態 Seed Color 的主題工廠 (憲章 3.4) static ThemeData create({ required Brightness brightness, Color seedColor = const Color(0xFF0870EA), // Default Brand Color }) { final colorScheme = ColorScheme.fromSeed( seedColor: seedColor, brightness: brightness, ); return ThemeData( useMaterial3: true, brightness: brightness, colorScheme: colorScheme, extensions: [ // 注入 Layout 設定 AppLayout.regular, // TODO: 未來注入 AppColors, AppTypography ], ); } } ----- 4. Widgetbook 環境設定 ----- 請在專案根目錄建立 widgetbook 資料夾（若尚未建立），並在該資料夾下的 pubspec.yaml 中貼入以下內容： [檔案路徑: widgetbook/pubspec.yaml] name: widgetbook\_workspace description: The widgetbook environment for ui\_kit\_library publish\_to: 'none' environment: sdk: '\>=3.2.0 \<4.0.0' flutter: sdk: flutter widgetbook: ^3.0.0 widgetbook\_annotation: ^3.0.0 # Reference the outer UI Kit ui\_kit\_library: path: ../ dev\_dependencies: build\_runner: ^2.4.8 widgetbook\_generator: ^3.0.0 ----- 5. 執行初始化指令 (Action Items) ----- 請依序執行以下指令完成配置（請在終端機執行）： 1. 安裝依賴： flutter pub get cd widgetbook && flutter pub get && cd .. 2. 執行生成器 (初次建置)： (這將會產生 app\_layout.tailor.dart 與 assets.gen.dart) dart run build\_runner build -d 3. 驗證： 確認終端機沒有紅色錯誤，且 lib/src/foundation/gen/ 資料夾內已成功生成 assets.gen.dart（即使目前 assets 為空，檔案也應存在）。"

## User Scenarios & Testing

### User Story 1 - Initialize UI Kit Project (Priority: P1)

As a developer, I want to initialize the UI Kit project with the specified dependencies, directory structure, and boilerplate code, so that I have a clean and conformant starting point for building UI components.

**Why this priority**: This is the foundational step for any UI Kit development, ensuring adherence to project standards from the outset.

**Independent Test**: The project can be initialized by running `flutter pub get` and `dart run build_runner build -d`. The presence of the specified files and directories, and the absence of build errors, confirms successful initialization.

**Acceptance Scenarios**:

1.  **Given** a fresh project directory, **When** the dependencies are updated and boilerplate files are created, **Then** `flutter pub get` runs successfully without errors.
2.  **Given** the project setup, **When** `dart run build_runner build -d` is executed, **Then** `app_layout.tailor.dart` and `assets.gen.dart` are generated without errors.
3.  **Given** the project setup, **When** the specified directory structure is created, **Then** all core directories (e.g., `assets/`, `lib/src/foundation/gen/`, `lib/src/foundation/theme/`) exist as expected.

### User Story 2 - Set up Widgetbook Environment (Priority: P1)

As a developer, I want to set up the Widgetbook environment within the UI Kit project, so that I can independently develop and showcase UI components.

**Why this priority**: Widgetbook is crucial for isolated component development and documentation, directly supporting the UI Kit's purpose.

**Independent Test**: The Widgetbook project can be initialized and its dependencies fetched. It should successfully reference the main UI Kit library.

**Acceptance Scenarios**:

1.  **Given** the project structure, **When** the `widgetbook/pubspec.yaml` is configured and `flutter pub get` is run in the `widgetbook` directory, **Then** all Widgetbook dependencies are resolved successfully.
2.  **Given** the Widgetbook environment is set up, **When** a simple Widgetbook example is created (not part of this spec, but for future verification), **Then** it can import and render components from the `ui_kit_library`.

### Edge Cases

- What happens if a specified dependency version conflicts with another dependency in a larger project? (Assumed to be handled by Flutter's dependency resolution, but charter 2.2 aims to minimize conflicts by keeping the UI Kit clean).
- How does the system handle missing asset files during generation? (Assumed `flutter_gen` will generate an empty `assets.gen.dart` as specified by the user's action items, indicating graceful handling).

## Constitutional Alignment

*GATE: All specifications MUST adhere to the principles outlined in the Project Constitution (v1.0.0).*

Consider how the following constitutional principles impact this feature's specification:

-   **2.2 Dependency Purity (依賴潔癖)**: The `pubspec.yaml` explicitly defines a minimal set of non-business-logic dependencies, ensuring the UI Kit remains lean and reusable as per the charter.
-   **2.3 Atomic Design (目錄結構)**: The specified directory structure (`assets/`, `lib/src/foundation/`, `atoms/`, `molecules/`, `organisms/`, `layout/`) directly implements the Atomic Design principles, promoting modularity and maintainability.
-   **3.3 Theming Automation (自動化)**: The use of `theme_tailor_annotation` and the boilerplate for `AppLayout` and `AppTheme` directly supports the automated generation of `ThemeExtension`, a core requirement of the theming strategy.
-   **3.4 Dynamic Theme Factory**: The `AppTheme.create` method with `seedColor` parameter directly implements the dynamic seed color support as outlined in the charter.
-   **5.1 Assets Generation Logic**: `flutter_gen` is configured to generate `assets.gen.dart` in `lib/src/foundation/gen/`, ensuring strong typing and centralized asset management.
-   **5.2 SVG Support**: `flutter_svg` is included as a dependency to support SVG assets, aligning with the charter's mandate for SVG usage.
-   **6.1 Complex State Animation**: `rive` and `flutter_animate` are included for complex state animations and micro-interactions, respectively, adhering to the charter's animation strategy.
-   **7.2 Layout Configuration**: The `AppLayout` class centralizes breakpoint and grid system definitions, ensuring consistent and responsive layouts without singletons or direct `MediaQuery` calls in every widget.
-   **12.1 Widgetbook Integration**: The setup for `widgetbook` and `widgetbook_generator` directly supports the charter's requirement for component documentation and isolated development via Widgetbook.

## Requirements

### Functional Requirements

-   **FR-001**: The project MUST have its `pubspec.yaml` configured with the specified `dependencies` and `dev_dependencies` to ensure a clean, non-business-logic-dependent UI Kit.
-   **FR-002**: The project MUST establish the specified Atomic Design directory structure under `ui_kit_library/lib/src/` including `foundation`, `atoms`, `molecules`, `organisms`, and `layout` folders.
-   **FR-003**: The project MUST include `app_layout.dart` with `AppLayout` definition using `theme_tailor_annotation` to centralize layout breakpoints and grid system properties.
-   **FR-004**: The project MUST include `app_theme.dart` with `AppTheme.create` method to support dynamic theme generation with a seed color.
-   **FR-005**: The `flutter_gen` configuration MUST be present in `pubspec.yaml` to enable automatic asset generation into `lib/src/foundation/gen/`.
-   **FR-006**: The Widgetbook environment MUST be set up in a `widgetbook/` subdirectory with its `pubspec.yaml` configured to reference the `ui_kit_library` and include `widgetbook` dependencies.
-   **FR-007**: The project MUST be able to successfully run `flutter pub get` in both the main project and the `widgetbook` subdirectory.
-   **FR-008**: The project MUST be able to successfully run `dart run build_runner build -d` to generate `app_layout.tailor.dart` and `assets.gen.dart`.

### Key Entities

-   **pubspec.yaml**: Configuration file defining project metadata, dependencies, and asset declarations.
-   **app_layout.dart**: Defines layout-related constants such as breakpoints, grid columns, gutter, and margin.
-   **app_theme.dart**: Contains the `AppTheme` class for generating `ThemeData` based on brightness and a seed color.
-   **assets/**: Root directory for storing various assets like icons, images, and animations.
-   **widgetbook/**: Directory containing the standalone Widgetbook application for UI component development and showcasing.

## Success Criteria

### Measurable Outcomes

-   **SC-001**: After execution of initialization commands, both the main project and the Widgetbook sub-project will successfully resolve all dependencies (exit code 0 for `flutter pub get`).
-   **SC-002**: After execution of build commands, all necessary code generation (e.g., `app_layout.tailor.dart`, `assets.gen.dart`) will complete without errors.
-   **SC-003**: The project's directory structure will precisely match the defined Atomic Design hierarchy upon completion.
-   **SC-004**: The `AppLayout` and `AppTheme` boilerplate files will be present and syntactically correct, ready for further extension.
-   **SC-005**: The `pubspec.yaml` will correctly reflect the specified dependencies and asset configurations, aligning with charter principles.