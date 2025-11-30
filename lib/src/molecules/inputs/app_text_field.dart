import 'package:flutter/material.dart';
import 'package:ui_kit_library/src/atoms/typography/app_text.dart'; // 引入 AppTextVariant
import 'package:ui_kit_library/ui_kit.dart'; // 確保引入 copyWith & customBorder

/// 輸入框的視覺變體 (對應 Theme 中的 InputStyle)
enum AppInputVariant {
  outline, // 預設：四邊框 (Box)
  underline, // 只有底線 (Line)
  filled, // 填充背景無邊框 (Filled Box)
  none, // 無樣式 (Pure)
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
    this.textVariant = AppTextVariant.bodyMedium, // ✨ 新增：控制文字大小
    this.prefixIcon,
    this.suffixIcon,
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
  final AppTextVariant textVariant; // 字體語義
  final Widget? prefixIcon;
  final Widget? suffixIcon;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    // IoC: 優先使用外部傳入的 FocusNode
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    // 只有自己建立的 FocusNode 才需要 dispose
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final scheme = Theme.of(context).colorScheme;
    final hasError = widget.errorText != null;

    // ✨ 關鍵：使用 Extension 解析文字樣式，保持與 AppText 一致
    final baseTextStyle = widget.textVariant.resolve(context);

    return ListenableBuilder(
      listenable: _focusNode,
      builder: (context, _) {
        // 1. 基礎樣式解析 (Base Style from Theme Spec)
        SurfaceStyle targetStyle = _resolveBaseStyle(theme, widget.variant);

        // 2. 狀態疊加：Focus Modifier (Patch)
        if (_focusNode.hasFocus) {
          final modifier = theme.inputStyle.focusModifier;
          targetStyle = targetStyle.copyWith(
            borderColor: modifier.borderColor,
            backgroundColor: modifier.backgroundColor,
            shadows: modifier.shadows,
            // 如果 modifier 裡面的 contentColor 是 null，這裡就會保留 base 的顏色
            contentColor: modifier.contentColor,
          );
        }

        // 3. 狀態疊加：Error Modifier (High Priority Patch)
        if (hasError) {
          final modifier = theme.inputStyle.errorModifier;
          targetStyle = targetStyle.copyWith(
            borderColor: modifier.borderColor,
            backgroundColor: modifier.backgroundColor,
            contentColor: modifier.contentColor,
            // 特殊處理：如果是 Underline 模式，也要把底線變紅
            customBorder: widget.variant == AppInputVariant.underline
                ? Border(
                    bottom: BorderSide(color: modifier.borderColor, width: 2.0))
                : null,
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Input Container ---
            AppSurface(
              style: targetStyle,
              interactive: true, // 啟用點擊物理回饋
              onTap: () => _focusNode.requestFocus(),

              // 佈局：左右留白，上下由 TextField 撐開
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
                        // Icon 大小隨文字大小微調 (約 1.2 倍)
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

                      // Style: 繼承 Surface 顏色 + 外部指定的 Typography
                      style: baseTextStyle.copyWith(
                        color: targetStyle.contentColor,
                      ),
                      cursorColor: targetStyle.contentColor,

                      decoration: InputDecoration(
                        isDense: true,
                        hintText: widget.hintText,
                        hintStyle: baseTextStyle.copyWith(
                          color:
                              targetStyle.contentColor.withValues(alpha: 0.5),
                        ),
                        // 移除所有原生裝飾，全權交給 AppSurface
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        // 垂直置中與高度控制
                        contentPadding: EdgeInsets.symmetric(
                          vertical: theme.spacingFactor * 12,
                        ),
                      ),
                    ),
                  ),

                  // Suffix Slot
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
                ],
              ),
            ),

            // --- Error Message ---
            if (hasError) ...[
              SizedBox(height: theme.spacingFactor * 4),
              Padding(
                padding: EdgeInsets.only(left: theme.spacingFactor * 4),
                child: Text(
                  widget.errorText!,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: scheme.error,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  /// 根據 Variant 從 Theme.inputStyle 中提取基礎樣式
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
        // 純淨模式：無背景、無邊框
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
