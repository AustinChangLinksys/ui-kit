import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'surface_style_editor.dart';

/// Editor widget for ToggleStyle properties
/// Allows editing of surface styles and viewing toggle configuration:
/// activeTrackStyle, inactiveTrackStyle, thumbStyle, activeType, inactiveType
class ToggleSpecEditor extends StatefulWidget {
  final ToggleStyle initialStyle;
  final ValueChanged<ToggleStyle> onChanged;

  const ToggleSpecEditor({
    required this.initialStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<ToggleSpecEditor> createState() => _ToggleSpecEditorState();
}

class _ToggleSpecEditorState extends State<ToggleSpecEditor> {
  late ToggleStyle _currentStyle;

  @override
  void initState() {
    super.initState();
    _currentStyle = widget.initialStyle;
  }

  @override
  void didUpdateWidget(ToggleSpecEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialStyle != widget.initialStyle) {
      _currentStyle = widget.initialStyle;
    }
  }

  void _updateStyle(ToggleStyle newStyle) {
    setState(() {
      _currentStyle = newStyle;
    });
    widget.onChanged(newStyle);
  }

  void _handleActiveTrackStyleChanged(SurfaceStyle style) {
    final updated = _currentStyle.copyWith(
      activeTrackStyle: style,
    );
    _updateStyle(updated);
  }

  void _handleInactiveTrackStyleChanged(SurfaceStyle style) {
    final updated = _currentStyle.copyWith(
      inactiveTrackStyle: style,
    );
    _updateStyle(updated);
  }

  void _handleThumbStyleChanged(SurfaceStyle style) {
    final updated = _currentStyle.copyWith(
      thumbStyle: style,
    );
    _updateStyle(updated);
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text('Toggle', style: Theme.of(context).textTheme.titleMedium),
      subtitle: Text(
        '5 parameters',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: Colors.grey,
            ),
      ),
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Surface Styles section
              Text(
                'Surface Styles',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(12),

              // 1. Active Track Style
              if (_currentStyle.activeTrackStyle != null)
                Column(
                  children: [
                    SurfaceStyleEditor(
                      title: 'Active Track',
                      initialStyle: _currentStyle.activeTrackStyle!,
                      onChanged: _handleActiveTrackStyleChanged,
                    ),
                    const Gap(12),
                  ],
                ),

              // 2. Inactive Track Style
              if (_currentStyle.inactiveTrackStyle != null)
                Column(
                  children: [
                    SurfaceStyleEditor(
                      title: 'Inactive Track',
                      initialStyle: _currentStyle.inactiveTrackStyle!,
                      onChanged: _handleInactiveTrackStyleChanged,
                    ),
                    const Gap(12),
                  ],
                ),

              // 3. Thumb Style
              if (_currentStyle.thumbStyle != null)
                Column(
                  children: [
                    SurfaceStyleEditor(
                      title: 'Thumb',
                      initialStyle: _currentStyle.thumbStyle!,
                      onChanged: _handleThumbStyleChanged,
                    ),
                    const Gap(12),
                  ],
                ),

              // 4. Active Type (read-only info)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Active Type',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _currentStyle.activeType.toString().split('.').last,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(16),

              // 5. Inactive Type (read-only info)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Inactive Type',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                    const Gap(8),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _currentStyle.inactiveType.toString().split('.').last,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
