import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/password_input_style.dart';

class AppPasswordInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final String? errorText;
  final List<AppPasswordRule>? rules;
  final String? rulesHeader;
  final bool showRulesOnlyOnError;
  final bool initiallyObscured;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onChanged;
  final bool enableShowHideToggle;

  const AppPasswordInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.errorText,
    this.rules,
    this.rulesHeader,
    this.showRulesOnlyOnError = false,
    this.initiallyObscured = true,
    this.onSubmitted,
    this.onChanged,
    this.enableShowHideToggle = true,
  });

  @override
  State<AppPasswordInput> createState() => _AppPasswordInputState();
}

class _AppPasswordInputState extends State<AppPasswordInput> {
  late TextEditingController _controller;
  late bool _isObscured;
  bool _hasStartedTyping = false;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller ?? TextEditingController();
    _isObscured = widget.initiallyObscured;
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onTextChanged(String text) {
    // Call the external onChanged callback first
    widget.onChanged?.call(text);

    // Handle internal state for validation rules display
    if (!_hasStartedTyping && text.isNotEmpty) {
      setState(() {
        _hasStartedTyping = true;
      });
    } else {
      setState(() {}); // Rebuild to update validation rules
    }

    // Check if all rules passed for feedback
    if (widget.rules != null && widget.rules!.isNotEmpty) {
        final allPassed = widget.rules!.every((rule) => rule.validate(text));
        if (allPassed && text.isNotEmpty) {
             // Debounce or check if just became valid to avoid spamming
             // For now simplified:
             // AppFeedback.onSuccess(); // Too noisy on every keystroke if valid
        }
    }
  }

  void _toggleVisibility() {
    AppFeedback.onInteraction();
    setState(() {
      _isObscured = !_isObscured;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppDesignTheme.of(context);
    final style = theme.passwordInputStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (widget.label != null) ...[
          Text(widget.label!, style: theme.typography.bodyFontFamily != null ? TextStyle(fontFamily: theme.typography.bodyFontFamily) : null), // Using basic Text for now or AppText if available
          AppGap.xs(),
        ],
        AppTextField(
          controller: _controller,
          hintText: widget.hint,
          errorText: widget.errorText,
          obscureText: _isObscured,
          onChanged: _onTextChanged,
          onSubmitted: widget.onSubmitted,
          suffixIcon: widget.enableShowHideToggle ? GestureDetector(
            onTap: _toggleVisibility,
            child: AppIcon.font(
              _isObscured ? Icons.visibility : Icons.visibility_off,
              size: 20,
              color: theme.inputStyle.outlineStyle.contentColor.withValues(alpha: 0.6),
            ),
          ) : null,
        ),
        // Error text display
        if (widget.errorText != null) ...[
          AppGap.xs(),
          AppText.bodySmall(
            widget.errorText!,
            color: theme.inputStyle.errorModifier.borderColor,
          ),
        ],
        if (widget.rules != null && widget.rules!.isNotEmpty) ...[
          AppGap.sm(),
          if (widget.rulesHeader != null) ...[
            AppText.bodySmall(widget.rulesHeader!),
            AppGap.xs(),
          ],
          _buildRulesList(theme, style),
        ],
      ],
    );
  }

  Widget _buildRulesList(AppDesignTheme theme, PasswordInputStyle style) {
    if (widget.showRulesOnlyOnError && !_hasStartedTyping) {
      return const SizedBox.shrink();
    }

    final content = Column(
      children: widget.rules!.map((rule) {
        final isValid = rule.validate(_controller.text);
        return _buildRuleItem(rule, isValid, style, theme);
      }).toList(),
    );

    if (style.showRuleListBackground) {
      return AppSurface(
        variant: SurfaceVariant.base,
        style: theme.surfaceBase.copyWith(
          backgroundColor: theme.surfaceBase.backgroundColor.withValues(alpha: 0.5),
          borderRadius: 8.0,
        ),
        padding: const EdgeInsets.all(12),
        child: content,
      );
    }

    return content;
  }

  Widget _buildRuleItem(AppPasswordRule rule, bool isValid, PasswordInputStyle style, AppDesignTheme theme) {
    final color = isValid ? style.validColor : style.pendingColor;
    final icon = isValid ? style.validIcon : style.pendingIcon;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          AppIcon.font(icon, size: 14, color: color),
          AppGap.xs(),
          Expanded(
            child: Text(
              rule.label,
              style: style.ruleTextStyle.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}
