import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// IPv4 input field
///
/// Features:
/// - Support [label] above label (consistent with AppTextFormField).
/// - Automatic segmentation (4 input boxes).
/// - Built-in value limit (0-255).
class AppIpv4TextField extends FormField<String> {
  AppIpv4TextField({
    super.key,
    this.controller,

    // Support [label] above label (consistent with AppTextFormField).
    this.label,
    super.onSaved,
    super.validator,
    String? initialValue,
    super.enabled = true,
    super.autovalidateMode,
  }) : super(
          initialValue: controller?.text.isNotEmpty == true
              ? controller!.text
              : initialValue,
          builder: (FormFieldState<String> field) {
            final state = field as _AppIpv4TextFieldState;
            final theme = AppTheme.of(field.context);
            final hasError = field.hasError;

            final separatorStyle = theme.networkInputStyle.ipv4SeparatorStyle;

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (label != null) ...[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
                    child: AppText.labelMedium(label),
                  ),
                ],

                // Segmented input area
                Row(
                  children: [
                    Expanded(child: state._buildSegment(0)),
                    state._buildSeparator(separatorStyle, theme),
                    Expanded(child: state._buildSegment(1)),
                    state._buildSeparator(separatorStyle, theme),
                    Expanded(child: state._buildSegment(2)),
                    state._buildSeparator(separatorStyle, theme),
                    Expanded(child: state._buildSegment(3)),
                  ],
                ),

                // Error message
                if (hasError) ...[
                  SizedBox(height: theme.spacingFactor * 4),
                  Padding(
                    padding: EdgeInsets.only(left: theme.spacingFactor * 4),
                    child: Text(
                      field.errorText!,
                      style: Theme.of(field.context)
                          .textTheme
                          .labelSmall
                          ?.copyWith(
                            color: Theme.of(field.context).colorScheme.error,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ],
              ],
            );
          },
        );

  final TextEditingController? controller;
  final String? label;

  @override
  FormFieldState<String> createState() => _AppIpv4TextFieldState();
}

class _AppIpv4TextFieldState extends FormFieldState<String> {
  late List<TextEditingController> _controllers;
  late List<FocusNode> _focusNodes;

  @override
  AppIpv4TextField get widget => super.widget as AppIpv4TextField;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());

    // Initialize
    _parseAndFill(widget.initialValue ?? '', updateFormField: false);

    // Listen to external controller
    widget.controller?.addListener(_onExternalControllerChanged);

    // Listen to internal controllers
    for (int i = 0; i < 4; i++) {
      _controllers[i].addListener(() => _onSegmentChanged(i));
    }
  }

  @override
  void dispose() {
    widget.controller?.removeListener(_onExternalControllerChanged);
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  void _onExternalControllerChanged() {
    if (widget.controller!.text != value) {
      _parseAndFill(widget.controller!.text);
    }
  }

  void _parseAndFill(String ip, {bool updateFormField = true}) {
    final segments = ip.split('.');
    for (int i = 0; i < 4; i++) {
      if (i < segments.length) {
        if (_controllers[i].text != segments[i]) {
          _controllers[i].text = segments[i];
        }
      } else {
        _controllers[i].clear();
      }
    }
    if (updateFormField) {
      _updateValue();
    }
  }

  void _updateValue() {
    // 組合 IP
    final newValue = _controllers.map((c) => c.text).join('.');

    // 如果還沒填滿 4 格，或是格子裡是空的，可能會產生 "192..." 或 "..."
    // 這邊直接傳遞原始組合字串，讓外部 Validator (如 Required) 去決定合不合法
    didChange(newValue);

    if (widget.controller != null && widget.controller!.text != newValue) {
      widget.controller!.text = newValue;
    }
  }

  void _onSegmentChanged(int index) {
    final text = _controllers[index].text;
    // 滿 3 碼自動跳下一格
    if (text.length == 3 && index < 3) {
      _focusNodes[index + 1].requestFocus();
    }
    _updateValue();
  }

  void _handlePaste(String pasted, int startIndex) {
    final segments = pasted.split('.');
    if (segments.length > 1) {
      for (int i = 0; i < segments.length && (startIndex + i) < 4; i++) {
        _controllers[startIndex + i].text = segments[i];
      }
      int nextFocusIndex = startIndex + segments.length;
      if (nextFocusIndex < 4) {
        _focusNodes[nextFocusIndex].requestFocus();
      } else {
        _focusNodes[3].unfocus();
      }
    }
  }

  Widget _buildSegment(int index) {
    return AppTextField(
      controller: _controllers[index],
      focusNode: _focusNodes[index],
      keyboardType: TextInputType.number,
      hintText: '000',
      // Consider adding a compact or centered variant for optimized small display
      variant: AppInputVariant.outline,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        _IPv4SegmentFormatter(
          onPaste: (pasted) => _handlePaste(pasted, index),
          onDot: () {
            if (index < 3) _focusNodes[index + 1].requestFocus();
          },
        ),
        LengthLimitingTextInputFormatter(3),
      ],
      onChanged: (val) {
        // 強制數值 <= 255
        if (val.isNotEmpty) {
          final intVal = int.tryParse(val);
          if (intVal != null && intVal > 255) {
            _controllers[index].text = '255';
            _controllers[index].selection =
                TextSelection.fromPosition(const TextPosition(offset: 3));
          }
        }
      },
    );
  }

  // Separator rendering (from NetworkInputStyle)
  Widget _buildSeparator(SeparatorStyle style, AppDesignTheme theme) {
    switch (style) {
      case SeparatorStyle.glowingDot:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: 4,
          height: 4,
          decoration: BoxDecoration(
            color: theme.surfaceHighlight.contentColor,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: theme.surfaceHighlight.contentColor
                      .withValues(alpha: 0.6),
                  blurRadius: 4)
            ],
          ),
        );
      case SeparatorStyle.squareBlock:
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          width: 6,
          height: 6,
          color: theme.surfaceBase.contentColor,
        );
      case SeparatorStyle.dot:
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Text('.',
              style: TextStyle(
                  color: theme.surfaceBase.contentColor,
                  fontWeight: FontWeight.bold)),
        );
    }
  }
}

class _IPv4SegmentFormatter extends TextInputFormatter {
  final Function(String) onPaste;
  final VoidCallback onDot;

  _IPv4SegmentFormatter({required this.onPaste, required this.onDot});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains('.')) {
      onPaste(newValue.text);
      return oldValue;
    }
    return newValue;
  }
}
