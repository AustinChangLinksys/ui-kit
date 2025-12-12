# StyledPageView 遷移 - 需求說明提示字詞

## Phase 1: UI Kit AppPageView 增強

### 🎯 核心需求
```
請基於現有的 UI Kit AppPageView，增加以下功能支援：

1. AppBar 整合系統
2. 底部操作欄系統
3. 響應式選單系統
4. 分頁（TabBar/TabBarView）支援
5. Sliver 模式增強

請確保：
- 遵循 UI Kit 憲章（使用 Equatable、主題系統、響應式佈局）
- 保持 domain-agnostic（不包含業務邏輯）
- 向後兼容現有的 AppPageView 使用者
- 使用 UI Kit 的響應式佈局系統（context.isDesktop 而非 column count）
```

### 📋 詳細功能需求

#### 1. 資料模型設計
```
創建以下 Equatable 資料模型，位於 lib/src/layout/models/page_models.dart：

- PageAppBarConfig: AppBar 配置
  * title: String?
  * actions: List<Widget>?
  * onBackTap: VoidCallback?
  * showBackButton: bool
  * enableSliver: bool
  * toolbarHeight: double

- PageBottomBarConfig: 底部操作欄配置
  * positiveLabel/negativeLabel: String?
  * onPositiveTap/onNegativeTap: VoidCallback?
  * isPositiveEnabled/isNegativeEnabled: bool
  * isDestructive: bool (for red styling)

- PageMenuConfig: 選單配置
  * title: String?
  * items: List<PageMenuItem>
  * showOnDesktop/showOnMobile: bool
  * menuWidth: double?
  * mobileMenuIcon: IconData?

- PageMenuItem: 選單項目
  * label: String
  * icon: IconData?
  * onTap: VoidCallback?
  * enabled: bool

每個模型需要：copyWith 方法、props getter、完整的 constructor
```

#### 2. AppPageView 增強
```
增強現有的 AppPageView，添加以下屬性：

- appBarConfig: PageAppBarConfig?
- bottomBarConfig: PageBottomBarConfig?
- menuConfig: PageMenuConfig?
- tabs: List<Widget>?
- tabViews: List<Widget>?
- tabController: TabController?
- onTabChanged: void Function(int)?
- contentType: PageContentType (flexible/fit)

請保持現有所有屬性和功能不變，只新增功能。
```

#### 3. 響應式選單處理
```
創建 ResponsiveMenuHandler 組件：

- 使用 context.isDesktop 判斷響應式佈局（不使用 column count）
- 桌面版：顯示側邊選單卡片（使用 context.colWidth(4)）
- 行動版：顯示選單觸發按鈕，點擊後彈出 Modal Bottom Sheet
- 整合 AppCard 包裝選單內容
- 支援選單位置配置（左側/右側）
```

#### 4. Sliver 模式增強
```
增強現有的 Sliver 佈局：

- 支援 SliverAppBar（可折疊/固定）
- 支援 SliverPersistentHeader 用於 TabBar
- 支援 SliverFillRemaining 用於 fit 內容類型
- 正確處理 header + appBar + tabs + content 的組合
- 支援 pinned TabBar（桌面版固定，行動版浮動）
```

#### 5. 底部操作欄實現
```
實現底部操作欄：

- 固定在頁面底部（Stack + Positioned）
- 響應式按鈕佈局（行動版全寬，桌面版固定寬度）
- 支援破壞性操作樣式（紅色按鈕）
- 自動處理安全區域
- 支援按鈕啟用/停用狀態
- 整合本地化文字（Save/Cancel 預設值）
```

## Phase 2: PrivacyGUI 實驗性組件

### 🎯 核心需求
```
在 PrivacyGUI 專案中創建實驗性組件，完全兼容現有 StyledAppPageView API：

創建以下檔案結構：
privacy_gui/lib/page/components/experimental/
├── experimental_ui_kit_page_view.dart
├── ui_kit_adapters.dart
└── privacy_gui_wrappers.dart

要求：
- 100% API 兼容現有 StyledAppPageView
- 內部使用增強版 UI Kit AppPageView
- 保留所有 PrivacyGUI 特定功能和邏輯
- 支援所有 factory constructors (innerPage, withSliver)
```

### 📋 詳細功能需求

#### 1. ExperimentalUiKitPageView 組件
```
完全複製 StyledAppPageView 的介面，包括：

所有參數：
- title, child, toolbarHeight, onRefresh, onBackTap
- backState, actions, padding, bottomSheet, bottomNavigationBar
- scrollable, appBarStyle, handleNoConnection, handleBanner
- menuIcon, menu, menuWidget, controller, enableSafeArea
- bottomBar, menuOnRight, largeMenu, topbar, useMainPadding
- markLabel, tabs, tabContentViews, tabController, onTabTap
- hideTopbar, pageContentType, enableSliverAppBar

Factory constructors:
- ExperimentalUiKitPageView.innerPage(...)
- ExperimentalUiKitPageView.withSliver(...)

內部實現：
- 將所有參數轉換為 UI Kit AppPageView 配置
- 保留 PrivacyGUI 滾動監聽邏輯
- 保留連接狀態和橫幅處理邏輯
```

#### 2. 參數轉換邏輯
```
實現轉換方法：

_convertToAppBarConfig():
- 組合 title + markLabel
- 轉換 backState 為 showBackButton + onBackTap
- 處理 appBarStyle (back/close/none)
- 設定 enableSliver 和 toolbarHeight

_convertToBottomBarConfig():
- 轉換 PageBottomBar 為 PageBottomBarConfig
- 處理 InversePageBottomBar (isDestructive = true)
- 修正拼字錯誤（negitive -> negative）
- 整合本地化標籤

_convertToMenuConfig():
- 轉換 PageMenu 和 menuWidget
- 設定響應式顯示選項
- 設定選單寬度（largeMenu）
- 設定行動版圖標
```

#### 3. PrivacyGUI 特定邏輯保留
```
保留以下 PrivacyGUI 特定功能：

滾動監聽器：
- menuController 整合
- 底部選單顯示/隱藏邏輯
- 滾動方向檢測和處理

Domain Logic 包裝：
- handleNoConnection: 連接狀態檢查和 NoConnectionOverlay
- handleBanner: 橫幅顯示處理
- showColumnOverlayNotifier: ValueListenableBuilder 整合

TopBar 處理：
- hideTopbar 功能
- 自定義 topbar Widget
- 預設 TopBar (80px 高度)
```

## Phase 3: 測試驗證系統

### 🎯 核心需求
```
創建完整的測試驗證系統：

privacy_gui/lib/page/test_pages/
└── ui_kit_migration_test_page.dart

privacy_gui/lib/page/test_utils/
└── migration_analyzer.dart

功能需求：
- 並排比較 StyledAppPageView vs ExperimentalUiKitPageView
- 實時切換測試
- 多場景測試用例
- 複雜度分析工具
```

### 📋 詳細功能需求

#### 1. UiKitMigrationTestPage
```
實現測試頁面功能：

控制面板：
- Switch 切換新舊實現
- 按鈕選擇不同測試場景
- 狀態指示器顯示當前使用的實現

測試場景：
- 基礎頁面：title + bottomBar + 簡單內容
- 選單頁面：desktop 側邊選單 + mobile bottom sheet
- 分頁頁面：TabBar + TabController + 多個 TabView
- 複雜頁面：所有功能組合 + Sliver + markLabel

互動驗證：
- SnackBar 顯示按鈕點擊事件
- 區分新舊實現的事件來源
- 滾動行為測試
- 響應式佈局測試
```

#### 2. MigrationAnalyzer 工具
```
實現分析工具：

複雜度評分系統：
- hasMenu: +2 分
- hasTabs: +2 分
- hasBottomBar: +1 分
- useSliverAppBar: +3 分
- hasCustomScrollLogic: +3 分
- hasConnectionHandling: +1 分
- hasBannerHandling: +1 分

分析報告：
- complexityScore: int
- challenges: List<String>
- warnings: List<String>
- recommendation: String

建議分級：
- 0-3分: 低複雜度，建議優先遷移
- 4-6分: 中等複雜度，需要仔細測試
- 7-9分: 高複雜度，分階段遷移
- 10+分: 極高複雜度，需要詳細計畫
```

## Phase 4: 功能開關系統

### 🎯 核心需求
```
實現安全的功能開關機制：

全域開關：FeatureFlags.useUiKitPageView
頁面級開關：PageMigrationFlags.pageMigrationStatus
條件渲染：每個頁面支援新舊實現切換

要求：
- 預設關閉（安全優先）
- 支援運行時切換（開發模式）
- 支援頁面級細粒度控制
- 完整的回滾機制
```

### 📋 詳細功能需求

#### 1. 功能開關設計
```
創建功能開關系統：

FeatureFlags 類別：
- useUiKitPageView: bool (全域開關)
- debugMode: bool (開發模式開關)
- enablePageAnalyzer: bool (分析工具開關)

PageMigrationFlags 類別：
- pageMigrationStatus: Map<String, bool>
- 支援頁面識別符映射
- 支援批次啟用/停用

運行時配置：
- 支援環境變數控制
- 支援配置檔案載入
- 支援除錯時動態修改
```

#### 2. 條件渲染機制
```
在每個 PrivacyGUI 頁面實現：

渲染邏輯：
final useExperimental = FeatureFlags.useUiKitPageView &&
                       PageMigrationFlags.isPageEnabled(pageId);

return useExperimental
    ? ExperimentalUiKitPageView(...)  // 新實現
    : StyledAppPageView(...);         // 舊實現

錯誤處理：
- try-catch 包裝新實現
- 發生錯誤時自動回退到舊實現
- 錯誤報告和日誌記錄
```

## 驗收標準

### ✅ Phase 1 完成標準
- [ ] 所有資料模型使用 Equatable 正確實現
- [ ] AppPageView 支援 appBar/bottomBar/menu/tabs 配置
- [ ] 響應式選單在桌面和行動版正確顯示
- [ ] Sliver 模式支援所有新功能
- [ ] 向後兼容現有 AppPageView 使用者
- [ ] 通過 UI Kit 的 golden tests

### ✅ Phase 2 完成標準
- [ ] ExperimentalUiKitPageView 與 StyledAppPageView 100% API 兼容
- [ ] 所有 PrivacyGUI 特定邏輯正確保留
- [ ] 滾動監聽和選單控制邏輯正常運作
- [ ] 連接狀態和橫幅處理功能正常
- [ ] 所有轉換邏輯處理邊際情況

### ✅ Phase 3 完成標準
- [ ] 測試頁面可以實時切換新舊實現
- [ ] 所有測試場景都能正確運行
- [ ] 複雜度分析工具提供準確評估
- [ ] 視覺和功能上新舊實現完全一致

### ✅ Phase 4 完成標準
- [ ] 功能開關系統安全可靠
- [ ] 支援頁面級細粒度控制
- [ ] 錯誤時能自動回退到舊實現
- [ ] 完整的遷移路徑和回滾機制

## 技術注意事項

### 🔧 UI Kit 憲章遵循
- 使用 `Equatable` 而非 `@immutable`
- 使用 `context.isDesktop` 而非 `context.currentMaxColumns >= 12`
- 使用 UI Kit 現有組件 (`AppCard`, `AppText`, `AppGap` 等)
- 遵循 Grid 系統 (`context.colWidth`, `context.pageMargin`)
- 使用主題系統整合

### 🔧 PrivacyGUI 特定考量
- 保留 `menuController` 和 `showColumnOverlayNotifier` 整合
- 保留本地化支援 (`loc(context)`)
- 保留路由系統整合 (`context.pop`)
- 處理拼字錯誤但保持向後兼容
- 保留所有現有的業務邏輯

### 🔧 效能和安全性
- 避免不必要的重建和記憶體洩漏
- 正確處理 ScrollController 的生命週期
- 確保功能開關的執行效率
- 提供完整的錯誤處理和恢復機制

---

這些需求說明可以作為實施每個階段的具體指導，確保遷移過程的順利進行。