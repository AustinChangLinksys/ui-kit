import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Hero demo page showing key UI components from the dashboard
/// All components use UI Kit library
class ComponentShowcaseTemplate extends StatelessWidget {
  const ComponentShowcaseTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            AppText('Theme Preview', variant: AppTextVariant.headlineSmall),
            AppGap.xl(),

            // Color Palette Preview
            const _ColorPalettePreview(),
            AppGap.xl(),

            // Typography Preview
            const _TypographyPreview(),
            AppGap.xl(),

            // Surface Variants Preview
            const _SurfaceVariantsPreview(),
            AppGap.xl(),

            // Components Preview
            const _ComponentsPreview(),
          ],
        ),
      ),
    );
  }
}

/// Displays color palette from the theme using UI Kit
class _ColorPalettePreview extends StatelessWidget {
  const _ColorPalettePreview();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Colors', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            _ColorBox(color: colorScheme.primary, label: 'Primary'),
            _ColorBox(color: colorScheme.secondary, label: 'Secondary'),
            _ColorBox(color: colorScheme.tertiary, label: 'Tertiary'),
            _ColorBox(color: colorScheme.error, label: 'Error'),
          ],
        ),
      ],
    );
  }
}

/// Small color indicator box with label using AppSurface
class _ColorBox extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorBox({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        AppSurface(
          child: SizedBox(
            width: 60,
            height: 60,
            child: Container(color: color),
          ),
        ),
        AppGap.xs(),
        AppText(label, variant: AppTextVariant.bodySmall),
      ],
    );
  }
}

/// Displays typography hierarchy using AppText
class _TypographyPreview extends StatelessWidget {
  const _TypographyPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Typography', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        AppText('Headline', variant: AppTextVariant.headlineSmall),
        AppText('Title Medium', variant: AppTextVariant.titleMedium),
        AppText('Body Text', variant: AppTextVariant.bodyMedium),
        AppText('Caption', variant: AppTextVariant.bodySmall),
      ],
    );
  }
}

/// Displays surface variants using AppSurface
class _SurfaceVariantsPreview extends StatelessWidget {
  const _SurfaceVariantsPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Surface Variants', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Row(
          children: [
            Expanded(
              child: AppSurface(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText('Base', variant: AppTextVariant.bodySmall),
                ),
              ),
            ),
            AppGap.md(),
            Expanded(
              child: AppSurface(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText('Elevated', variant: AppTextVariant.bodySmall),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Displays sample components using UI Kit widgets
class _ComponentsPreview extends StatelessWidget {
  const _ComponentsPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Components', variant: AppTextVariant.titleMedium),
        AppGap.md(),

        // Buttons
        Row(
          children: [
            AppButton(label: 'Primary', onTap: () {}),
            AppGap.md(),
            AppButton(
              label: 'Secondary',
              onTap: () {},
              variant: SurfaceVariant.base,
            ),
          ],
        ),
        AppGap.md(),

        // Input Field - shows InputStyle changes
        AppTextFormField(label: 'Input Field'),
        AppGap.md(),

        // Toggle/Switch - shows ToggleStyle changes
        Row(
          children: [
            AppSwitch(value: true, onChanged: (_) {}),
            AppGap.md(),
            AppText('Enabled', variant: AppTextVariant.bodyMedium),
          ],
        ),
        AppGap.md(),

        // Card - shows SurfaceStyle changes
        AppCard(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: AppText('Sample Card', variant: AppTextVariant.bodyMedium),
          ),
        ),
        AppGap.xl(),

        // Feedback & Status
        AppText('Feedback & Status', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Row(
          children: [
            AppLoader(),
            AppGap.md(),
            AppBadge(label: 'Badge'),
            AppGap.md(),
            AppTag(label: 'Tag'),
            AppGap.md(),
            AppTooltip(
              message: 'Tooltip Info',
              child: Icon(Icons.info_outline),
            ),
          ],
        ),
        AppGap.md(),
        AppButton(
          label: 'Show Toast',
          onTap: () {
            AppToast.show(
              context,
              title: 'Toast Title',
              type: ToastType.info,
              description: 'This is a toast message',
            );
          },
          variant: SurfaceVariant.base,
        ),
        AppGap.xl(),

        // Selection Controls
        AppText('Selection Controls', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Row(
          children: [
            AppCheckbox(value: true, onChanged: (_) {}),
            AppGap.md(),
            AppCheckbox(value: false, onChanged: (_) {}),
            AppGap.xl(),
            AppRadio<int>(value: 1, groupValue: 1, onChanged: (_) {}),
            AppGap.md(),
            AppRadio<int>(value: 2, groupValue: 1, onChanged: (_) {}),
          ],
        ),
        AppGap.md(),
        AppSlider(value: 0.5, onChanged: (_) {}),
        AppGap.xl(),

        // Layout & Loading
        AppText('Layout & Loading', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        AppDivider(),
        AppGap.md(),
        Row(
          children: [
            AppSkeleton.circular(size: 48),
            AppGap.md(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSkeleton.text(width: 120),
                  AppGap.xs(),
                  AppSkeleton.text(width: 200),
                ],
              ),
            ),
          ],
        ),
        AppGap.xl(),
      ],
    );
  }
}
