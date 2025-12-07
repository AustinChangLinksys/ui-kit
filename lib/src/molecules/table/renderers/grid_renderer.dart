import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/src/molecules/table/widgets/table_header.dart';
import 'package:ui_kit_library/ui_kit.dart';

class GridRenderer<T> extends StatelessWidget {
  final List<T> data;
  final List<AppTableColumn<T>> columns;
  final int? editingRowIndex;
  final ValueChanged<int> onEdit;
  final VoidCallback onCancel;
  final ValueChanged<T> onSave;
  final AppTableLocalization localization;

  const GridRenderer({
    super.key,
    required this.data,
    required this.columns,
    required this.editingRowIndex,
    required this.onEdit,
    required this.onCancel,
    required this.onSave,
    required this.localization,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    return LayoutBuilder(builder: (context, constraints) {
      final isDesktop =
          constraints.maxWidth > theme.layoutSpec.breakpointDesktop;

      // Action column width must match between header and data rows
      final hasActionLabel = localization.actions != null;
      final actionColumnWidth = hasActionLabel ? 160.0 : 100.0;

      return Column(
        children: [
          // Header always includes action column to match data row alignment
          TableHeader(
            columns: [
              ...columns,
              AppTableColumn(
                label: localization.actions ?? '',
                width: actionColumnWidth,
                cellBuilder: (_, __) => const SizedBox(),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final item = data[index];
                final isEditing = editingRowIndex == index;
                final isDimmed = editingRowIndex != null && !isEditing;

                return _DataRow(
                  item: item,
                  columns: columns,
                  index: index,
                  isEditing: isEditing,
                  isDimmed: isDimmed,
                  isDesktop: isDesktop,
                  onEdit: () => onEdit(index),
                  onCancel: onCancel,
                  onSave: () => onSave(item),
                  localization: localization,
                  showActionsColumn: hasActionLabel,
                );
              },
            ),
          ),
        ],
      );
    });
  }
}

class _DataRow<T> extends StatefulWidget {
  final T item;
  final List<AppTableColumn<T>> columns;
  final int index;
  final bool isEditing;
  final bool isDimmed;
  final bool isDesktop;
  final VoidCallback onEdit;
  final VoidCallback onCancel;
  final VoidCallback onSave;
  final AppTableLocalization localization;
  final bool showActionsColumn;

  const _DataRow({
    required this.item,
    required this.columns,
    required this.index,
    required this.isEditing,
    required this.isDimmed,
    required this.isDesktop,
    required this.onEdit,
    required this.onCancel,
    required this.onSave,
    required this.localization,
    required this.showActionsColumn,
  });

  @override
  State<_DataRow<T>> createState() => _DataRowState<T>();
}

class _DataRowState<T> extends State<_DataRow<T>> {
  bool _isHovered = false;
  final _formKey = GlobalKey<FormState>();

  /// Builds an action button - uses AppIconButton if no label, AppButton if label provided
  Widget _buildActionButton({
    required String? label,
    required IconData icon,
    required VoidCallback? onTap,
    required SurfaceVariant variant,
    AppButtonSize size = AppButtonSize.small,
  }) {
    if (label != null) {
      return AppButton(
        label: label,
        icon: Icon(icon, size: 16),
        onTap: onTap,
        size: size,
        variant: variant,
      );
    }
    return AppIconButton(
      icon: Icon(icon),
      onTap: onTap,
      size: size,
      variant: variant,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final tableStyle = theme.tableStyle;

    // Use TableStyle fields for hover colors (IoC compliance)
    Color? backgroundColor = tableStyle.rowBackground;
    TextStyle cellTextStyle = tableStyle.cellTextStyle;

    if (_isHovered) {
      // Use theme-defined hover colors instead of hardcoded values
      if (tableStyle.hoverRowBackground != null) {
        backgroundColor = tableStyle.hoverRowBackground;
      }
      if (tableStyle.hoverRowContentColor != null) {
        cellTextStyle = cellTextStyle.copyWith(
          color: tableStyle.hoverRowContentColor,
        );
      }
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedOpacity(
        duration: tableStyle.modeTransitionDuration,
        opacity: widget.isDimmed ? 0.5 : 1.0,
        child: AppSurface(
          style: theme.surfaceBase.copyWith(
            backgroundColor: backgroundColor,
            customBorder:
                tableStyle.showVerticalGrid && tableStyle.gridWidth > 0
                    ? Border(
                        bottom: BorderSide(
                          color: tableStyle.gridColor,
                          width: tableStyle.gridWidth,
                        ),
                      )
                    : null,
            shadows: [],
            borderRadius: 0,
          ),
          padding: EdgeInsets.zero,
          child: Form(
            key: _formKey,
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ...widget.columns.map((col) {
                    final showBorder =
                        tableStyle.showVerticalGrid && tableStyle.gridWidth > 0;

                    final cell = Container(
                      padding: tableStyle.cellPadding,
                      alignment: Alignment.centerLeft,
                      decoration: showBorder
                          ? BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: tableStyle.gridColor,
                                  width: tableStyle.gridWidth,
                                ),
                              ),
                            )
                          : null,
                      child: DefaultTextStyle.merge(
                        style: cellTextStyle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        child: AnimatedSwitcher(
                          duration: tableStyle.modeTransitionDuration,
                          child: widget.isEditing && widget.isDesktop
                              ? KeyedSubtree(
                                  key: ValueKey('edit-${col.label}'),
                                  child: col.editBuilder
                                          ?.call(context, widget.item) ??
                                      col.cellBuilder(context, widget.item),
                                )
                              : KeyedSubtree(
                                  key: ValueKey('view-${col.label}'),
                                  child: col.cellBuilder(context, widget.item),
                                ),
                        ),
                      ),
                    );

                    if (col.width != null) {
                      return SizedBox(width: col.width, child: cell);
                    } else {
                      return Expanded(flex: col.flex, child: cell);
                    }
                  }),
                  // Actions Column
                  Container(
                    width: widget.showActionsColumn ? 160 : 100,
                    padding: tableStyle.cellPadding,
                    alignment: Alignment.centerRight,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        // Only show Save/Cancel inline for desktop mode
                        // Non-desktop mode shows Edit button (editing happens in dialog)
                        children: widget.isEditing && widget.isDesktop
                          ? [
                              _buildActionButton(
                                label: widget.localization.save,
                                icon: widget.localization.saveIcon,
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    AppFeedback.onSuccess();
                                    widget.onSave();
                                  } else {
                                    AppFeedback.onError();
                                  }
                                },
                                variant: SurfaceVariant.highlight,
                              ),
                              const Gap(8),
                              _buildActionButton(
                                label: widget.localization.cancel,
                                icon: widget.localization.cancelIcon,
                                onTap: () {
                                  AppFeedback.onSelection();
                                  widget.onCancel();
                                },
                                variant: SurfaceVariant.base,
                              ),
                            ]
                          : [
                              _buildActionButton(
                                label: widget.localization.edit,
                                icon: widget.localization.editIcon,
                                onTap: () {
                                  AppFeedback.onInteraction();
                                  widget.onEdit();
                                  if (!widget.isDesktop) {
                                    _showEditDialog(context);
                                  }
                                },
                                variant: SurfaceVariant.tonal,
                              ),
                            ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showEditDialog(BuildContext context) {
    final dialogFormKey = GlobalKey<FormState>();
    final loc = widget.localization;

    showAppDialog(
      context: context,
      builder: (dialogContext) => AppDialog(
        titleText: loc.editRowTitle,
        content: Form(
          key: dialogFormKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...widget.columns.map(
                (col) => Padding(
                  padding: const EdgeInsets.only(bottom: 12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppText(col.label, variant: AppTextVariant.labelSmall),
                      const Gap(4),
                      col.editBuilder?.call(dialogContext, widget.item) ??
                          col.cellBuilder(dialogContext, widget.item),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        actions: [
          _buildActionButton(
            label: loc.cancel,
            icon: loc.cancelIcon,
            onTap: () {
              AppFeedback.onSelection();
              Navigator.of(dialogContext).pop();
              widget.onCancel();
            },
            variant: SurfaceVariant.base,
            size: AppButtonSize.medium,
          ),
          _buildActionButton(
            label: loc.save,
            icon: loc.saveIcon,
            onTap: () {
              if (dialogFormKey.currentState!.validate()) {
                AppFeedback.onSuccess();
                Navigator.of(dialogContext).pop();
                widget.onSave();
              } else {
                AppFeedback.onError();
              }
            },
            variant: SurfaceVariant.highlight,
            size: AppButtonSize.medium,
          ),
        ],
      ),
    );
  }
}
