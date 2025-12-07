# Table View Contracts

This file defines the contract interfaces for the Table View feature.
*Note: This is a specification file. Actual implementation is in `lib/src/molecules/table/` and `lib/src/foundation/theme/styles/table_style.dart`.*

```dart
import 'package:flutter/widgets.dart';
import 'package:theme_tailor/theme_tailor.dart';

part 'table_style.tailor.dart';

/// Theme Extension for Table View
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

  TableStyle({
    required this.headerBackground,
    required this.rowBackground,
    required this.gridColor,
    required this.gridWidth,
    required this.showVerticalGrid,
    required this.cellPadding,
    required this.rowHeight,
    required this.headerTextStyle,
    required this.cellTextStyle,
    required this.invertRowOnHover,
    required this.glowRowOnHover,
  });
}

/// Column Definition
class AppTableColumn<T> {
  final String label;
  final int flex;
  final double? width;
  final Widget Function(BuildContext context, T item) cellBuilder;
  /// Builder for edit mode. Can return specialized inputs (IPv4, MAC, etc.).
  /// If null, a default text input is used.
  final Widget Function(BuildContext context, T item)? editBuilder;
  final bool sortable;

  AppTableColumn({
    required this.label,
    this.flex = 1,
    this.width,
    required this.cellBuilder,
    this.editBuilder,
    this.sortable = false,
  });
}

/// Main Widget Contract
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

  const AppDataTable({
    super.key,
    required this.data,
    required this.columns,
    required this.onPageChanged,
    this.totalRows = 0,
    this.currentPage = 1,
    this.rowsPerPage = 10, // Default to 10 rows per page
    this.onSave,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
```
