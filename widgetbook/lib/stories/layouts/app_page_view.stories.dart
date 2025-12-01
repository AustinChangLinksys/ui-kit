import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

@widgetbook.UseCase(
  name: 'Grid Layout Playground',
  type: AppPageView,
)
Widget buildAppPageView(BuildContext context) {
  final showOverlay =
      context.knobs.boolean(label: 'Show Grid Overlay', initialValue: true);
  final useContentPadding =
      context.knobs.boolean(label: 'Use Content Padding', initialValue: true);

  return AppPageView(
    showGridOverlay: showOverlay,
    useContentPadding: useContentPadding,
    scrollable: true,
    appBar: AppBar(
      title: const Text('Layout Strategies'),
      backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        // =====================================================================
        // Strategy 1: Responsive Span Logic
        // =====================================================================
        const _SectionHeader(
            title: '1. Responsive Span Logic', subtitle: 'context.colWidth(4)'),

        Container(
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            border: Border.symmetric(
                horizontal:
                    BorderSide(color: Colors.blue.withValues(alpha: 0.3))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  _getSpanDescription(context),
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                ),
              ),

              // Demo Row (no Padding, directly aligned to Grid)
              Builder(builder: (context) {
                final maxCols = context.currentMaxColumns;

                // Desktop/Tablet (12 cols) -> Display 3 (4+4+4)
                if (maxCols >= 12) {
                  return Row(
                    children: [
                      _GridDemoBox(
                          width: context.colWidth(4),
                          color: Colors.blue,
                          label: 'Span 4'),
                      SizedBox(width: context.currentGutter),
                      _GridDemoBox(
                          width: context.colWidth(4),
                          color: Colors.blue.withValues(alpha: 0.6),
                          label: 'Span 4'),
                      SizedBox(width: context.currentGutter),
                      _GridDemoBox(
                          width: context.colWidth(4),
                          color: Colors.blue.withValues(alpha: 0.4),
                          label: 'Span 4'),
                    ],
                  );
                }

                // Mobile (4 cols) -> Display 1 (Full)
                return Row(
                  children: [
                    _GridDemoBox(
                        width: context.colWidth(4),
                        color: Colors.blue,
                        label: 'Span 4 (Full)'),
                  ],
                );
              }),
              const SizedBox(height: 16),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // =====================================================================
        // Strategy 2: Fixed Split Logic
        // =====================================================================
        const _SectionHeader(
            title: '2. Fixed Split Logic', subtitle: 'context.split(4)'),

        Container(
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.1),
            border: Border.symmetric(
                horizontal:
                    BorderSide(color: Colors.green.withValues(alpha: 0.3))),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(16),
                child: Text('Logic: (Width - Gutters) / 4',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.green)),
              ),

              // Demo Row (no Padding, directly aligned to Grid)
              Builder(
                builder: (context) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _GridDemoBox(
                          width: context.split(4),
                          color: Colors.green,
                          label: '1/4'),
                      _GridDemoBox(
                          width: context.split(4),
                          color: Colors.green,
                          label: '1/4'),
                      _GridDemoBox(
                          width: context.split(4),
                          color: Colors.green,
                          label: '1/4'),
                      _GridDemoBox(
                          width: context.split(4),
                          color: Colors.green,
                          label: '1/4'),
                    ],
                  );
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
        const SizedBox(height: 48),
      ],
    ),
  );
}

String _getSpanDescription(BuildContext context) {
  final cols = context.currentMaxColumns;
  if (cols >= 12) return '💻 Desktop/Tablet (12 Cols): "Span 4" = 1/3 Width';
  return '📱 Mobile (4 Cols): "Span 4" = Full Width';
}

class _GridDemoBox extends StatelessWidget {
  final double width;
  final Color color;
  final String label;

  const _GridDemoBox(
      {required this.width, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        border:
            Border.all(color: Colors.white.withValues(alpha: 0.5), width: 2),
      ),
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SectionHeader({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleLarge),
          Text(subtitle,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: Colors.grey)),
        ],
      ),
    );
  }
}
