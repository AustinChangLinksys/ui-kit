import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// A [FormField] that wraps an [AppTextField].
class AppTextFormField extends FormField<String> {
  AppTextFormField({
    super.key,
    this.controller,
    String? initialValue,
    FocusNode? focusNode,
    String? hintText,
    ValueChanged<String>? onChanged,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    AppInputVariant variant = AppInputVariant.outline,
    AppTextVariant textVariant = AppTextVariant.bodyMedium,
    Widget? prefixIcon,
    Widget? suffixIcon,
    super.onSaved,
    super.validator,
    super.enabled,
    super.autovalidateMode,
  }) : super(
          initialValue: controller != null ? controller.text : initialValue,
          builder: (FormFieldState<String> state) {
            return AppTextField(
              controller: controller,
              focusNode: focusNode,
              hintText: hintText,
              errorText: state.errorText,
              obscureText: obscureText,
              keyboardType: keyboardType,
              variant: variant,
              textVariant: textVariant,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              onChanged: (value) {
                state.didChange(value);
                onChanged?.call(value);
              },
            );
          },
        );

  final TextEditingController? controller;

  @override
  FormFieldState<String> createState() => _AppTextFormFieldState();
}

class _AppTextFormFieldState extends FormFieldState<String> {
  TextEditingController? _controller;

  TextEditingController get _effectiveController =>
      (widget as AppTextFormField).controller ?? _controller!;

  @override
  void initState() {
    super.initState();
    if ((widget as AppTextFormField).controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    } else {
      (widget as AppTextFormField)
          .controller!
          .addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    (widget as AppTextFormField)
        .controller
        ?.removeListener(_handleControllerChanged);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(AppTextFormField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if ((widget as AppTextFormField).controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleControllerChanged);
      (widget as AppTextFormField)
          .controller
          ?.addListener(_handleControllerChanged);

      if (oldWidget.controller != null &&
          (widget as AppTextFormField).controller == null) {
        _controller =
            TextEditingController.fromValue(oldWidget.controller!.value);
      }
      if ((widget as AppTextFormField).controller != null) {
        setValue((widget as AppTextFormField).controller!.text);
        if (oldWidget.controller == null) {
          _controller = null;
        }
      }
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController.text != value) {
      didChange(_effectiveController.text);
    }
  }

  @override
  void didChange(String? value) {
    super.didChange(value);

    if (_effectiveController.text != value) {
      _effectiveController.text = value ?? '';
    }
  }

  @override
  void reset() {
    _effectiveController.text = widget.initialValue ?? '';
    super.reset();
  }
}
