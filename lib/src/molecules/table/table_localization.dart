import 'package:flutter/material.dart';

/// Localization configuration for AppDataTable.
///
/// By default, buttons use icons only. Labels can be optionally provided
/// for accessibility or explicit text display.
class AppTableLocalization {
  /// Label for edit action. If null, only icon is shown.
  final String? edit;

  /// Label for save action. If null, only icon is shown.
  final String? save;

  /// Label for cancel action. If null, only icon is shown.
  final String? cancel;

  /// Header label for actions column.
  final String? actions;

  /// Title for edit row dialog/sheet.
  final String? editRowTitle;

  /// Label for previous page. If null, only icon is shown.
  final String? prev;

  /// Label for next page. If null, only icon is shown.
  final String? next;

  /// Function to format page indicator text.
  /// Defaults to "1 / 5" format.
  final String Function(int current, int total) pageIndicator;

  /// Icons for table actions.
  final IconData editIcon;
  final IconData saveIcon;
  final IconData cancelIcon;
  final IconData prevIcon;
  final IconData nextIcon;

  const AppTableLocalization({
    this.edit,
    this.save,
    this.cancel,
    this.actions,
    this.editRowTitle,
    this.prev,
    this.next,
    this.pageIndicator = _defaultPageIndicator,
    this.editIcon = Icons.edit_outlined,
    this.saveIcon = Icons.check,
    this.cancelIcon = Icons.close,
    this.prevIcon = Icons.chevron_left,
    this.nextIcon = Icons.chevron_right,
  });

  static String _defaultPageIndicator(int current, int total) =>
      '$current / $total';
}
