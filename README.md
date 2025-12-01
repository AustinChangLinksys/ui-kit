# UI Kit Library

A high-cohesion, theme-driven UI component library for the USP Client POC project. This package follows **Atomic Design** principles to provide a robust and reusable set of widgets, designed for scalability and maintainability.

## 🏗 Architecture

This project is structured using **Atomic Design**:

- **Atoms** (`lib/src/atoms`): Basic building blocks (Icons, Typography, Colors, Buttons, simple inputs). High stability, low complexity.
- **Molecules** (`lib/src/molecules`): Groups of atoms functioning together (Form fields with labels, Search bars, Card headers).
- **Organisms** (`lib/src/organisms`): Complex UI components composed of groups of molecules and/or atoms (Forms, Navigation bars, Product cards).
- **Layout** (`lib/src/layout`): Layout-specific components and wrappers.
- **Foundation** (`lib/src/foundation`): Core utilities, theme definitions, generated assets, and constants.

## 🚀 Getting Started

### Prerequisites
- Flutter SDK: `>=3.22.0`
- Dart SDK: `>=3.2.0 <4.0.0`

### Installation

Add this package to your `pubspec.yaml`:

```yaml
dependencies:
  ui_kit_library:
    path: packages/ui_kit # Or git url
```

## 🛠 Development

### Code Generation

This project relies heavily on code generation for Assets (`flutter_gen`) and Themes (`theme_tailor`).

To run the code generator:

```bash
dart run build_runner build --delete-conflicting-outputs
```

### Assets

Assets are managed in the `assets/` directory and code-generated into safe Dart accessors.

- **Images**: `assets/images/`
- **Icons**: `assets/icons/`
- **Fonts**: `assets/fonts/`
- **Animations**: `assets/anims/` (Rive files)

**Usage:**
Code is generated in `lib/src/foundation/gen/`.

### Widgetbook (Component Catalog)

We use [Widgetbook](https://www.widgetbook.io/) to document and test components in isolation.

To run Widgetbook:

1.  Navigate to the widgetbook directory:
    ```bash
    cd widgetbook
    ```
2.  Run the app:
    ```bash
    flutter run -d chrome
    ```
    (Or choose your preferred device/emulator)

To generate Widgetbook use cases:
```bash
cd widgetbook
dart run build_runner build --delete-conflicting-outputs
```

## 🧪 Testing

### Unit & Widget Tests
Run standard Flutter tests:

```bash
flutter test
```

### Golden Tests
We use `alchemist` for visual regression testing (Golden Tests).

To run golden tests:
```bash
flutter test --tags golden
```
*(Note: Ensure you are on the correct platform for golden generation if required)*

## ✨ Widgetbook Stories Overview

Below is a summary of the UI components showcased in our Widgetbook, categorized by their Atomic Design level:

**Atoms (基本元件)**
-   **AppText**: 展示 `AppText` 的各種排版樣式 (Headline, Body, Caption 等) 與互動屬性。
-   **AppButton & AppIconButton**: 展示 `AppButton` 與 `AppIconButton` 的各種變體、尺寸與狀態 (Loading, Disabled)。
-   **AppSkeleton**: 展示 `AppSkeleton` 載入狀態，包含文字、圓形與複雜組件的骨架圖。
-   **Assets (AppIcon, ProductImage, ThemeAwareSvg)**: 展示 `AppIcon`, `ProductImage`, `ThemeAwareSvg` 等資源元件的顯示與主題切換效果。
-   **AppSurface**: 展示 `AppSurface` 的不同層級 (Base, Elevated, Highlight) 與互動效果。
-   **AppGap**: 展示 `AppGap` 的各種間距尺寸 (xxs 到 xxxl) 與 RWD Gutter。

**Molecules (複合元件)**
-   **AppCard**: 展示 `AppCard` 的標題、內容與互動效果。
-   **AppSwitch**: 展示 `AppSwitch` 的開關狀態與禁用狀態。
-   **AppRadio**: 展示 `AppRadio` 單選按鈕群組的互動與狀態。
-   **AppCheckbox**: 展示 `AppCheckbox` 複選框的互動與狀態。
-   **AppSlider**: 展示 `AppSlider` 滑桿的連續與分段模式。
-   **AppDialog**: 展示 `AppDialog` 的標準對話框與彈出式視窗範例。

**Navigation (導航)**
-   **AppNavigationBar**: 展示 `AppNavigationBar` (底部導航) 的互動切換。
-   **AppNavigationRail**: 展示 `AppNavigationRail` (側邊導航) 在桌面佈局的應用。

**Status (狀態)**
-   **AppTag**: 展示 `AppTag` 的標籤樣式、刪除功能與互動效果。
-   **AppBadge**: 展示 `AppBadge` 的狀態徽章樣式與自定義顏色。
-   **AppAvatar**: 展示 `AppAvatar` 的圖片與文字縮寫顯示，以及不同尺寸變化。

**Layouts (佈局)**
-   **AppPageView**: 展示 `AppPageView` 的響應式網格佈局策略 (Span Logic vs Fixed Split)。

**Examples (範例頁面)**
-   **MockupPage**: 一個完整的 Mockup 頁面，整合了多種 UI 元件以展示實際應用場景。
-   **DashboardPage**: 一個複雜的 Dashboard 頁面範例，包含 RWD 佈局與多個功能區塊。

## 📚 Documentation

Detailed specifications and plans can be found in the `specs/` directory:
- `specs/001-ui-kit-init`: Initial setup and charter.
- `specs/002-unified-design-system`: Design system specifications.
- `specs/003-ui-kit-molecules`: Component specific specs.

## 📦 Dependencies

Key packages used:
- **Styling**: `theme_tailor_annotation`
- **Assets**: `flutter_svg`, `rive`
- **Animation**: `flutter_animate`
- **Utilities**: `gap`, `equatable`