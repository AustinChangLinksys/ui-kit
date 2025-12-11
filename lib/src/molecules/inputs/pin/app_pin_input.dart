import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/pin_input_style.dart';

class AppPinInput extends StatefulWidget {
  final int length;
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSubmitted;
  final bool obscureText;
  final bool autoFocus;
  final bool stayOnLastField;
  final TextEditingController? controller;
  final String? errorText;

  const AppPinInput({
    super.key,
    this.length = 6,
    this.onCompleted,
    this.onChanged,
    this.onSubmitted,
    this.obscureText = false,
    this.autoFocus = false,
    this.stayOnLastField = false,
    this.controller,
    this.errorText,
  });

  @override
  State<AppPinInput> createState() => _AppPinInputState();
}

class _AppPinInputState extends State<AppPinInput>
    with SingleTickerProviderStateMixin {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late AnimationController _cursorController;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _focusNode = FocusNode();
    _cursorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..repeat(reverse: true);

    // Add listeners to rebuild UI on changes
    _controller.addListener(_onControllerChanged);
    _focusNode.addListener(_onFocusChanged);

    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _focusNode.requestFocus();
      });
    }
  }

  void _onControllerChanged() {
    setState(() {});
  }

  void _onFocusChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _controller.removeListener(_onControllerChanged);
    _focusNode.removeListener(_onFocusChanged);
    // Only dispose internal controller, not external one
    if (widget.controller == null) {
      _controller.dispose();
    }
    _focusNode.dispose();
    _cursorController.dispose();
    super.dispose();
  }

  void _onChanged(String value) {
    if (value.length > widget.length) {
      _controller.text = value.substring(0, widget.length);
      _controller.selection = TextSelection.fromPosition(
          TextPosition(offset: _controller.text.length));
      return;
    }

    widget.onChanged?.call(value);

    if (value.length == widget.length) {
      widget.onCompleted?.call(value);
      AppFeedback.onSuccess();

      // If stayOnLastField is false, remove focus after completion
      if (!widget.stayOnLastField) {
        _focusNode.unfocus();
      }
    } else {
      AppFeedback.onInteraction();
    }

    // Trigger UI rebuild to show changes
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppDesignTheme.of(context);
    final style = theme.pinInputStyle;

    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      behavior: HitTestBehavior.opaque,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Visual Rendering (Bottom Layer)
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.length, (index) {
              return Padding(
                padding: EdgeInsets.only(
                    right: index < widget.length - 1 ? style.cellSpacing : 0),
                child: _buildCell(index, theme, style),
              );
            }),
          ),

          // Ghost Input (Top Layer - Invisible but Functional)
          Positioned.fill(
            child: Semantics(
              label: 'PIN Input',
              hint: 'Enter ${widget.length} digits',
              textField: true,
              child: TextField(
                controller: _controller,
                focusNode: _focusNode,
                maxLength: widget.length,
                keyboardType: TextInputType.number,
                onChanged: _onChanged,
                onSubmitted: (_) => widget.onSubmitted?.call(),
                enableSuggestions: false,
                autocorrect: false,
                showCursor: false,
                contextMenuBuilder: null, // Disable context menu
                style: const TextStyle(
                  color: Colors.transparent, // Make text invisible
                  fontSize: 1, // Minimal size
                ),
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  counterText: '',
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  filled: false,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCell(int index, AppDesignTheme theme, PinInputStyle style) {
    final text = _controller.text;
    final isFilled = index < text.length;
    final isActive = index == text.length && _focusNode.hasFocus;
    final char = isFilled ? text[index] : '';
    // Use '•' (bullet) for obscured text - available in most fonts
    final displayChar = widget.obscureText && isFilled ? '•' : char;

    final hasError = widget.errorText != null;

    // Determine colors based on state
    final borderColor = hasError
        ? theme.inputStyle.errorModifier.borderColor
        : (isActive || isFilled
            ? theme.inputStyle.focusModifier.borderColor // Active/Filled border
            : theme.inputStyle.outlineStyle.borderColor); // Inactive border

    final backgroundColor = style.fillOnInput && isFilled
        ? theme.surfaceHighlight.backgroundColor // Inverted/Filled background
        : theme.inputStyle.outlineStyle.backgroundColor;

    // Text color should always be visible against the background
    // Use the style's textStyle.color which is set by the theme for proper contrast
    final textColor =
        style.textStyle.color ?? theme.inputStyle.outlineStyle.contentColor;

    // Determine border radius based on cell shape
    final borderRadius = switch (style.cellShape) {
      PinCellShape.circle => 999.0,
      PinCellShape.box => 0.0,
      PinCellShape.underline => 0.0,
      PinCellShape.recess => 12.0,
    };

    // Determine shadows based on cell shape and state
    List<BoxShadow> shadows;
    if (style.glowOnActive && isActive) {
      shadows = [
        BoxShadow(
          color: theme.surfaceHighlight.backgroundColor.withValues(alpha: 0.5),
          blurRadius: 8,
          spreadRadius: 2,
        )
      ];
    } else if (style.cellShape == PinCellShape.recess) {
      // Inset shadow effect for recess style (Neumorphic)
      shadows = theme.inputStyle.outlineStyle.shadows;
    } else {
      shadows = const [];
    }

    // For recess style, use a visible border if the theme has transparent border
    final effectiveBorderColor = style.cellShape == PinCellShape.recess &&
            borderColor == Colors.transparent
        ? theme.surfaceBase.contentColor.withValues(alpha: 0.15)
        : borderColor;

    return AppSurface(
      width: style.cellSize,
      height: style.cellSize,
      variant: SurfaceVariant.base, // Base styling, overridden below
      style: SurfaceStyle(
        backgroundColor: backgroundColor,
        borderColor: effectiveBorderColor,
        borderWidth: isActive ? 2.0 : 1.0, // Thicker border when active
        borderRadius: borderRadius,
        contentColor: textColor,
        shadows: shadows,
      ),
      child: Center(
        child: isActive
            ? FadeTransition(
                opacity: _cursorController,
                child: Container(
                  width: 2,
                  height: style.cellSize * 0.6,
                  color: textColor,
                ),
              )
            : Text(
                displayChar,
                style: style.textStyle.copyWith(
                  color: textColor,
                  // Ensure proper font weight for visibility
                  fontWeight: style.textStyle.fontWeight ?? FontWeight.w600,
                ),
              ),
      ),
    );
  }
}
