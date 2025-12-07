import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

class _User {
  final String name;
  final String email;
  final String role;

  _User(this.name, this.email, this.role);
}

final _users = List.generate(
  20,
  (index) => _User('User $index', 'user$index@example.com',
      index % 2 == 0 ? 'Admin' : 'User'),
);

final _columns = [
  AppTableColumn<_User>(
    label: 'Name',
    flex: 2,
    cellBuilder: (context, user) => AppText.bodyMedium(user.name),
    editBuilder: (context, user) => AppTextFormField(initialValue: user.name),
  ),
  AppTableColumn<_User>(
    label: 'Email',
    flex: 3,
    cellBuilder: (context, user) => AppText.bodyMedium(user.email),
    editBuilder: (context, user) => AppTextFormField(initialValue: user.email),
  ),
  AppTableColumn<_User>(
    label: 'Role',
    flex: 1,
    cellBuilder: (context, user) =>
        AppTag(label: user.role, isSelected: true),
    editBuilder: (context, user) => AppDropdown<String>(
      value: user.role,
      items: const ['Admin', 'User'],
      onChanged: (_) {},
    ),
  ),
];

@widgetbook.UseCase(name: 'Responsive Table', type: AppDataTable)
Widget responsiveTable(BuildContext context) {
  return AppDataTable<_User>(
    data: _users.take(10).toList(),
    columns: _columns,
    totalRows: 20,
    currentPage: 1,
    rowsPerPage: 10,
    onPageChanged: (_) {},
    localization: const AppTableLocalization(),
    onSave: (user) async {
      await Future.delayed(const Duration(seconds: 1));
    },
  );
}

/// Desktop mode: Inline editing (width > 1200)
@widgetbook.UseCase(name: 'Desktop - Inline Edit', type: AppDataTable)
Widget desktopInlineEdit(BuildContext context) {
  return SizedBox(
    width: 1300,
    height: 400,
    child: AppDataTable<_User>(
      data: _users.take(5).toList(),
      columns: _columns,
      totalRows: 5,
      currentPage: 1,
      rowsPerPage: 10,
      onPageChanged: (_) {},
      localization: const AppTableLocalization(
        actions: 'Actions',
        edit: 'Edit',
        save: 'Save',
        cancel: 'Cancel',
        editRowTitle: 'Edit User',
      ),
      onSave: (user) async {
        await Future.delayed(const Duration(milliseconds: 500));
      },
    ),
  );
}

/// Tablet mode: Dialog editing (900 <= width <= 1200)
@widgetbook.UseCase(name: 'Tablet - Dialog Edit', type: AppDataTable)
Widget tabletDialogEdit(BuildContext context) {
  return SizedBox(
    width: 1000,
    height: 400,
    child: AppDataTable<_User>(
      data: _users.take(5).toList(),
      columns: _columns,
      totalRows: 5,
      currentPage: 1,
      rowsPerPage: 10,
      onPageChanged: (_) {},
      localization: const AppTableLocalization(
        actions: 'Actions',
        edit: 'Edit',
        save: 'Save',
        cancel: 'Cancel',
        editRowTitle: 'Edit User',
      ),
      onSave: (user) async {
        await Future.delayed(const Duration(milliseconds: 500));
      },
    ),
  );
}

/// Mobile mode: BottomSheet editing (width < 900)
@widgetbook.UseCase(name: 'Mobile - BottomSheet Edit', type: AppDataTable)
Widget mobileBottomSheetEdit(BuildContext context) {
  return SizedBox(
    width: 400,
    height: 600,
    child: AppDataTable<_User>(
      data: _users.take(3).toList(),
      columns: _columns,
      totalRows: 3,
      currentPage: 1,
      rowsPerPage: 10,
      onPageChanged: (_) {},
      localization: const AppTableLocalization(
        edit: 'Edit',
        save: 'Save',
        cancel: 'Cancel',
        editRowTitle: 'Edit User',
      ),
      onSave: (user) async {
        await Future.delayed(const Duration(milliseconds: 500));
      },
    ),
  );
}

/// Grid Renderer directly - shows inline edit mode
@widgetbook.UseCase(name: 'Grid - Inline Edit Mode', type: GridRenderer)
Widget gridInlineEditMode(BuildContext context) {
  return SizedBox(
    width: 1300,
    height: 300,
    child: Material(
      type: MaterialType.transparency,
      child: GridRenderer<_User>(
        data: _users.take(3).toList(),
        columns: _columns,
        editingRowIndex: 0, // First row in edit mode
        onEdit: (_) {},
        onCancel: () {},
        onSave: (_) {},
        localization: const AppTableLocalization(
          actions: 'Actions',
          save: 'Save',
          cancel: 'Cancel',
        ),
      ),
    ),
  );
}

/// Grid Renderer - shows dimmed state before dialog
@widgetbook.UseCase(name: 'Grid - Dialog Edit State', type: GridRenderer)
Widget gridDialogEditState(BuildContext context) {
  return SizedBox(
    width: 1000,
    height: 300,
    child: Material(
      type: MaterialType.transparency,
      child: GridRenderer<_User>(
        data: _users.take(3).toList(),
        columns: _columns,
        editingRowIndex: 0, // First row selected, others dimmed
        onEdit: (_) {},
        onCancel: () {},
        onSave: (_) {},
        localization: const AppTableLocalization(
          actions: 'Actions',
          save: 'Save',
          cancel: 'Cancel',
        ),
      ),
    ),
  );
}

/// Card Renderer - Mobile card view
@widgetbook.UseCase(name: 'Card View', type: CardRenderer)
Widget cardView(BuildContext context) {
  return SizedBox(
    width: 400,
    height: 500,
    child: Material(
      type: MaterialType.transparency,
      child: CardRenderer<_User>(
        data: _users.take(2).toList(),
        columns: _columns,
        editingRowIndex: null,
        onEdit: (_) {},
        onCancel: () {},
        onSave: (_) {},
        localization: const AppTableLocalization(
          edit: 'Edit',
          save: 'Save',
          cancel: 'Cancel',
          editRowTitle: 'Edit User',
        ),
      ),
    ),
  );
}

/// Empty state
@widgetbook.UseCase(name: 'Empty State', type: AppDataTable)
Widget emptyState(BuildContext context) {
  return SizedBox(
    width: 1000,
    height: 300,
    child: AppDataTable<_User>(
      data: const [],
      columns: _columns,
      totalRows: 0,
      currentPage: 1,
      rowsPerPage: 10,
      onPageChanged: (_) {},
      emptyMessage: 'No users found',
      localization: const AppTableLocalization(),
    ),
  );
}

/// Pagination example
@widgetbook.UseCase(name: 'With Pagination', type: AppDataTable)
Widget withPagination(BuildContext context) {
  return SizedBox(
    width: 1000,
    height: 400,
    child: AppDataTable<_User>(
      data: _users.take(5).toList(),
      columns: _columns,
      totalRows: 50, // 50 total rows, showing page 2
      currentPage: 2,
      rowsPerPage: 5,
      onPageChanged: (_) {},
      localization: const AppTableLocalization(
        prev: '← Previous',
        next: 'Next →',
      ),
    ),
  );
}
