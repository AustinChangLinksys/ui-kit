import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
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
    final theme = AppTheme.of(context);

    return SingleChildScrollView(
      padding: EdgeInsets.all(theme.spacingFactor * 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          AppText(
            'Theme Preview',
            variant: AppTextVariant.headlineSmall,
          ),
          Gap(theme.spacingFactor * 24),

          // Color Palette Preview
          _ColorPalettePreview(theme: theme),
          Gap(theme.spacingFactor * 24),

          // Typography Preview
          _TypographyPreview(theme: theme),
          Gap(theme.spacingFactor * 24),

          // Surface Variants Preview
          _SurfaceVariantsPreview(theme: theme),
          Gap(theme.spacingFactor * 24),

          // Components Preview
          _ComponentsPreview(theme: theme),
        ],
      ),
    );
  }
}

/// Displays color palette from the theme using UI Kit
class _ColorPalettePreview extends StatelessWidget {
  final AppDesignTheme theme;

  const _ColorPalettePreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Colors', variant: AppTextVariant.titleMedium),
        Gap(theme.spacingFactor * 12),
        Wrap(
          spacing: theme.spacingFactor * 12,
          runSpacing: theme.spacingFactor * 12,
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
        Gap(8),
        AppText(label, variant: AppTextVariant.bodySmall),
      ],
    );
  }
}

/// Displays typography hierarchy using AppText
class _TypographyPreview extends StatelessWidget {
  final AppDesignTheme theme;

  const _TypographyPreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Typography', variant: AppTextVariant.titleMedium),
        Gap(theme.spacingFactor * 12),
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
  final AppDesignTheme theme;

  const _SurfaceVariantsPreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Surface Variants', variant: AppTextVariant.titleMedium),
        Gap(theme.spacingFactor * 12),
        Row(
          children: [
            Expanded(
              child: AppSurface(
                padding: EdgeInsets.all(theme.spacingFactor * 12),
                child: AppText('Base', variant: AppTextVariant.bodySmall),
              ),
            ),
            Gap(theme.spacingFactor * 12),
            Expanded(
              child: AppSurface(
                padding: EdgeInsets.all(theme.spacingFactor * 12),
                child: AppText('Elevated', variant: AppTextVariant.bodySmall),
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
  final AppDesignTheme theme;

  const _ComponentsPreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppText('Components', variant: AppTextVariant.titleMedium),
        Gap(theme.spacingFactor * 12),

        // Buttons
        Row(
          children: [
            AppButton(
              label: 'Primary',
              onTap: () {},
            ),
            Gap(theme.spacingFactor * 12),
            AppButton(
              label: 'Secondary',
              onTap: () {},
              variant: SurfaceVariant.base,
            ),
          ],
        ),
        Gap(theme.spacingFactor * 12),

        // Input Field - shows InputStyle changes
        AppTextFormField(
          label: 'Input Field',
        ),
        Gap(theme.spacingFactor * 12),

        // Toggle/Switch - shows ToggleStyle changes
        Row(
          children: [
            AppSwitch(
              value: true,
              onChanged: (_) {},
            ),
            Gap(theme.spacingFactor * 12),
            AppText('Enabled', variant: AppTextVariant.bodyMedium),
          ],
        ),
        Gap(theme.spacingFactor * 12),

        // Card - shows SurfaceStyle changes
        AppCard(
          child: Padding(
            padding: EdgeInsets.all(theme.spacingFactor * 12),
            child: AppText('Sample Card', variant: AppTextVariant.bodyMedium),
          ),
        ),
      ],
    );
  }
}
