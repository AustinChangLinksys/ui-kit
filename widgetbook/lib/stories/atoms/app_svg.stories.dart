import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

import 'package:ui_kit_library/ui_kit.dart';

// =============================================================================
// AppSvg Stories
// =============================================================================

// -----------------------------------------------------------------------------
// UseCase 1: AppSvg Playground
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'Playground',
  type: AppSvg,
)
Widget buildAppSvgPlayground(BuildContext context) {
  final size = context.knobs.double.slider(
    label: 'Size',
    initialValue: 150,
    min: 50,
    max: 300,
  );

  final hasDarkVariant = context.knobs.boolean(
    label: 'Use Dark Variant?',
    initialValue: false,
  );

  final strategy = context.knobs.object.dropdown<DarkModeStrategy>(
    label: 'Dark Mode Strategy',
    options: DarkModeStrategy.values,
    labelBuilder: (value) => value.name,
    initialOption:
        DarkModeStrategy.dimming, // Default to dimming for visible effect
  );

  // Actual strategy applied (variant takes priority over strategy)
  final appliedStrategy = hasDarkVariant ? DarkModeStrategy.none : strategy;
  final isDark = Theme.of(context).brightness == Brightness.dark;

  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Debug info
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: isDark ? Colors.green.shade900 : Colors.blue.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  '${isDark ? "🌙 Dark" : "☀️ Light"} Mode',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Applied: ${appliedStrategy.name}${hasDarkVariant ? " (variant switching)" : ""}',
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // Warning when hasDarkVariant is true
          if (hasDarkVariant)
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                '⚠️ Demo uses same SVG for both variants.\nDisable "Use Dark Variant?" to see Strategy effects.',
                style: TextStyle(color: Colors.orange, fontSize: 11),
                textAlign: TextAlign.center,
              ),
            ),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainer,
              borderRadius: BorderRadius.circular(16),
            ),
            child: AppSvg.asset(
              svg: Assets.images.imgWiredMoveNodes,
              darkVariant:
                  hasDarkVariant ? Assets.images.imgWiredMoveNodes : null,
              darkStrategy: appliedStrategy,
              width: size,
              height: size,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            isDark && appliedStrategy != DarkModeStrategy.none
                ? '✅ ColorFilter applied: ${appliedStrategy.name}'
                : isDark && hasDarkVariant
                    ? '🔄 Using dark variant SVG'
                    : '☀️ Light mode - no filter applied',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
          ),
        ],
      ),
    ),
  );
}

// -----------------------------------------------------------------------------
// UseCase 2: AppSvg with DarkModeStrategy Comparison
// -----------------------------------------------------------------------------
@widgetbook.UseCase(
  name: 'DarkModeStrategy Comparison',
  type: AppSvg,
)
Widget buildAppSvgStrategyComparison(BuildContext context) {
  final svgSize = context.knobs.double.slider(
    label: 'SVG Size',
    initialValue: 100,
    min: 50,
    max: 180,
  );

  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Text(
            'SVG DarkModeStrategy Comparison',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Toggle Dark Mode to see how each strategy adapts the SVG',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 16,
            runSpacing: 16,
            children: DarkModeStrategy.values.map((strategy) {
              return _buildSvgStrategyCard(context, strategy, svgSize);
            }).toList(),
          ),
        ],
      ),
    ),
  );
}

Widget _buildSvgStrategyCard(
  BuildContext context,
  DarkModeStrategy strategy,
  double size,
) {
  return Container(
    width: size + 32,
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainer,
      borderRadius: BorderRadius.circular(12),
      border: Border.all(
        color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
      ),
    ),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSvg.asset(
          svg: Assets.images.imgWiredMoveNodes,
          darkStrategy: strategy,
          width: size,
          height: size,
        ),
        const SizedBox(height: 8),
        Text(
          strategy.name,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    ),
  );
}
