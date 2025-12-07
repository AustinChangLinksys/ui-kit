import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/src/molecules/bottom_sheet/app_bottom_sheet.dart';
import 'package:ui_kit_library/ui_kit.dart';

class CardRenderer<T> extends StatelessWidget {
  final List<T> data;
  final List<AppTableColumn<T>> columns;
  final int? editingRowIndex;
  final ValueChanged<int> onEdit;
  final VoidCallback onCancel;
  final ValueChanged<T> onSave;
  final AppTableLocalization localization;

  const CardRenderer({
    super.key,
    required this.data,
    required this.columns,
    required this.editingRowIndex,
    required this.onEdit,
    required this.onCancel,
    required this.onSave,
    required this.localization,
  });

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
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      separatorBuilder: (context, index) => const Gap(12),
      itemBuilder: (context, index) {
        final item = data[index];

        return AppCard(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...columns.map((col) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 2,
                          child: AppText(
                            col.label,
                            variant: AppTextVariant.labelMedium,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Gap(8),
                        Expanded(
                          flex: 3,
                          child: col.cellBuilder(context, item),
                        ),
                      ],
                    ),
                  );
                }),
                const Gap(12),
                Align(
                  alignment: Alignment.centerRight,
                  child: _buildActionButton(
                    label: localization.edit,
                    icon: localization.editIcon,
                    onTap: () {
                      AppFeedback.onInteraction();
                      onEdit(index);
                      _showEditSheet(context, item);
                    },
                    variant: SurfaceVariant.tonal,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditSheet(BuildContext context, T item) {
    final formKey = GlobalKey<FormState>();

    showAppBottomSheet(
      context: context,
      padding: const EdgeInsets.all(24),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (localization.editRowTitle != null)
              AppText(
                localization.editRowTitle!,
                variant: AppTextVariant.headlineSmall,
              ),
            const Gap(24),
            ...columns.map(
              (col) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppText(col.label, variant: AppTextVariant.labelSmall),
                    const Gap(8),
                    Builder(
                      builder: (sheetContext) =>
                          col.editBuilder?.call(sheetContext, item) ??
                          col.cellBuilder(sheetContext, item),
                    ),
                  ],
                ),
              ),
            ),
            const Gap(24),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _buildActionButton(
                  label: localization.cancel,
                  icon: localization.cancelIcon,
                  onTap: () {
                    AppFeedback.onSelection();
                    Navigator.of(context).pop();
                    onCancel();
                  },
                  variant: SurfaceVariant.base,
                  size: AppButtonSize.medium,
                ),
                const Gap(16),
                _buildActionButton(
                  label: localization.save,
                  icon: localization.saveIcon,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      AppFeedback.onSuccess();
                      Navigator.of(context).pop();
                      onSave(item);
                    } else {
                      AppFeedback.onError();
                    }
                  },
                  variant: SurfaceVariant.highlight,
                  size: AppButtonSize.medium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
