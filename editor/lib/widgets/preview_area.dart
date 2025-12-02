import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ui_kit_library/ui_kit.dart';
import '../controllers/theme_editor_controller.dart';

/// Widget that displays a live preview of the current theme
/// Wraps the Dashboard Page with the current AppDesignTheme
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
/// Simplified version for quick visual feedback
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
          Text(
            'Theme Preview',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          SizedBox(height: theme.spacingFactor * 24),

          // Color Palette Preview
          _ColorPalettePreview(theme: theme),
          SizedBox(height: theme.spacingFactor * 24),

          // Typography Preview
          _TypographyPreview(theme: theme),
          SizedBox(height: theme.spacingFactor * 24),

          // Surface Variants Preview
          _SurfaceVariantsPreview(theme: theme),
          SizedBox(height: theme.spacingFactor * 24),

          // Components Preview
          _ComponentsPreview(theme: theme),
        ],
      ),
    );
  }
}

/// Displays color palette from the theme
class _ColorPalettePreview extends StatelessWidget {
  final AppDesignTheme theme;

  const _ColorPalettePreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Colors', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 12),
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

/// Small color indicator box with label
class _ColorBox extends StatelessWidget {
  final Color color;
  final String label;

  const _ColorBox({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: color,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

/// Displays typography hierarchy
class _TypographyPreview extends StatelessWidget {
  final AppDesignTheme theme;

  const _TypographyPreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Typography', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 12),
        Text('Headline', style: Theme.of(context).textTheme.headlineSmall),
        Text('Title Medium', style: Theme.of(context).textTheme.titleMedium),
        Text('Body Text', style: Theme.of(context).textTheme.bodyMedium),
        Text('Caption', style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

/// Displays surface variants
class _SurfaceVariantsPreview extends StatelessWidget {
  final AppDesignTheme theme;

  const _SurfaceVariantsPreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Surface Variants', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(theme.spacingFactor * 12),
                decoration: BoxDecoration(
                  color: theme.surfaceBase.backgroundColor,
                  border: Border.all(color: theme.surfaceBase.borderColor),
                  borderRadius: BorderRadius.circular(theme.surfaceBase.borderRadius),
                ),
                child: Text('Base', style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(theme.spacingFactor * 12),
                decoration: BoxDecoration(
                  color: theme.surfaceElevated.backgroundColor,
                  border: Border.all(color: theme.surfaceElevated.borderColor),
                  borderRadius: BorderRadius.circular(theme.surfaceElevated.borderRadius),
                ),
                child: Text('Elevated', style: Theme.of(context).textTheme.bodySmall),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// Displays sample components
class _ComponentsPreview extends StatelessWidget {
  final AppDesignTheme theme;

  const _ComponentsPreview({required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Components', style: Theme.of(context).textTheme.titleMedium),
        SizedBox(height: 12),
        Row(
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text('Primary'),
            ),
            SizedBox(width: 12),
            OutlinedButton(
              onPressed: () {},
              child: const Text('Secondary'),
            ),
          ],
        ),
        SizedBox(height: 12),
        AppTextFormField(
          label: 'Input Field',
        ),
      ],
    );
  }
}
