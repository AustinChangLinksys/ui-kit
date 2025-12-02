import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'surface_style_editor.dart';

/// Editor widget for InputStyle properties
/// Allows editing of three input variants (Outline, Underline, Filled) and state modifiers
class InputStyleEditor extends StatefulWidget {
  final InputStyle inputStyle;
  final ValueChanged<InputStyle> onChanged;

  const InputStyleEditor({
    required this.inputStyle,
    required this.onChanged,
    super.key,
  });

  @override
  State<InputStyleEditor> createState() => _InputStyleEditorState();
}

class _InputStyleEditorState extends State<InputStyleEditor> {
  late InputStyle _currentInputStyle;

  @override
  void initState() {
    super.initState();
    _currentInputStyle = widget.inputStyle;
  }

  @override
  void didUpdateWidget(InputStyleEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.inputStyle != widget.inputStyle) {
      _currentInputStyle = widget.inputStyle;
    }
  }

  void _handleOutlineStyleChanged(SurfaceStyle style) {
    final updated = _currentInputStyle.copyWith(outlineStyle: style);
    setState(() {
      _currentInputStyle = updated;
    });
    widget.onChanged(updated);
  }

  void _handleUnderlineStyleChanged(SurfaceStyle style) {
    final updated = _currentInputStyle.copyWith(underlineStyle: style);
    setState(() {
      _currentInputStyle = updated;
    });
    widget.onChanged(updated);
  }

  void _handleFilledStyleChanged(SurfaceStyle style) {
    final updated = _currentInputStyle.copyWith(filledStyle: style);
    setState(() {
      _currentInputStyle = updated;
    });
    widget.onChanged(updated);
  }

  void _handleFocusModifierChanged(SurfaceStyle style) {
    final updated = _currentInputStyle.copyWith(focusModifier: style);
    setState(() {
      _currentInputStyle = updated;
    });
    widget.onChanged(updated);
  }

  void _handleErrorModifierChanged(SurfaceStyle style) {
    final updated = _currentInputStyle.copyWith(errorModifier: style);
    setState(() {
      _currentInputStyle = updated;
    });
    widget.onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Input Variants',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Gap(12),
        // Outline Variant
        SurfaceStyleEditor(
          title: 'Outline Variant',
          initialStyle: _currentInputStyle.outlineStyle,
          onChanged: _handleOutlineStyleChanged,
        ),
        const Gap(8),
        // Underline Variant
        SurfaceStyleEditor(
          title: 'Underline Variant',
          initialStyle: _currentInputStyle.underlineStyle,
          onChanged: _handleUnderlineStyleChanged,
        ),
        const Gap(8),
        // Filled Variant
        SurfaceStyleEditor(
          title: 'Filled Variant',
          initialStyle: _currentInputStyle.filledStyle,
          onChanged: _handleFilledStyleChanged,
        ),
        const Gap(16),
        Text(
          'State Modifiers',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const Gap(12),
        // Focus Modifier
        SurfaceStyleEditor(
          title: 'Focus State',
          initialStyle: _currentInputStyle.focusModifier,
          onChanged: _handleFocusModifierChanged,
        ),
        const Gap(8),
        // Error Modifier
        SurfaceStyleEditor(
          title: 'Error State',
          initialStyle: _currentInputStyle.errorModifier,
          onChanged: _handleErrorModifierChanged,
        ),
      ],
    );
  }
}
