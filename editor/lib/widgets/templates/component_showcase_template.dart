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

/// Displays all surface variants using AppSurface
/// Shows: Base, Elevated, Highlight, Tonal (Secondary), Accent (Tertiary)
/// This demonstrates the impact of color scheme changes on all surface types
class _SurfaceVariantsPreview extends StatelessWidget {
  const _SurfaceVariantsPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Surface Variants', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        // Row 1: Base and Elevated
        Row(
          children: [
            Expanded(
              child: AppSurface(
                variant: SurfaceVariant.base,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText('Base', variant: AppTextVariant.bodySmall),
                ),
              ),
            ),
            AppGap.md(),
            Expanded(
              child: AppSurface(
                variant: SurfaceVariant.elevated,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText('Elevated', variant: AppTextVariant.bodySmall),
                ),
              ),
            ),
          ],
        ),
        AppGap.md(),
        // Row 2: Highlight and Tonal (Secondary)
        Row(
          children: [
            Expanded(
              child: AppSurface(
                variant: SurfaceVariant.highlight,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText('Highlight', variant: AppTextVariant.bodySmall),
                ),
              ),
            ),
            AppGap.md(),
            Expanded(
              child: AppSurface(
                variant: SurfaceVariant.tonal,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText('Tonal (Secondary)', variant: AppTextVariant.bodySmall),
                ),
              ),
            ),
          ],
        ),
        AppGap.md(),
        // Row 3: Accent (Tertiary)
        Row(
          children: [
            Expanded(
              child: AppSurface(
                variant: SurfaceVariant.accent,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: AppText('Accent (Tertiary)', variant: AppTextVariant.bodySmall),
                ),
              ),
            ),
            AppGap.md(),
            Expanded(
              child: Container(),
            ),
          ],
        ),
      ],
    );
  }
}

/// Displays all available UI Kit components organized by category
class _ComponentsPreview extends StatelessWidget {
  const _ComponentsPreview();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Buttons & Navigation
        AppText('Buttons & Navigation', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppButton variants
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
            // AppIconButton
            Row(
              children: [
                AppIconButton(
                  icon: Icon(Icons.favorite),
                  onTap: () {},
                ),
                AppGap.md(),
                AppIconButton(
                  icon: Icon(Icons.share),
                  onTap: () {},
                  variant: SurfaceVariant.base,
                ),
              ],
            ),
          ],
        ),
        AppGap.xl(),

        // Form & Input Controls
        AppText('Form & Input Controls', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppTextFormField
            AppTextFormField(label: 'Text Input'),
            AppGap.md(),
            // AppTextField
            AppTextField(hintText: 'Simple Text Field'),
            AppGap.md(),
            // AppDropdown
            AppDropdown<String>(
              value: 'option1',
              items: const ['option1', 'option2', 'option3'],
              onChanged: (value) {},
              label: 'Dropdown Selection',
            ),
            AppGap.md(),
          ],
        ),
        AppGap.xl(),

        // Selection Controls
        AppText('Selection Controls', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox
            Row(
              children: [
                AppCheckbox(value: true, onChanged: (_) {}),
                AppGap.md(),
                AppText('Checked', variant: AppTextVariant.bodyMedium),
                AppGap.xl(),
                AppCheckbox(value: false, onChanged: (_) {}),
                AppGap.md(),
                AppText('Unchecked', variant: AppTextVariant.bodyMedium),
              ],
            ),
            AppGap.md(),
            // Radio
            Row(
              children: [
                AppRadio<int>(value: 1, groupValue: 1, onChanged: (_) {}),
                AppGap.md(),
                AppText('Selected', variant: AppTextVariant.bodyMedium),
                AppGap.xl(),
                AppRadio<int>(value: 2, groupValue: 1, onChanged: (_) {}),
                AppGap.md(),
                AppText('Unselected', variant: AppTextVariant.bodyMedium),
              ],
            ),
            AppGap.md(),
            // AppSwitch
            Row(
              children: [
                AppSwitch(value: true, onChanged: (_) {}),
                AppGap.md(),
                AppText('Toggle Switch', variant: AppTextVariant.bodyMedium),
              ],
            ),
            AppGap.md(),
            // AppSlider
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText('Slider Control', variant: AppTextVariant.bodySmall),
                AppGap.xs(),
                AppSlider(value: 0.5, onChanged: (_) {}),
              ],
            ),
          ],
        ),
        AppGap.xl(),

        // Status & Feedback
        AppText('Status & Feedback', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status indicators
            Row(
              children: [
                AppBadge(label: 'Badge'),
                AppGap.md(),
                AppTag(label: 'Tag'),
                AppGap.md(),
                AppAvatar(initials: 'UI'),
              ],
            ),
            AppGap.md(),
            // Loaders and feedback
            Row(
              children: [
                AppLoader(),
                AppGap.md(),
                AppTooltip(
                  message: 'Hover Info',
                  child: Icon(Icons.info_outline),
                ),
                AppGap.md(),
                AppButton(
                  label: 'Toast',
                  onTap: () {
                    AppToast.show(
                      context,
                      title: 'Notification',
                      type: ToastType.success,
                      description: 'Action completed successfully',
                    );
                  },
                  variant: SurfaceVariant.base,
                ),
              ],
            ),
          ],
        ),
        AppGap.xl(),

        // Display & Layout
        AppText('Display & Layout', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AppCard
            AppCard(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: AppText('Sample Card Component', variant: AppTextVariant.bodyMedium),
              ),
            ),
            AppGap.md(),
            // AppListTile
            AppListTile(
              leading: AppIcon.font(Icons.person),
              title: AppText('List Tile', variant: AppTextVariant.bodyMedium),
              subtitle: AppText('With leading icon', variant: AppTextVariant.bodySmall),
            ),
            AppGap.md(),
            // AppDivider
            AppDivider(),
            AppGap.md(),
            // Skeletons
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
          ],
        ),
        AppGap.xl(),

        // Icon Showcase
        AppText('Icon Library', variant: AppTextVariant.titleMedium),
        AppGap.md(),
        Row(
          children: [
            AppIcon.font(Icons.home),
            AppGap.md(),
            AppIcon.font(Icons.settings),
            AppGap.md(),
            AppIcon.font(Icons.search),
            AppGap.md(),
            AppIcon.font(Icons.favorite),
            AppGap.md(),
            AppIcon.font(Icons.share),
          ],
        ),
        AppGap.xl(),

      ],
    );
  }
}
