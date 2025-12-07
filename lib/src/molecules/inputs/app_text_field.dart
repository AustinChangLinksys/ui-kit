import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_kit_library/ui_kit.dart'; // Ensure copyWith & customBorder are imported

/// Visual variants of the input box (corresponds to InputStyle in Theme)
enum AppInputVariant {
  outline, // Default: Four-sided border (Box)
  underline, // Only underline (Line)
  filled, // Filled background without border (Filled Box)
  none, // No style (Pure)
}

class AppTextField extends StatefulWidget {
  const AppTextField({
    this.controller,
    this.focusNode,
    this.hintText,
    this.onChanged,
    this.errorText,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.variant = AppInputVariant.outline,
    this.textVariant = AppTextVariant.bodyMedium, // control text size
    this.prefixIcon,
    this.suffixIcon,
    this.inputFormatters,
    super.key,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? hintText;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool obscureText;
  final TextInputType keyboardType;
  final AppInputVariant variant;
  final AppTextVariant textVariant; // Font semantics
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;
  bool _showErrorTooltip = false;

  @override
  void initState() {
    super.initState();
    // IoC: Prioritize externally passed FocusNode
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    // Only dispose if FocusNode was created by itself
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    // Show error tooltip when input gains focus and has error
    if (_focusNode.hasFocus && widget.errorText != null) {
      setState(() => _showErrorTooltip = true);
    } else if (!_focusNode.hasFocus) {
      setState(() => _showErrorTooltip = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final hasError = widget.errorText != null;

    // Key: Use Extension to parse text style, consistent with AppText
    final baseTextStyle = widget.textVariant.resolve(context);

    return ListenableBuilder(
      listenable: _focusNode,
      builder: (context, _) {
        // 1. Base style parsing (Base Style from Theme Spec)
        SurfaceStyle targetStyle = _resolveBaseStyle(theme, widget.variant);

        // 2. State overlay: Focus Modifier (Patch)
        if (_focusNode.hasFocus) {
          final modifier = theme.inputStyle.focusModifier;
          targetStyle = targetStyle.copyWith(
            borderColor: modifier.borderColor,
            backgroundColor: modifier.backgroundColor,
            shadows: modifier.shadows,
            // If contentColor in modifier is null, base color will be retained here
            contentColor: modifier.contentColor,
          );
        }

        // 3. State overlay: Error Modifier (High Priority Patch)
        if (hasError) {
          final modifier = theme.inputStyle.errorModifier;
          targetStyle = targetStyle.copyWith(
            borderColor: modifier.borderColor,
            backgroundColor: modifier.backgroundColor,
            contentColor: modifier.contentColor,
            // Special handling: if in Underline mode, also turn the underline red
            customBorder: widget.variant == AppInputVariant.underline
                ? Border(
                    bottom: BorderSide(color: modifier.borderColor, width: 2.0))
                : null,
          );
        }

        // No Layout Shift Policy: Error is shown via icon + tooltip, not text below
        return AppSurface(
          style: targetStyle,
          interactive: true, // Enable physical feedback on click
          onTap: () => _focusNode.requestFocus(),

          // Layout: left and right padding, top and bottom expanded by TextField
          padding: EdgeInsets.symmetric(
            horizontal: theme.spacingFactor * 12,
            vertical: 0,
          ),

          child: Row(
            children: [
              // Prefix Slot
              if (widget.prefixIcon != null) ...[
                IconTheme(
                  data: IconThemeData(
                    color: targetStyle.contentColor,
                    // Icon size slightly adjusted with text size (approx. 1.2 times)
                    size: (baseTextStyle.fontSize ?? 14.0) * 1.2,
                  ),
                  child: widget.prefixIcon!,
                ),
                SizedBox(width: theme.spacingFactor * 8),
              ],

              // The Actual Input
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focusNode,
                  onChanged: widget.onChanged,
                  obscureText: widget.obscureText,
                  keyboardType: widget.keyboardType,
                  inputFormatters: widget.inputFormatters,

                  // Style: Inherit Surface color + externally specified Typography
                  style: baseTextStyle.copyWith(
                    color: targetStyle.contentColor,
                  ),
                  cursorColor: targetStyle.contentColor,

                  decoration: InputDecoration(
                    isDense: true,
                    hintText: widget.hintText,
                    hintStyle: baseTextStyle.copyWith(
                      color: targetStyle.contentColor.withValues(alpha: 0.5),
                    ),
                    // Remove all native decorations, fully delegate to AppSurface
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                    // Vertical centering and height control
                    contentPadding: EdgeInsets.symmetric(
                      vertical: theme.spacingFactor * 12,
                    ),
                  ),
                ),
              ),

              // Suffix Slot (user-provided icon)
              if (widget.suffixIcon != null) ...[
                SizedBox(width: theme.spacingFactor * 8),
                IconTheme(
                  data: IconThemeData(
                    color: targetStyle.contentColor,
                    size: (baseTextStyle.fontSize ?? 14.0) * 1.2,
                  ),
                  child: widget.suffixIcon!,
                ),
              ],

              // Error Icon with Tooltip (No Layout Shift)
              // Shows when hasError, tooltip visible on hover/tap or when focused
              if (hasError) ...[
                SizedBox(width: theme.spacingFactor * 8),
                AppTooltip(
                  message: widget.errorText,
                  position: AxisDirection.up,
                  visible: _showErrorTooltip ? true : null, // Show on focus, else use internal hover state
                  child: Icon(
                    Icons.error_outline,
                    color: scheme.error,
                    size: (baseTextStyle.fontSize ?? 14.0) * 1.2,
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }

  /// Extract basic styles from Theme.inputStyle based on Variant
  SurfaceStyle _resolveBaseStyle(
      AppDesignTheme theme, AppInputVariant variant) {
    switch (variant) {
      case AppInputVariant.outline:
        return theme.inputStyle.outlineStyle;
      case AppInputVariant.underline:
        return theme.inputStyle.underlineStyle;
      case AppInputVariant.filled:
        return theme.inputStyle.filledStyle;
      case AppInputVariant.none:
        // Pure mode: no background, no border
        return SurfaceStyle(
          backgroundColor: Colors.transparent,
          borderColor: Colors.transparent,
          contentColor: theme.surfaceBase.contentColor,
          borderWidth: 0,
          borderRadius: 0,
          shadows: const [],
          blurStrength: 0,
        );
    }
  }
}
