# Quickstart: Table View Component

## Overview
`AppDataTable` is a responsive, style-adaptive table widget designed for displaying and editing structured data. It automatically adapts between Grid view (Desktop/Laptop) and Card List view (Mobile).

## Basic Usage

```dart
AppDataTable<User>(
  data: users, // List<User>
  columns: [
    AppTableColumn(
      label: 'Name',
      flex: 2,
      cellBuilder: (context, user) => Text(user.name),
      editBuilder: (context, user) => AppTextFormField(initialValue: user.name),
    ),
    AppTableColumn(
      label: 'Email',
      flex: 3,
      cellBuilder: (context, user) => Text(user.email),
    ),
    AppTableColumn(
      label: 'Status',
      width: 100, // Fixed width
      cellBuilder: (context, user) => StatusChip(status: user.status),
    ),
  ],
  totalRows: 100,
  currentPage: 1,
  onPageChanged: (page) => fetchUsers(page),
  onSave: (user) async {
    await updateUser(user);
  },
)
```

## Features

- **Responsive Layout**: Automatically switches to Card View on screens < 600px.
- **Theme Adaptive**: Renders with "Pixel" (Grid lines) or "Glass" (Translucent) styles based on the parent `AppTheme`.
- **Single Row Edit**: Built-in support for editing one row at a time.
- **Pagination**: Standard pagination controls.

## Key Properties

| Property | Description |
|---|---|
| `data` | List of items to display. |
| `columns` | Configuration for table columns. |
| `onSave` | Callback triggered when a row is saved. Provides the updated item. |
| `emptyMessage` | Message to show when data is empty. |
