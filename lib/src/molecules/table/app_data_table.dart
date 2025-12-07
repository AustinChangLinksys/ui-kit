import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/foundation/theme/tokens/app_theme.dart';
import 'package:ui_kit_library/src/molecules/table/renderers/card_renderer.dart';
import 'package:ui_kit_library/src/molecules/table/renderers/grid_renderer.dart';
import 'package:ui_kit_library/src/molecules/table/table_column.dart';
import 'package:ui_kit_library/src/molecules/table/table_localization.dart';
import 'package:ui_kit_library/src/molecules/table/widgets/table_pagination.dart';

class AppDataTable<T> extends StatefulWidget {
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
  final AppTableLocalization localization;

  const AppDataTable({
    super.key,
    required this.data,
    required this.columns,
    required this.totalRows,
    required this.currentPage,
    required this.rowsPerPage,
    required this.onPageChanged,
    this.onSave,
    this.emptyMessage,
    this.localization = const AppTableLocalization(),
  });

  @override
  State<AppDataTable<T>> createState() => _AppDataTableState<T>();
}

class _AppDataTableState<T> extends State<AppDataTable<T>> {
  int? _editingRowIndex;

  void _onEdit(int index) {
    setState(() => _editingRowIndex = index);
  }

  void _onCancel() {
    setState(() => _editingRowIndex = null);
  }

  Future<void> _onSave(T item) async {
    if (widget.onSave != null) {
      await widget.onSave!(item);
    }
    _onCancel();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final theme = AppTheme.of(context);
        final isMobile =
            theme.layoutSpec.isMobile(constraints.maxWidth);

        return Column(
          children: [
            Expanded(
              child: isMobile
                  ? CardRenderer<T>(
                      data: widget.data,
                      columns: widget.columns,
                      editingRowIndex: _editingRowIndex,
                      onEdit: _onEdit,
                      onCancel: _onCancel,
                      onSave: _onSave,
                      localization: widget.localization,
                    )
                  : GridRenderer<T>(
                      data: widget.data,
                      columns: widget.columns,
                      editingRowIndex: _editingRowIndex,
                      onEdit: _onEdit,
                      onCancel: _onCancel,
                      onSave: _onSave,
                      localization: widget.localization,
                    ),
            ),
            if (widget.totalRows > 0)
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                child: TablePagination(
                  totalRows: widget.totalRows,
                  currentPage: widget.currentPage,
                  rowsPerPage: widget.rowsPerPage,
                  onPageChanged: widget.onPageChanged,
                  localization: widget.localization,
                ),
              ),
          ],
        );
      },
    );
  }
}