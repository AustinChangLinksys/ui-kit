# Technical Implementation Plan: AppDataTable Component

**Branch:** `018-table-view`
**Goal:** Implement a responsive, style-adaptive Data Table with single-row editing.
**Dependencies:** `AppColorScheme`, `AppMotion`, `AppFeedback`, `AppTypography`.
**Tools:** `theme_tailor`, `widgetbook`, `flutter_test`.

## 1. Technical Context

### Requirements Analysis

The component requires a complex combination of **Layout Adaptation** (Grid vs List), **Style Differentiation** (Pixel Grid vs Glass Blur), and **Interaction Management** (Edit State, Pagination).

### Technology Choices

* **Layout:** `LayoutBuilder` + `Flex/Row` for Desktop headers to ensure alignment. `ListView` for content.
* **State Management:** Internal transient state for "Edit Mode" (which row is active) and "Pagination" (current page). Callbacks for data persistence.
* **Rendering:**
    * **Pixel Mode:** Uses `CustomPaint` or `Container(decoration: BoxDecoration(border: ...))` for hard grid lines.
    * **Glass Mode:** Uses `BackdropFilter` for translucent rows.
* **Styling:** A new `TableStyle` theme extension will be created to encapsulate style-specific metrics (padding, border visibility) to avoid `if/else` clutter in the widget tree.

## 2. Constitution Compliance Check

### Compliance Analysis

* **[2.1 Physical Isolation]**: Component resides in `lib/src/molecules/table/` (or `organisms` due to complexity).
* **[3.1 Inversion of Control]**: The table asks `AppTheme` for its look (colors, grid lines). It does not decide "I am Pixel".
* **[4.1 Color System]**: Uses `AppColorScheme.styleBackground`, `highContrastBorder`, and `signalStrong`. No hardcoded colors.
* **[5.1 Motion System]**: Row transitions use `AppMotion.medium` (Glass) or `Duration.zero` (Pixel).
* **[5.2 Feedback System]**: Triggers `AppFeedback.onTap(heavy)` when entering Edit Mode in Pixel style.
* **[6.1 Primitive]**: The root container and rows MUST be composed of `AppSurface` to handle the heavy lifting of shadows and borders.

### Gate Evaluation

* **Gate Passed:** The architecture aligns with v3.0 standards.

## 3. Phase 0: Research (Skipped)

* **Skipped:** Requirements and visual strategies are fully defined in the Spec.

## 4. Phase 1: Design & Contracts

### Theme Contract (`TableStyle`)

To support TR-002 (Style Adaptability), we will define a new Theme Extension.

```dart
// lib/src/foundation/theme/styles/table_style.dart
@TailorMixin()
class TableStyle extends ThemeExtension<TableStyle> with _$TableStyleTailorMixin {
  // Appearance
  final Color? headerBackground; // Nullable for Glass (transparent)
  final Color rowBackground;
  final Color gridColor;
  final double gridWidth; // 0.0 for Glass, 1.0+ for Pixel
  final bool showVerticalGrid;
  
  // Metrics
  final EdgeInsetsGeometry cellPadding; // Dense vs Spacious
  final double rowHeight;
  final TextStyle headerTextStyle;
  final TextStyle cellTextStyle;
  
  // Behavior
  final bool invertRowOnHover; // For Pixel style
  final bool glowRowOnHover;   // For Glass style
  
  // ... constructor
}
```

* **Factory Integration:** This will be added to `AppDesignTheme` factories.
    * **Pixel:** `gridWidth: 1.0`, `invertRowOnHover: true`, `cellPadding: 8px`.
    * **Glass:** `gridWidth: 0.0`, `headerBackground: null`, `cellPadding: 16px`.

### API Contract (`AppDataTable`)

```dart
class AppDataTable<T> extends StatelessWidget {
  // --- Data Inputs ---
  
  /// The specific subset of data to display for the current page.
  /// NOT the full dataset. 
  /// Example: If page=2 and size=10, this list should contain items 11-20.
  final List<T> data; 
  
  final List<AppTableColumn<T>> columns;
  
  // --- Pagination State (Controlled) ---
  
  /// The total number of items available on the server/source.
  /// Used to calculate the "Total Pages" count in the footer.
  final int totalRows; 
  
  /// The current active page index (0-based or 1-based, defined by team standard).
  final int currentPage;
  
  /// How many rows to show per page.
  final int rowsPerPage;

  // --- Callbacks ---
  
  /// Triggered when user clicks "Next/Prev" or specific page number.
  /// The parent widget MUST fetch new data and update the `data` list.
  final ValueChanged<int> onPageChanged;
  
  final Future<void> Function(T item)? onSave;
  
  // Configuration
  final String? emptyMessage;
}
```

## 5. Implementation Steps

### Step 1: Theme Infrastructure

1. **Create `TableStyle`:** Implement the class in `foundation/theme/styles/table_style.dart`.
2. **Update Factories:** Inject `TableStyle` into `NeumorphicDesignTheme`, `PixelDesignTheme`, etc., using values derived from `AppColorScheme` (e.g., `gridColor` = `appColors.subtleBorder`).
3. **Generate:** Run `build_runner`.

### Step 2: Atomic Components (The Building Blocks)

1. **Implement `_TableHeader`:**
    * Uses `TableStyle.headerBackground`.
    * Renders labels based on `columns` flex/width.
    * **Pixel:** Adds bottom border `highContrastBorder`.
2. **Implement `_TablePagination`:**
    * Adapts layout based on Style (Toolbar vs Floating Pills).
    * Uses `AppButton` (which auto-adapts to style).

### Step 3: Layout Logic (The Engine)

1. **Create `AppDataTable` Scaffold:**
    * Use `LayoutBuilder` to detect mobile breakpoint (< 600px).
2. **Implement Desktop View (`_GridRenderer`):**
    * Render a `Column` of `_DataRow`s.
    * **Row Logic:** Wrap each row in `AppSurface`.
    * **Hover Logic:** Use `MouseRegion` to trigger `invertRowOnHover` or `glowRowOnHover`.
3. **Implement Mobile View (`_CardRenderer`):**
    * Map `columns` to a `Column` (Label: Value) inside an `AppCard`.
    * Ensure density is reset to `1.0x` for touch targets.

### Step 4: Interaction & Editing

1. **Edit State Manager:** Use a local `StatefulWidget` to track `editingRowIndex`.
2. **Edit UI Switch:**
    * If `editingRowIndex == index`: Render the widget returned by `column.editBuilder`.
    * **Flexibility:** Ensure support for diverse input types (IPv4, IPv6, MAC Address, Range Sliders) by allowing `editBuilder` to return any Widget.
    * Fallback: If `editBuilder` is null, default to a standard `AppTextFormField`.
    * Else (not editing): Render the widget returned by `column.cellBuilder`.
3. **Motion Integration:**
    * Wrap mode switch in `AnimatedSwitcher` or `AnimatedContainer`.
    * Inject `AppTheme.motion.duration` (0ms for Pixel, 300ms+ for others).
4. **Feedback Integration Strategy**:
    Component must call `AppTheme.feedback` methods based on the following mapping. Do not hardcode HapticFeedback types.

    | User Action       | `AppFeedback` Method | Pixel Implementation (Expected)      | Glass Implementation (Expected)     |
    |-------------------|----------------------|--------------------------------------|-------------------------------------|
    | Enter Edit Mode   | `.onInteraction()`   | Heavy Impact + Mechanical Click      | Light Impact + Glass Tap            |
    | Save / Confirm    | `.onSuccess()`       | Success Pattern + 8-bit Chime        | Success Pattern + Ethereal Hum      |
    | Validation Error  | `.onError()`         | Double Heavy Impact + Buzz           | Heavy Impact + Glass Break          |
    | Cancel / Back     | `.onSelection()`     | Light Impact                         | Light Impact                        |
    | Page Change       | `.onSelection()`     | Light Impact                         | Light Impact                        |

### Step 5: Verification & Polish

1. **Style Verification:** Check Grid Lines in Pixel mode vs Blur in Glass mode.
2. **Semantic Check:** Ensure Error states use `AppColorScheme.error`.
3.  **Widgetbook:** Create stories for "Desktop Grid", "Mobile Card", "Editing State".