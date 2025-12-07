import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';

class TablePagination extends StatelessWidget {
  final int totalRows;
  final int currentPage;
  final int rowsPerPage;
  final ValueChanged<int> onPageChanged;
  final AppTableLocalization localization;

  const TablePagination({
    super.key,
    required this.totalRows,
    required this.currentPage,
    required this.rowsPerPage,
    required this.onPageChanged,
    required this.localization,
  });

  /// Builds a pagination button - uses AppIconButton if no label, AppButton if label provided
  Widget _buildPaginationButton({
    required String? label,
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    if (label != null) {
      return AppButton(
        label: label,
        icon: Icon(icon, size: 16),
        onTap: onTap,
        variant: SurfaceVariant.tonal,
        size: AppButtonSize.small,
      );
    }
    return AppIconButton(
      icon: Icon(icon),
      onTap: onTap,
      variant: SurfaceVariant.tonal,
      size: AppButtonSize.small,
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalPages = (totalRows / rowsPerPage).ceil();
    final displayTotalPages = totalPages == 0 ? 1 : totalPages;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildPaginationButton(
          label: localization.prev,
          icon: localization.prevIcon,
          onTap: currentPage > 1 ? () => onPageChanged(currentPage - 1) : null,
        ),
        const Gap(16),
        AppText(
          localization.pageIndicator(currentPage, displayTotalPages),
          variant: AppTextVariant.bodyMedium,
        ),
        const Gap(16),
        _buildPaginationButton(
          label: localization.next,
          icon: localization.nextIcon,
          onTap: currentPage < displayTotalPages
              ? () => onPageChanged(currentPage + 1)
              : null,
        ),
      ],
    );
  }
}
