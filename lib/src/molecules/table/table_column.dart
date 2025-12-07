import 'package:flutter/material.dart';

class AppTableColumn<T> {
  final String label;
  final int flex;
  final double? width;
  final Widget Function(BuildContext, T) cellBuilder;
  final Widget Function(BuildContext, T)? editBuilder;
  final bool sortable;

  const AppTableColumn({
    required this.label,
    this.flex = 1,
    this.width,
    required this.cellBuilder,
    this.editBuilder,
    this.sortable = false,
  });
}
