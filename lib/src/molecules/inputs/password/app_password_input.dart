import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/password_input_style.dart';

class AppPasswordInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final List<AppPasswordRule>? rules;
  final String? rulesHeader;
  final bool showRulesOnlyOnError;
  final bool initiallyObscured;
  final ValueChanged<String>? onSubmitted;

  const AppPasswordInput({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.rules,
    this.rulesHeader,
    this.showRulesOnlyOnError = false,
    this.initiallyObscured = true,
    this.onSubmitted,
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
    _controller.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    if (widget.controller == null) _controller.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    if (!_hasStartedTyping && _controller.text.isNotEmpty) {
      setState(() {
        _hasStartedTyping = true;
      });
    } else {
      setState(() {}); // Rebuild to update validation rules
    }
    
    // Check if all rules passed for feedback
    if (widget.rules != null && widget.rules!.isNotEmpty) {
        final allPassed = widget.rules!.every((rule) => rule.validate(_controller.text));
        if (allPassed && _controller.text.isNotEmpty) {
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
          const SizedBox(height: 8),
        ],
        AppTextField(
          controller: _controller,
          hintText: widget.hint,
          obscureText: _isObscured,
          suffixIcon: GestureDetector(
            onTap: _toggleVisibility,
            child: Icon(
              _isObscured ? Icons.visibility : Icons.visibility_off,
              size: 20,
              color: theme.inputStyle.outlineStyle.contentColor.withValues(alpha: 0.6),
            ),
          ),
        ),
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
          Icon(icon, size: 14, color: color),
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
