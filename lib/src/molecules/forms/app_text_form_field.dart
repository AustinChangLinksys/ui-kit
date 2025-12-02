import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A [FormField] that wraps an [AppTextField], integrating it with the Form lifecycle.
class AppTextFormField extends FormField<String> {
  AppTextFormField({
    super.key,
    this.controller,
    String? initialValue,
    FocusNode? focusNode,
    this.label,
    String? hintText,
    ValueChanged<String>? onChanged,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    AppInputVariant variant = AppInputVariant.outline,
    AppTextVariant textVariant = AppTextVariant.bodyMedium,
    Widget? prefixIcon,
    Widget? suffixIcon,
    this.inputFormatters,
    super.onSaved,
    super.validator,
    super.enabled,
    super.autovalidateMode,
  }) : super(
          initialValue:
              controller != null ? controller.text : (initialValue ?? ''),
          builder: (FormFieldState<String> field) {
            final state = field as _AppTextFormFieldState;

            // ✨ 2. 組合 Label 與 TextField
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
                AppTextField(
                  controller: state._effectiveController,
                  focusNode: focusNode,
                  hintText: hintText,
                  errorText: field.errorText,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  variant: variant,
                  textVariant: textVariant,
                  prefixIcon: prefixIcon,
                  suffixIcon: suffixIcon,
                  inputFormatters: inputFormatters,
                  onChanged: (value) {
                    field.didChange(value);
                    onChanged?.call(value);
                  },
                ),
              ],
            );
          },
        );

  final TextEditingController? controller;
  final String? label;
  final List<TextInputFormatter>? inputFormatters;

  @override
  FormFieldState<String> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends FormFieldState<String> {
  TextEditingController? _internalController;

  TextEditingController get _effectiveController =>
      (widget as AppTextFormField).controller ?? _internalController!;

  @override
  void initState() {
    super.initState();
    if ((widget as AppTextFormField).controller == null) {
      _internalController = TextEditingController(text: widget.initialValue);
    }
    _effectiveController.addListener(_handleControllerChanged);
  }

  @override
  void dispose() {
    _effectiveController.removeListener(_handleControllerChanged);
    _internalController?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 處理 Controller 從外部變更的情況 (較少見但標準實作需要)
    if ((widget as AppTextFormField).controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);

      // 如果新 Widget 沒傳 controller，需要建立新的內部 controller
      if ((widget as AppTextFormField).controller == null) {
        _internalController =
            TextEditingController.fromValue(oldWidget.controller?.value);
      } else {
        // 如果新 Widget 有傳，同步值並銷毀舊的內部 controller
        _internalController?.dispose();
        _internalController = null;
        if (oldWidget.controller == null) {
          // 從內部轉外部，通常不需要做什麼，值會透過 setValue 同步
        }
      }

      _effectiveController.addListener(_handleControllerChanged);
    }
  }

  // 當 Controller 文字變更時 (例如使用者輸入)，同步回 FormFieldState
  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  // 當 FormFieldState 變更時 (例如呼叫 reset)，同步回 Controller
  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    // 重置時，將 Controller 文字設回初始值
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }
}
