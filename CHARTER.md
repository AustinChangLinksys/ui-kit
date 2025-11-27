# 📜 Flutter UI Component Library Charter (ui_kit)

**版本**：1.0.0
**生效日期**：2025-11-27
**適用範圍**：所有 UI Library 的貢獻者與維護者

---

## 1. 願景與定位 (Vision & Scope)
本函式庫旨在提供一套 **高內聚 (High Cohesion)、無業務邏輯 (Logic-Free)、樣式驅動 (Theme-Driven)** 的 UI 元件集。它是應用程式視覺呈現的 **單一真理來源 (Single Source of Truth)**。

*   **Scope (範疇)**：基礎原子元件 (Atoms)、複合元件 (Molecules)、樣式定義 (Theming)、圖示資產 (Assets)、基礎佈局邏輯 (Layout)。
*   **Out of Scope (非範疇)**：API 連線、狀態管理 (Bloc/Provider)、路由邏輯 (Routing)、業務資料模型 (Data Models)。

---

## 2. 架構邊界 (Architectural Boundaries)

### 2.1 實體隔離
*   本函式庫必須作為一個 **獨立的 Dart Package** 存在，物理上強制解耦。

### 2.2 依賴潔癖 (Dependency Hygiene)
*   ❌ **禁止 (Forbidden)**：嚴禁依賴含有業務邏輯或後端連線的套件，如 `bloc`, `provider`, `riverpod`, `http`, `dio`, `firebase`, `shared_preferences`。
*   ✅ **允許 (Allowed)**：僅限 UI 與工具類套件，如 `flutter`, `intl` (格式化), `vector_math`, `google_fonts`, `flutter_svg`, `rive`, `theme_tailor`, `flutter_animate`, `flutter_gen`。

### 2.3 目錄結構 (Directory Structure)
採用 **Atomic Design** 變體結構：
*   `src/foundation/`: 基礎樣式 (Colors, Type, Spacing)。
*   `src/atoms/`: 不可拆分的最小單位 (Button, Icon, Badge)。
*   `src/molecules/`: 簡單組合 (ListTile, InputField)。
*   `src/organisms/`: 複雜區塊 (AppBar, ProductCard)。
*   `src/layout/`: 響應式佈局輔助工具。

---

## 3. 樣式與主題 (Theming & Styling)

### 3.1 Token 優先原則 (Token-First Design)
*   **禁止硬編碼**：UI 元件內部嚴禁出現 `Color(0xFF...)`、`Colors.red` 或寫死的 `TextStyle`。
*   **存取規範**：所有樣式必須透過 `Theme.of(context)` 存取，以確保支援動態換色。

### 3.2 語意化擴充 (Semantic Architecture)
*   **命名意圖**：`ThemeExtension` 變數必須描述「用途」（如 `success`, `critical`, `surfaceContainer`），**禁止**描述「外觀」（如 `green`, `orange`）。
*   **擴充機制**：當標準 Material 3 ColorScheme 不足時，必須透過繼承 `ThemeExtension` 擴充。

### 3.3 自動化與工具 (Automation)
*   **Theme Tailor**：必須使用 **`theme_tailor`** 套件生成 `ThemeExtension`，禁止手寫 `copyWith` 與 `lerp`，以降低維護錯誤。

### 3.4 動態主題工廠 (Dynamic Theme Factory)
*   不提供寫死的 `ThemeData` 常數。必須提供 Factory 方法（如 `AppTheme.create({Color? seed})`），允許主程式注入 Seed Color 以支援動態取色 (Dynamic Color)。

### 3.5 文字排版 (Typography)
*   遵循 **DRY 原則**，建立統一的 `BaseTextStyle` 來管理 `fontFamily` 與 `package` 路徑，禁止在個別樣式中重複定義字體參數。

---

## 4. 元件設計原則 (Component Design)

### 4.1 Dumb Components (笨元件)
*   元件僅透過 **Constructor** 接收資料，透過 **Callback** (`VoidCallback`, `ValueChanged`) 傳遞事件。
*   元件內部不應持有任何業務狀態，僅可持有 UI 暫態 (如 ScrollOffset, AnimationController)。

### 4.2 組合優於繼承 (Composition over Inheritance)
*   善用 **Slots (插槽)** 模式，預留 `child`, `leading`, `trailing`, `content` 參數。
*   避免創造 `MyRedButton`，應創造 `MyButton(style: MyButtonStyle.danger())`。

---

## 5. 資產管理 (Assets Management)

### 5.1 存取規範
*   **強型別存取**：嚴禁使用字串路徑。必須使用 **`flutter_gen`** 生成的物件 (如 `MyAssets.icons.home`) 進行存取，確保 Package 路徑正確。

### 5.2 格式規範
*   **圖示 (Icons)**：使用 **SVG** 格式。檔案內應移除顏色屬性 (`fill`)，由外部 `IconTheme` 控制。
*   **產品圖 (Product Images)**：優先使用 **WebP** 格式以平衡畫質與體積。
*   **深色模式適配**：
    *   單色圖示：使用 `ColorFilter` 改變顏色。
    *   擬真產品圖：禁止換色。需使用 `ColorFiltered` 疊加半透明黑色遮罩 (Dimming) 降低亮度，避免刺眼。

---

## 6. 動畫技術選型 (Animation Strategy)

### 6.1 技術收斂
*   **Level 1 (微互動)**：使用 **`flutter_animate`** 或原生 Code 實作 UI 轉場。
*   **Level 2 (狀態驅動)**：複雜狀態圖示（如路由器燈號、連線流程）統一使用 **Rive (.riv)**。
*   **禁令**：基於檔案體積與維護成本考量，本專案 **不引入 Lottie**。

### 6.2 Rive 規範
*   必須善用 **State Machine (狀態機)** 將多種狀態封裝於單一檔案，減少資源碎片化。
*   必須導出為二進位 `.riv` 格式。

---

## 7. 佈局與響應式 (Layout & Responsiveness)

### 7.1 無全域狀態 (No Singletons)
*   **嚴禁** 使用 Singleton 儲存螢幕尺寸或計算結果。所有佈局計算必須依賴 `BuildContext` 與 `MediaQuery`。

### 7.2 配置集中化
*   斷點 (Breakpoints)、欄數 (Columns)、間距 (Gutters) 必須定義於 **ThemeExtension** (`AppLayout`) 中，而非散落在 Widget 裡。

### 7.3 開發體驗
*   提供 `BuildContext` Extension Methods (如 `context.col(6)`, `context.isDesktop`) 簡化呼叫邏輯。

---

## 8. 無障礙與輔助功能 (Accessibility)

### 8.1 語意標籤
*   所有自定義互動元件必須包裹 `Semantics` Widget，並宣告正確的 `label`, `value`, `onTap` 屬性。

### 8.2 觸控目標
*   行動裝置的可點擊區域至少需為 **44x44 (iOS)** 或 **48x48 (Android)** 邏輯像素。

---

## 9. 國際化潔癖 (Internationalization)

### 9.1 無字串政策
*   Library 內部 **嚴禁包含硬編碼的顯示文字**。所有 Label 必須透過參數由外部傳入。

### 9.2 RTL 支援
*   佈局屬性必須使用 `Directionality` 安全的寫法（如 `EdgeInsetsDirectional.start` 取代 `EdgeInsets.left`）。

---

## 10. 效能優化 (Performance)

*   **重繪邊界**：頻繁變動的元件（如 Loading）必須包裹 `RepaintBoundary`。
*   **昂貴操作**：謹慎使用 `Opacity` (改用 `FadeTransition`) 與 `BackdropFilter`。

---

## 11. 版本控制 (Versioning)

*   **語意化版本**：嚴格遵守 **SemVer (X.Y.Z)**。Breaking Change 必須升級主版號 (X)。
*   **棄用策略**：移除 API 前需標記 ` @Deprecated` 並保留至少一個次版號的過渡期。

---

## 12. 品質保證與測試 (QA & Testing)

### 12.1 Widgetbook (元件型錄)
*   **強制性**：所有公開元件必須在 Widgetbook 中註冊 UseCase，並配置 Knobs 供設計師檢核。

### 12.2 黃金檔測試 (Golden Tests)
*   **測試矩陣**：核心元件必須包含截圖測試，並覆蓋以下維度：
    *   **Theme**: Light Mode / Dark Mode。
    *   **Text Scale**: **Standard (1.0)** / **Accessibility (1.5)**。
*   **零溢出標準**：在 1.5x 字體縮放下，測試截圖不得出現溢出警告 (Yellow/Black stripes)，且文字不得遮擋關鍵操作區。
