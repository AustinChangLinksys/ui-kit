# StyledPageView 到 UI Kit 遷移計劃

## 專案目標

**終極目標**: 在 PrivacyGUI 專案中完整移除 `privacy_widget` 依賴，使用 UI Kit 完全取代
**首要目標**: 解決大魔王 `StyledPageView` 的遷移，因為它是結構最複雜的組件
**安全策略**: 建立實驗性頁面進行測試，而不直接修改現有的 `StyledPageView`

## 現況分析

### UI Kit 現有的 AppPageView 特點
✅ **優點**:
- 純淨的 UI 組件，無 domain logic
- 響應式設計 (Grid System)
- 雙模式佈局 (Sliver/Box)
- 基於主題的樣式系統
- 遵循 Atomic Design 原則

❌ **缺點**:
- 功能相對簡單
- 缺少 AppBar 整合
- 沒有底部操作欄
- 沒有選單系統
- 沒有分頁（Tab）支援

### PrivacyGUI 的 StyledAppPageView 特點
✅ **優點**:
- 功能完整 (AppBar, 底部操作欄, 選單, 分頁)
- 複雜的互動邏輯
- 響應式選單系統
- Sliver 模式支援

❌ **缺點**:
- 包含 domain specific 邏輯（PrivacyGUI 特定）
- 與特定路由系統耦合
- 包含業務邏輯（如連接狀態處理）
- 存在拼寫錯誤（negitive -> negative）

## 遷移策略

### 整體架構設計
```
PrivacyGUI Pages
     ↓
ExperimentalUiKitPageView (實驗層)
     ↓
PageViewAdapter (轉換層)
     ↓
UI Kit AppPageView（增強版）
```

### Phase 1: 實驗性驗證（1-2 週）

#### 1.1 創建目錄結構
```
privacy_gui/lib/page/components/experimental/
├── experimental_ui_kit_page_view.dart   # 實驗性頁面組件
├── ui_kit_adapters.dart                 # 轉換適配器
└── privacy_gui_wrappers.dart            # PrivacyGUI 特定包裝

privacy_gui/lib/page/test_pages/
└── ui_kit_migration_test_page.dart      # 測試驗證頁面

privacy_gui/lib/page/test_utils/
└── migration_analyzer.dart              # 遷移分析工具
```

#### 1.2 核心組件設計

**ExperimentalUiKitPageView**:
- 完全複製 StyledAppPageView 的 API 介面
- 內部使用 UI Kit AppPageView
- 保留所有 PrivacyGUI 特定邏輯
- 提供 factory constructors（innerPage, withSliver）

**關鍵轉換功能**:
```dart
// AppBar 配置轉換
PageAppBarConfig _convertToAppBarConfig() {
  return PageAppBarConfig(
    title: _buildTitleWithMarkLabel(),
    showBackButton: widget.backState != StyledBackState.none,
    onBackTap: widget.backState == StyledBackState.enabled
        ? (widget.onBackTap ?? _defaultBackAction)
        : null,
    actions: widget.actions,
    toolbarHeight: widget.toolbarHeight,
    enableSliver: widget.enableSliverAppBar,
  );
}

// 底部操作欄轉換
PageBottomBarConfig _convertToBottomBarConfig() {
  return PageBottomBarConfig(
    positiveLabel: widget.bottomBar!.positiveLabel ?? loc(context).save,
    negativeLabel: widget.bottomBar!.negitiveLable ??
                  (widget.bottomBar!.isNegitiveEnabled != null ?
                   loc(context).cancel : null),
    onPositiveTap: widget.bottomBar!.onPositiveTap,
    onNegativeTap: widget.bottomBar!.onNegitiveTap,
    isPositiveEnabled: widget.bottomBar!.isPositiveEnabled,
    isNegativeEnabled: widget.bottomBar!.isNegitiveEnabled,
    isDestructive: widget.bottomBar is InversePageBottomBar,
  );
}

// 選單系統轉換
PageMenuConfig _convertToMenuConfig() {
  return PageMenuConfig(
    title: widget.menu?.title,
    items: widget.menu?.items.map((item) => PageMenuItem(
      label: item.label,
      icon: item.icon,
      onTap: item.onTap,
    )).toList() ?? [],
    showOnDesktop: true,
    showOnMobile: true,
    mobileMenuIcon: widget.menuIcon,
  );
}
```

#### 1.3 測試驗證頁面

**UiKitMigrationTestPage** 功能:
- 並排比較 StyledAppPageView 和 ExperimentalUiKitPageView
- 切換開關實時對比
- 多種測試用例：
  - 基礎頁面測試
  - 含選單頁面測試
  - 含分頁頁面測試
  - 複雜頁面測試（所有功能組合）

#### 1.4 遷移分析工具

**MigrationAnalyzer** 功能:
- 分析 StyledPageView 的複雜度評分
- 識別潛在挑戰點
- 提供遷移建議

評分標準:
- 選單系統: +2 分
- 分頁系統: +2 分
- 底部操作欄: +1 分
- Sliver AppBar: +3 分（最複雜）
- 自定義滾動邏輯: +3 分（高風險）
- 連接狀態處理: +1 分
- 橫幅處理: +1 分

### Phase 2: 功能對齊（2-3 週）

#### 2.1 UI Kit AppPageView 增強

**需要新增的資料模型**（遵循 UI Kit 憲章）:

```dart
// 使用 Equatable 而非 @immutable
class PageAppBarConfig extends Equatable {
  final String? title;
  final List<Widget>? actions;
  final VoidCallback? onBackTap;
  final bool showBackButton;
  final bool enableSliver;
  final double toolbarHeight;

  // copyWith 和 props 實現
}

class PageBottomBarConfig extends Equatable {
  final String? positiveLabel;
  final String? negativeLabel;
  final VoidCallback? onPositiveTap;
  final VoidCallback? onNegativeTap;
  final bool isPositiveEnabled;
  final bool? isNegativeEnabled;
  final bool isDestructive;

  // copyWith 和 props 實現
}

class PageMenuConfig extends Equatable {
  final String? title;
  final List<PageMenuItem> items;
  final bool showOnDesktop;
  final bool showOnMobile;
  final double? menuWidth;
  final IconData? mobileMenuIcon;

  // copyWith 和 props 實現
}
```

**響應式選單處理**（修正版）:
```dart
// 使用 UI Kit 的響應式判斷，而不是 column count
if (context.isDesktop && config.showOnDesktop) {
  // 桌面版：顯示側邊選單
  return SizedBox(
    width: config.menuWidth ?? context.colWidth(4),
    child: menuContent,
  );
} else if (config.showOnMobile) {
  // 行動版：顯示觸發按鈕
  return AppIconButton.noPadding(
    icon: config.mobileMenuIcon ?? Icons.menu,
    onTap: () => _showMobileMenu(context),
  );
}
```

#### 2.2 PrivacyGUI 特定邏輯保留

**滾動監聽器**:
```dart
void _privacyGuiScrollListener() {
  final menu = ref.read(menuController);
  if (menu.displayType != MenuDisplay.bottom) {
    if (!menu.isVisible) {
      menu.setMenuVisible(true);
    }
    return;
  }

  final direction = _scrollController.position.userScrollDirection;
  if (_scrollController.position.pixels < 100) {
    if (!menu.isVisible) {
      menu.setMenuVisible(true);
    }
    return;
  }

  if (direction == ScrollDirection.reverse) {
    if (menu.isVisible) {
      menu.setMenuVisible(false);
    }
  } else if (direction == ScrollDirection.forward) {
    if (!menu.isVisible) {
      menu.setMenuVisible(true);
    }
  }
}
```

**Domain Logic 包裝**:
```dart
// 連接狀態處理
Widget _wrapWithConnectionHandler(Widget child) {
  return Consumer(
    builder: (context, ref, _) {
      final connectionState = ref.watch(connectionProvider);
      return connectionState.isConnected
          ? child
          : NoConnectionOverlay(child: child);
    },
  );
}

// 橫幅處理
Widget _wrapWithBannerHandler(Widget child) {
  return BannerAwareWidget(child: child);
}
```

### Phase 3: 漸進替換（3-4 週）

#### 3.1 功能開關機制

```dart
// 全域功能開關
class FeatureFlags {
  static const bool useUiKitPageView = false; // 預設關閉，安全優先
}

// 頁面層級開關（更細粒度控制）
class PageMigrationFlags {
  static const Map<String, bool> pageMigrationStatus = {
    'settings_page': false,
    'network_page': false,
    'device_list_page': false,
    // ... 其他頁面
  };
}
```

#### 3.2 條件渲染機制

```dart
// 在每個頁面中使用
Widget buildSettingsPage() {
  final useExperimental = FeatureFlags.useUiKitPageView &&
                         PageMigrationFlags.pageMigrationStatus['settings_page'] == true;

  return useExperimental
      ? ExperimentalUiKitPageView(
          title: 'Settings',
          bottomBar: PageBottomBar(
            isPositiveEnabled: true,
            onPositiveTap: () => _saveSettings(),
          ),
          child: (context, constraints) => SettingsContent(),
        )
      : StyledAppPageView(
          title: 'Settings',
          bottomBar: PageBottomBar(
            isPositiveEnabled: true,
            onPositiveTap: () => _saveSettings(),
          ),
          child: (context, constraints) => SettingsContent(),
        );
}
```

#### 3.3 分批遷移計劃

**第一批（低複雜度頁面）**:
- 基礎設定頁面
- 關於頁面
- 說明頁面

**第二批（中等複雜度頁面）**:
- 含選單的頁面
- 含底部操作欄的頁面

**第三批（高複雜度頁面）**:
- 含分頁的頁面
- 使用 Sliver AppBar 的頁面

**第四批（最高複雜度頁面）**:
- 含自定義滾動邏輯的頁面
- 多功能組合的複雜頁面

### Phase 4: 完全替換（1 週）

#### 4.1 重新命名和清理

```bash
# 1. 重新命名實驗性組件
mv experimental_ui_kit_page_view.dart new_styled_app_page_view.dart

# 2. 備份舊實現
mv styled_page_view.dart legacy_styled_page_view.dart

# 3. 替換新實現
mv new_styled_app_page_view.dart styled_page_view.dart

# 4. 移除功能開關
# 移除所有 FeatureFlags 相關代碼

# 5. 清理測試代碼
rm -rf test_pages/
rm -rf test_utils/migration_analyzer.dart
```

#### 4.2 驗證和最終測試

- 運行完整測試套件
- 手動測試所有頁面功能
- 驗證響應式佈局
- 驗證主題切換
- 驗證所有互動邏輯

## 風險評估和應對策略

### 高風險點

1. **Sliver 滾動協調**
   - 風險: CustomScrollView 和 TabBarView 的滾動衝突
   - 應對: 詳細測試滾動行為，必要時調整滾動物理

2. **自定義滾動邏輯**
   - 風險: PrivacyGUI 的選單隱藏邏輯可能與 UI Kit 衝突
   - 應對: 在包裝器中保留完整的滾動監聽邏輯

3. **主題適配**
   - 風險: UI Kit 主題系統與 PrivacyGUI 現有主題不兼容
   - 應對: 創建主題橋接適配器

4. **響應式佈局差異**
   - 風險: UI Kit 的響應式斷點與 PrivacyGUI 預期不符
   - 應對: 使用 UI Kit 的佈局系統，但保留必要的自定義邏輯

### 應急預案

1. **快速回滾機制**
   - 保留功能開關直到確認穩定
   - 保留舊實現作為備份
   - 建立自動化測試來快速驗證功能

2. **分階段部署**
   - 先在測試環境完整驗證
   - 逐步在生產環境中啟用
   - 監控用戶反饋和錯誤率

## 成功指標

### 技術指標
- [ ] 100% API 兼容性
- [ ] 所有現有功能正常運作
- [ ] 響應式佈局在所有設備上正確顯示
- [ ] 主題切換無異常
- [ ] 性能無降級

### 專案指標
- [ ] 移除 privacy_widget 依賴
- [ ] 代碼量減少
- [ ] 維護性提升
- [ ] UI 一致性改善

## 預期效益

### 短期效益
✅ **程式碼統一**: 使用統一的 UI 組件系統
✅ **維護性提升**: 減少重複代碼
✅ **主題一致性**: 完全遵循 UI Kit 設計系統

### 長期效益
✅ **依賴簡化**: 移除 privacy_widget 依賴
✅ **升級便利**: 跟隨 UI Kit 的更新和改進
✅ **團隊效率**: 開發團隊只需維護一套 UI 系統

## 時間估算

| 階段 | 預估時間 | 關鍵里程碑 |
|------|----------|------------|
| Phase 1: 實驗驗證 | 1-2 週 | ExperimentalUiKitPageView 完成 |
| Phase 2: 功能對齊 | 2-3 週 | 100% 功能兼容性達成 |
| Phase 3: 漸進替換 | 3-4 週 | 所有頁面成功遷移 |
| Phase 4: 完全替換 | 1 週 | 舊代碼完全移除 |
| **總計** | **7-10 週** | **完整移除 privacy_widget 依賴** |

## 注意事項

1. **憲章遵循**: 確保所有新增組件遵循 UI Kit 憲章
2. **測試覆蓋**: 每個功能點都要有對應的測試用例
3. **文檔更新**: 及時更新相關文檔和範例
4. **團隊溝通**: 定期同步進度，及時解決問題
5. **用戶體驗**: 確保遷移過程不影響用戶使用

---

**建立日期**: 2025-12-10
**版本**: v1.0
**負責人**: [待指定]
**狀態**: 規劃階段