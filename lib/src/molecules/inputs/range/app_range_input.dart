import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/range_input_style.dart';

class AppRangeInput extends StatefulWidget {
  final TextEditingController? startController;
  final TextEditingController? endController;
  final String? startLabel;
  final String? endLabel;
  final String? errorText; 
  final String? Function(String start, String end)? validator;
  
  const AppRangeInput({
    super.key,
    this.startController,
    this.endController,
    this.startLabel,
    this.endLabel,
    this.errorText,
    this.validator,
  });

  @override
  State<AppRangeInput> createState() => _AppRangeInputState();
}

class _AppRangeInputState extends State<AppRangeInput> {
  late TextEditingController _startController;
  late TextEditingController _endController;
  String? _internalErrorText;

  @override
  void initState() {
    super.initState();
    _startController = widget.startController ?? TextEditingController();
    _endController = widget.endController ?? TextEditingController();
    _startController.addListener(_validate);
    _endController.addListener(_validate);
  }

  @override
  void didUpdateWidget(AppRangeInput oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.errorText != oldWidget.errorText) {
      setState(() {
        // If external error text is provided, it overrides internal validation
      });
    }
  }

  @override
  void dispose() {
    if (widget.startController == null) _startController.dispose();
    if (widget.endController == null) _endController.dispose();
    super.dispose();
  }

  void _validate() {
    if (widget.validator != null) {
      final error = widget.validator!(_startController.text, _endController.text);
      if (error != _internalErrorText) {
        setState(() {
          _internalErrorText = error;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppDesignTheme.of(context);
    final style = theme.rangeInputStyle;
    final effectiveErrorText = widget.errorText ?? _internalErrorText;
    final hasError = effectiveErrorText != null;

    if (style.mergeContainers) {
      return _buildMergedLayout(theme, style, hasError, effectiveErrorText);
    } else {
      return _buildSeparatedLayout(theme, style, hasError, effectiveErrorText);
    }
  }

  Widget _buildMergedLayout(AppDesignTheme theme, RangeInputStyle style, bool hasError, String? errorText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        AppSurface(
          variant: SurfaceVariant.base,
          style: theme.inputStyle.outlineStyle.copyWith(
            borderColor: hasError ? theme.inputStyle.errorModifier.borderColor : null,
            borderWidth: hasError ? theme.inputStyle.errorModifier.borderWidth : null,
          ),
          child: Row(
            children: [
              Expanded(child: _buildTextField(theme, _startController, widget.startLabel, hasError, true)),
              _buildSeparator(style, theme),
              Expanded(child: _buildTextField(theme, _endController, widget.endLabel, hasError, true)),
            ],
          ),
        ),
        if (errorText != null) ...[
          AppGap.xs(),
          AppText.bodySmall(errorText, color: theme.inputStyle.errorModifier.contentColor),
        ],
      ],
    );
  }

  Widget _buildSeparatedLayout(AppDesignTheme theme, RangeInputStyle style, bool hasError, String? errorText) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(child: _buildTextField(theme, _startController, widget.startLabel, hasError, false)),
            SizedBox(width: style.spacing),
            _buildSeparator(style, theme),
            SizedBox(width: style.spacing),
            Expanded(child: _buildTextField(theme, _endController, widget.endLabel, hasError, false)),
          ],
        ),
        if (errorText != null) ...[
          AppGap.xs(),
          AppText.bodySmall(errorText, color: theme.inputStyle.errorModifier.contentColor),
        ],
      ],
    );
  }

  Widget _buildTextField(AppDesignTheme theme, TextEditingController controller, String? label, bool hasError, bool isMerged) {
    // If merged, we want a borderless text field inside the container
    // If separated, we want a standard AppTextField
    
    if (isMerged) {
      return TextField(
        controller: controller,
        decoration: InputDecoration(
          hintText: label,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          hintStyle: theme.typography.bodyFontFamily != null 
              ? TextStyle(fontFamily: theme.typography.bodyFontFamily, color: theme.inputStyle.outlineStyle.contentColor.withValues(alpha: 0.5))
              : null,
        ),
        style: theme.typography.bodyFontFamily != null 
            ? TextStyle(fontFamily: theme.typography.bodyFontFamily, color: theme.inputStyle.outlineStyle.contentColor)
            : null,
      );
    } else {
      return AppTextField(
        controller: controller,
        hintText: label,
        // Using a non-null empty string to trigger error styling if supported/needed,
        // but generally we want the range input to handle the main error display.
        // If we pass errorText here, it shows up.
        // For now, we won't pass errorText to individual fields to avoid visual clutter,
        // relying on the parent AppRangeInput to show the message.
        // Visual error indication on individual fields (red border) is desired but 
        // requires AppTextField to support 'hasError' flag without text.
        // Assuming standard behavior for MVP.
      );
    }
  }

  Widget _buildSeparator(RangeInputStyle style, AppDesignTheme theme) {
    if (style.customSeparator != null) {
      return style.customSeparator!;
    }
    return Text(
      '-', 
      style: theme.typography.bodyFontFamily != null 
          ? TextStyle(fontFamily: theme.typography.bodyFontFamily, fontSize: 24, color: theme.inputStyle.outlineStyle.contentColor) 
          : const TextStyle(fontSize: 24),
    );
  }
}
