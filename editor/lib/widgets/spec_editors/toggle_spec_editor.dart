import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'surface_style_editor.dart';

/// Editor widget for ToggleStyle properties
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
      initiallyExpanded: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Surface Styles',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const Gap(12),

              // Active Track Style
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

              // Inactive Track Style
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

              // Thumb Style
              if (_currentStyle.thumbStyle != null)
                SurfaceStyleEditor(
                  title: 'Thumb',
                  initialStyle: _currentStyle.thumbStyle!,
                  onChanged: _handleThumbStyleChanged,
                ),
            ],
          ),
        ),
      ],
    );
  }
}
