import 'package:alchemist/alchemist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_kit_library/ui_kit.dart';

// Import test utilities
import '../../test_utils/golden_test_matrix_factory.dart';
import '../../test_utils/font_loader.dart';

/// Test data model
class _User {
  final String name;
  final String email;
  final String status;

  _User(this.name, this.email, this.status);
}

/// Network config data model for multi-input error showcase
class _NetworkConfig {
  final String name;
  final String ipv4;
  final String ipv6;
  final String mac;
  final String protocol;

  _NetworkConfig({
    required this.name,
    required this.ipv4,
    required this.ipv6,
    required this.mac,
    required this.protocol,
  });
}

/// Protocol options for dropdown
const _protocolOptions = ['TCP', 'UDP', 'HTTP', 'HTTPS'];

/// Sample network config data with invalid values
final _networkData = [
  _NetworkConfig(
    name: 'Server 1',
    ipv4: '999.999.999.999', // Invalid IPv4
    ipv6: 'invalid::ipv6', // Invalid IPv6
    mac: 'XX:XX:XX', // Invalid MAC
    protocol: 'TCP',
  ),
  _NetworkConfig(
    name: 'Server 2',
    ipv4: '192.168.1.1',
    ipv6: '::1',
    mac: 'AA:BB:CC:DD:EE:FF',
    protocol: 'HTTPS',
  ),
];

/// Sample test data
final _data = [
  _User('Alice', 'alice@example.com', 'Active'),
  _User('Bob', 'bob@example.com', 'Pending'),
  _User('Charlie', 'charlie@example.com', 'Inactive'),
];

/// Standard columns for testing
final _columns = [
  AppTableColumn<_User>(
    label: 'Name',
    cellBuilder: (_, user) => Text(user.name),
  ),
  AppTableColumn<_User>(
    label: 'Email',
    cellBuilder: (_, user) => Text(user.email),
  ),
  AppTableColumn<_User>(
    label: 'Status',
    cellBuilder: (_, user) => Text(user.status),
  ),
];

/// Editable columns for edit mode testing
final _editableColumns = [
  AppTableColumn<_User>(
    label: 'Name',
    cellBuilder: (_, user) => Text(user.name),
    editBuilder: (_, user) => AppTextFormField(
      initialValue: user.name,
    ),
  ),
  AppTableColumn<_User>(
    label: 'Email',
    cellBuilder: (_, user) => Text(user.email),
    editBuilder: (_, user) => AppTextFormField(
      initialValue: user.email,
    ),
  ),
];

/// Editable columns WITH ERRORS for error state testing
/// Demonstrates "No Layout Shift" error handling in table edit mode
final _editableColumnsWithError = [
  AppTableColumn<_User>(
    label: 'Name',
    cellBuilder: (_, user) => Text(user.name),
    editBuilder: (_, user) => AppTextField(
      hintText: user.name,
      errorText: 'Name is required', // Error state
    ),
  ),
  AppTableColumn<_User>(
    label: 'Email',
    cellBuilder: (_, user) => Text(user.email),
    editBuilder: (_, user) => AppTextField(
      hintText: user.email,
      errorText: 'Invalid email format', // Error state
    ),
  ),
];

/// Network config columns with multiple input types and errors
/// Showcases IPv4, IPv6, MAC, and Number inputs with validation errors
final _networkColumnsWithErrors = [
  // Text field for name
  AppTableColumn<_NetworkConfig>(
    label: 'Name',
    cellBuilder: (_, config) => Text(config.name),
    editBuilder: (_, config) => AppTextField(
      hintText: config.name,
      errorText: 'Server name required',
    ),
  ),
  // IPv4 input with error
  AppTableColumn<_NetworkConfig>(
    label: 'IPv4',
    cellBuilder: (_, config) => Text(config.ipv4),
    editBuilder: (_, config) => Form(
      autovalidateMode: AutovalidateMode.always,
      child: AppIpv4TextField(
        label: 'IPv4',
        validator: (_) => 'Invalid IPv4 address',
      ),
    ),
  ),
  // IPv6 input with error
  AppTableColumn<_NetworkConfig>(
    label: 'IPv6',
    cellBuilder: (_, config) => Text(config.ipv6),
    editBuilder: (_, config) => Form(
      autovalidateMode: AutovalidateMode.always,
      child: AppIPv6TextField(
        label: 'IPv6',
        invalidFormatMessage: 'Invalid IPv6 format',
        controller: TextEditingController(text: 'invalid'),
      ),
    ),
  ),
  // MAC address input with error
  AppTableColumn<_NetworkConfig>(
    label: 'MAC',
    cellBuilder: (_, config) => Text(config.mac),
    editBuilder: (_, config) => Form(
      autovalidateMode: AutovalidateMode.always,
      child: AppMacAddressTextField(
        label: 'MAC',
        invalidFormatMessage: 'Invalid MAC format',
        controller: TextEditingController(text: 'XX:XX'),
      ),
    ),
  ),
  // Dropdown for protocol selection
  AppTableColumn<_NetworkConfig>(
    label: 'Protocol',
    cellBuilder: (_, config) => Text(config.protocol),
    editBuilder: (_, config) => AppDropdown<String>(
      items: _protocolOptions,
      value: config.protocol,
      hint: 'Select protocol',
      onChanged: (_) {},
    ),
  ),
];

void main() {
  // Setup: Load fonts for consistent golden rendering
  setUpAll(() async {
    await loadAppFonts();
  });

  group('AppDataTable Golden Tests', () {
    // ============================================
    // Grid Mode Tests (width >= 900 for desktop)
    // ============================================

    // Test 1: Grid View (Desktop) - Default rendering
    goldenTest(
      'AppDataTable - Grid View',
      fileName: 'table_grid_view',
      builder: () => buildThemeMatrix(
        name: 'Grid View',
        width: 950, // >= 900 for grid mode
        height: 280,
        child: AppDataTable<_User>(
          data: _data,
          columns: _columns,
          totalRows: 3,
          currentPage: 1,
          rowsPerPage: 10,
          onPageChanged: (_) {},
          localization: const AppTableLocalization(),
        ),
      ),
    );

    // Test 2: Grid View with Pagination
    goldenTest(
      'AppDataTable - Grid Pagination',
      fileName: 'table_grid_pagination',
      builder: () => buildThemeMatrix(
        name: 'Grid Pagination',
        width: 950,
        height: 300,
        child: AppDataTable<_User>(
          data: _data,
          columns: _columns,
          totalRows: 30, // More rows to show pagination
          currentPage: 2,
          rowsPerPage: 3,
          onPageChanged: (_) {},
          localization: const AppTableLocalization(),
        ),
      ),
    );

    // Test 3: Grid View with Actions
    goldenTest(
      'AppDataTable - Grid Actions',
      fileName: 'table_grid_actions',
      builder: () => buildThemeMatrix(
        name: 'Grid Actions',
        width: 950,
        height: 280,
        child: AppDataTable<_User>(
          data: _data,
          columns: _editableColumns,
          totalRows: 3,
          currentPage: 1,
          rowsPerPage: 10,
          onPageChanged: (_) {},
          onSave: (_) async {},
          localization: const AppTableLocalization(),
        ),
      ),
    );

    // ============================================
    // Card Mode Tests (width < 900 for mobile)
    // ============================================

    // Test 4: Card View (Mobile)
    goldenTest(
      'AppDataTable - Card View',
      fileName: 'table_card_view',
      builder: () => buildThemeMatrix(
        name: 'Card View',
        width: 400, // < 900 for card mode
        height: 500,
        child: AppDataTable<_User>(
          data: _data.take(2).toList(),
          columns: _columns,
          totalRows: 2,
          currentPage: 1,
          rowsPerPage: 10,
          onPageChanged: (_) {},
          localization: const AppTableLocalization(),
        ),
      ),
    );

    // Test 5: Card View with Actions
    goldenTest(
      'AppDataTable - Card Actions',
      fileName: 'table_card_actions',
      builder: () => buildThemeMatrix(
        name: 'Card Actions',
        width: 400,
        height: 550,
        child: AppDataTable<_User>(
          data: _data.take(2).toList(),
          columns: _editableColumns,
          totalRows: 2,
          currentPage: 1,
          rowsPerPage: 10,
          onPageChanged: (_) {},
          onSave: (_) async {},
          localization: const AppTableLocalization(),
        ),
      ),
    );

    // ============================================
    // Special States
    // ============================================

    // Test 6: Empty State (Grid)
    goldenTest(
      'AppDataTable - Empty',
      fileName: 'table_empty',
      builder: () => buildThemeMatrix(
        name: 'Empty',
        width: 950,
        height: 200,
        child: AppDataTable<_User>(
          data: const [],
          columns: _columns,
          totalRows: 0,
          currentPage: 1,
          rowsPerPage: 10,
          onPageChanged: (_) {},
          emptyMessage: 'No data available',
          localization: const AppTableLocalization(),
        ),
      ),
    );

    // Test 7: With Custom Localization Labels
    goldenTest(
      'AppDataTable - Custom Labels',
      fileName: 'table_custom_labels',
      builder: () => buildThemeMatrix(
        name: 'Custom Labels',
        width: 950,
        height: 280,
        child: AppDataTable<_User>(
          data: _data,
          columns: _editableColumns,
          totalRows: 3,
          currentPage: 1,
          rowsPerPage: 10,
          onPageChanged: (_) {},
          onSave: (_) async {},
          localization: const AppTableLocalization(
            edit: 'Edit',
            save: 'Save',
            cancel: 'Cancel',
            prev: 'Previous',
            next: 'Next',
          ),
        ),
      ),
    );

    // ============================================
    // Edit Mode Tests (using renderers directly)
    // ============================================

    // Test 8: Grid Edit Mode - Row in editing state (width > 1200 for isDesktop)
    goldenTest(
      'GridRenderer - Edit Mode',
      fileName: 'table_grid_edit_mode',
      builder: () => buildThemeMatrix(
        name: 'Grid Edit Mode',
        width: 1250, // > breakpointDesktop (1200) to show input fields
        height: 220,
        child: GridRenderer<_User>(
          data: _data.take(2).toList(),
          columns: _editableColumns,
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

    // Note: CardRenderer always uses BottomSheet for editing, so editingRowIndex
    // doesn't change the visual state of cards. The edit form appears in a modal.
    // Dialog/BottomSheet overlays cannot be tested with standard golden tests.

    // Test 9: Grid Edit Mode with Validation Errors (No Layout Shift Policy)
    // Shows error icon + tooltip instead of error text below input
    goldenTest(
      'GridRenderer - Edit Mode with Errors',
      fileName: 'table_grid_edit_with_errors',
      builder: () => buildThemeMatrix(
        name: 'Edit with Errors',
        width: 1250, // > breakpointDesktop (1200) to show input fields
        height: 220,
        child: GridRenderer<_User>(
          data: _data.take(2).toList(),
          columns: _editableColumnsWithError,
          editingRowIndex: 0, // First row in edit mode with errors
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

    // Test 9b: Grid Edit Mode with Multiple Input Types and Errors
    // Showcases IPv4, IPv6, MAC, Dropdown inputs with validation errors
    // Demonstrates "No Layout Shift Policy" across various input types
    goldenTest(
      'GridRenderer - Multi-Input Types with Errors',
      fileName: 'table_grid_multi_input_errors',
      builder: () => buildThemeMatrix(
        name: 'Multi-Input Errors',
        width: 1600, // Wide enough for all columns including dropdown
        height: 280,
        child: GridRenderer<_NetworkConfig>(
          data: _networkData,
          columns: _networkColumnsWithErrors,
          editingRowIndex: 0, // First row in edit mode with errors
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

    // Test 10: Grid Non-Desktop Edit Mode - shows dimmed row state
    // When not desktop, clicking Edit opens a dialog, but the row shows dimmed state
    goldenTest(
      'GridRenderer - Non-Desktop Edit State',
      fileName: 'table_grid_non_desktop_edit',
      builder: () => buildThemeMatrix(
        name: 'Non-Desktop Edit',
        width: 950, // < breakpointDesktop (1200), so isDesktop = false
        height: 220,
        child: GridRenderer<_User>(
          data: _data.take(2).toList(),
          columns: _editableColumns,
          editingRowIndex: 0, // First row selected, other rows dimmed
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
  });
}
