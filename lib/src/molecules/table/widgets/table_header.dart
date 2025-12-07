import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

class TableHeader<T> extends StatelessWidget {
  final List<AppTableColumn<T>> columns;

  const TableHeader({
    super.key,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final tableStyle = theme.tableStyle;

    final showBorder = tableStyle.showVerticalGrid && tableStyle.gridWidth > 0;

    return Container(
      decoration: BoxDecoration(
        color: tableStyle.headerBackground,
        border: showBorder
            ? Border(
                bottom: BorderSide(
                  color: tableStyle.gridColor,
                  width: tableStyle.gridWidth,
                ),
              )
            : null,
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: columns.map((col) {
            final isLast = col == columns.last;
            final showBorder =
                tableStyle.showVerticalGrid && tableStyle.gridWidth > 0;

            final cell = Container(
              padding: tableStyle.cellPadding,
              alignment: Alignment.centerLeft,
              decoration: showBorder && !isLast
                  ? BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: tableStyle.gridColor,
                          width: tableStyle.gridWidth,
                        ),
                      ),
                    )
                  : null,
              child: Text(
                col.label,
                style: tableStyle.headerTextStyle,
              ),
            );

            if (col.width != null) {
              return SizedBox(width: col.width, child: cell);
            } else {
              return Expanded(flex: col.flex, child: cell);
            }
          }).toList(),
        ),
      ),
    );
  }
}
