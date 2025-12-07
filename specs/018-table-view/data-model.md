# Data Model: Table View Component

**Feature Branch**: `018-table-view`

## Entities

### Table Row / Item (Generic `T`)
Represents a single data record containing multiple fields. This is a generic type `T` passed to the `AppDataTable` widget.
- **Constraints**: Must be effectively identifiable (e.g., have an ID) for state management (editing selection).

### Column Definition (`AppTableColumn<T>`)
Defines how a field is displayed and behaved in the table.

| Field | Type | Description |
|---|---|---|
| `label` | `String` | Header text for the column. |
| `flex` | `int` | Flex factor for width distribution (for flexible columns). |
| `width` | `double?` | Fixed width (if set, overrides flex). |
| `cellBuilder` | `Widget Function(BuildContext, T)` | Builder for the cell content. |
| `editBuilder` | `Widget Function(BuildContext, T)?` | Builder for the cell content in Edit Mode. Allows custom widgets like `AppIPv4Field`, `AppIPv6Field`, or `AppRangeSlider`. If null, defaults to `AppTextFormField`. |
| `sortable` | `bool` | Whether the column supports sorting. |

## Theme Contracts

### Table Style (`TableStyle`)
Encapsulates theme-specific metrics and behaviors.

| Field | Type | Description |
|---|---|---|
| `gridColor` | `Color` | Color of grid lines (visible in Pixel). |
| `gridWidth` | `double` | Width of grid lines (0.0 for Glass, >1.0 for Pixel). |
| `cellPadding` | `EdgeInsetsGeometry` | Padding inside cells (dense vs spacious). |
| `invertRowOnHover` | `bool` | Whether to invert row colors on hover (Pixel style). |
| `glowRowOnHover` | `bool` | Whether to add glow effect on hover (Glass style). |

## State Models

### Table State (Server-Side Pagination, Controlled Mode)
The table operates in a controlled mode for pagination, meaning the parent widget is responsible for providing the data for the *current page* and handling page change requests.

| Field | Type | Description |
|---|---|---|
| `editingRowIndex` | `int?` | Index of the row currently being edited. Null if no row is in edit mode. |
| `data` | `List<T>` | The specific subset of data to display for the current page. NOT the full dataset. |
| `totalRows` | `int` | The total number of items available on the server/source. Used to calculate the "Total Pages". |
| `currentPage` | `int` | The current active page index (0-based or 1-based, defined by team standard). |
| `rowsPerPage` | `int` | How many rows to show per page. |
