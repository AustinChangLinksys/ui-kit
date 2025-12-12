import 'package:flutter/material.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:ui_kit_library/ui_kit.dart';

// =============================================================================
// ColorUtils Stories
// =============================================================================

// -----------------------------------------------------------------------------
// UseCase 1: Auto Foreground Color Demo
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'Auto Foreground Color',
  type: ColorUtils,
)
Widget buildColorUtilsAutoForeground(BuildContext context) {
  // Sample colors to demonstrate
  final sampleColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    Colors.lightGreen,
    Colors.lime,
    Colors.yellow,
    Colors.amber,
    Colors.orange,
    Colors.deepOrange,
    Colors.brown,
    Colors.grey,
    Colors.blueGrey,
    Colors.black,
    Colors.white,
  ];

  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ColorUtils.computeContrastColor',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Automatically calculates appropriate foreground (text/icon) color for any background',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: sampleColors.map((color) {
              return _buildColorChip(context, color);
            }).toList(),
          ),
          const SizedBox(height: 32),
          _buildCustomColorDemo(context),
        ],
      ),
    ),
  );
}

Widget _buildColorChip(BuildContext context, Color backgroundColor) {
  final foregroundColor = ColorUtils.computeContrastColor(backgroundColor);

  return Container(
    width: 80,
    height: 60,
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(8),
      border: Border.all(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
      ),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.star,
            color: foregroundColor,
            size: 20,
          ),
          Text(
            'Text',
            style: TextStyle(
              color: foregroundColor,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildCustomColorDemo(BuildContext context) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Usage Example',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHigh,
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Text(
            '''final bg = scheme.semanticSuccess;
final text = ColorUtils.computeContrastColor(bg);

// For opacity variations:
final secondary = ColorUtils.computeContrastColorWithOpacity(
  bg,
  opacity: 0.7,
);''',
            style: TextStyle(
              fontFamily: 'monospace',
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// UseCase 2: Semantic Colors Foreground Demo
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'Semantic Colors Demo',
  type: ColorUtils,
)
Widget buildSemanticColorsDemo(BuildContext context) {
  final scheme = Theme.of(context).extension<AppColorScheme>();

  if (scheme == null) {
    return const Center(child: Text('AppColorScheme not found'));
  }

  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'Semantic Colors with Auto Foreground',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Each semantic color automatically computes its foreground color',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: [
              _buildSemanticCard(
                context,
                label: 'Success',
                backgroundColor: scheme.semanticSuccess,
                foregroundColor: scheme.onSemanticSuccess,
              ),
              _buildSemanticCard(
                context,
                label: 'Warning',
                backgroundColor: scheme.semanticWarning,
                foregroundColor: scheme.onSemanticWarning,
              ),
              _buildSemanticCard(
                context,
                label: 'Danger',
                backgroundColor: scheme.semanticDanger,
                foregroundColor: scheme.onSemanticDanger,
              ),
              _buildSemanticCard(
                context,
                label: 'Primary',
                backgroundColor: scheme.primary,
                foregroundColor: scheme.onPrimary,
              ),
              _buildSemanticCard(
                context,
                label: 'Secondary',
                backgroundColor: scheme.secondary,
                foregroundColor: scheme.onSecondary,
              ),
              _buildSemanticCard(
                context,
                label: 'Surface',
                backgroundColor: scheme.surface,
                foregroundColor: scheme.onSurface,
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildSemanticCard(
  BuildContext context, {
  required String label,
  required Color backgroundColor,
  required Color foregroundColor,
}) {
  return Container(
    width: 140,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: backgroundColor,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        Icon(
          Icons.check_circle,
          color: foregroundColor,
          size: 32,
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(
            color: foregroundColor,
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Auto foreground',
          style: TextStyle(
            color: foregroundColor.withValues(alpha: 0.7),
            fontSize: 10,
          ),
        ),
      ],
    ),
  );
}

// -----------------------------------------------------------------------------
// UseCase 3: isLightColor / isDarkColor Demo
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'Light/Dark Detection',
  type: ColorUtils,
)
Widget buildLightDarkDetection(BuildContext context) {
  final testColors = [
    (Colors.white, 'White'),
    (Colors.black, 'Black'),
    (Colors.grey.shade200, 'Grey 200'),
    (Colors.grey.shade500, 'Grey 500'),
    (Colors.grey.shade800, 'Grey 800'),
    (Colors.blue, 'Blue'),
    (Colors.yellow, 'Yellow'),
    (Colors.deepPurple, 'Deep Purple'),
  ];

  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'ColorUtils.isLightColor / isDarkColor',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Detects whether a color is light or dark based on luminance',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          ...testColors.map((entry) {
            final (color, name) = entry;
            final isLight = ColorUtils.isLightColor(color);
            return _buildDetectionRow(context, color, name, isLight);
          }),
        ],
      ),
    ),
  );
}

Widget _buildDetectionRow(
  BuildContext context,
  Color color,
  String name,
  bool isLight,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color:
                  Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(name, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isLight ? Colors.yellow.shade100 : Colors.blueGrey.shade700,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            isLight ? '☀️ Light' : '🌙 Dark',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
              color: isLight ? Colors.black : Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}
