import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../controllers/theme_editor_controller.dart';

/// Widget that displays a live preview of the current theme
/// All preview components use UI Kit library widgets
class PreviewArea extends StatelessWidget {
  final double? previewWidth;

  const PreviewArea({
    this.previewWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeEditorController>(
      builder: (context, themeController, _) {
        return Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade300),
            borderRadius: BorderRadius.circular(8),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: SizedBox(
                width: previewWidth,
                child: Theme(
                  data: AppTheme.create(
                    brightness: themeController.brightness,
                  ),
                  child: Builder(
                    builder: (context) {
                      return Scaffold(
                        backgroundColor: AppTheme.of(context).surfaceBase.backgroundColor,
                        body: _DashboardHeroDemo(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// Hero demo page showing key UI components from the dashboard
/// All components use UI Kit library
class _DashboardHeroDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            AppText(
              'Theme Preview',
              variant: AppTextVariant.headlineSmall,
            ),
            AppGap.xl(),

            // Color Palette Preview
            _ColorPalettePreview(),
            AppGap.xl(),

            // Typography Preview
            _TypographyPreview(),
            AppGap.xl(),

            // Surface Variants Preview
            _SurfaceVariantsPreview(),
            AppGap.xl(),

            // Components Preview
            _ComponentsPreview(),
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
            AppButton(
              label: 'Primary',
              onTap: () {},
            ),
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
        AppTextFormField(
          label: 'Input Field',
        ),
        AppGap.md(),

        // Toggle/Switch - shows ToggleStyle changes
        Row(
          children: [
            AppSwitch(
              value: true,
              onChanged: (_) {},
            ),
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
      ],
    );
  }
}
