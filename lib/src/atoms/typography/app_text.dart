import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// 完整的文字層級定義 (Material 3 Standard + Custom Extensions)
enum AppTextVariant {
  // Display
  displayLarge,
  displayMedium,
  displaySmall,

  // Headline
  headlineLarge,
  headlineMedium,
  headlineSmall,

  // Title
  titleLarge,
  titleMedium,
  titleSmall,

  // Label
  labelLarge, // Button text usually uses this
  labelMedium,
  labelSmall,

  // Body
  bodyLarge,
  bodyMedium, // Default
  bodySmall,

  // ✨ Custom Extensions
  bodyExtraSmall, // For very small tags or timestamps (e.g. 10sp)
}

/// ✨ 核心優化：將解析邏輯抽取為 Extension，讓 AppTextField 也能用
extension AppTextVariantX on AppTextVariant {
  TextStyle resolve(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // 使用 extension<AppDesignTheme>() 而不是 of(context) 避免循環依賴或錯誤
    final designTheme = Theme.of(context).extension<AppDesignTheme>();

    // 1. 取得基礎 TextStyle (Material 3 Mapping)
    TextStyle style;
    switch (this) {
      case AppTextVariant.displayLarge:
        style = textTheme.displayLarge!;
        break;
      case AppTextVariant.displayMedium:
        style = textTheme.displayMedium!;
        break;
      case AppTextVariant.displaySmall:
        style = textTheme.displaySmall!;
        break;

      case AppTextVariant.headlineLarge:
        style = textTheme.headlineLarge!;
        break;
      case AppTextVariant.headlineMedium:
        style = textTheme.headlineMedium!;
        break;
      case AppTextVariant.headlineSmall:
        style = textTheme.headlineSmall!;
        break;

      case AppTextVariant.titleLarge:
        style = textTheme.titleLarge!;
        break;
      case AppTextVariant.titleMedium:
        style = textTheme.titleMedium!;
        break;
      case AppTextVariant.titleSmall:
        style = textTheme.titleSmall!;
        break;

      case AppTextVariant.labelLarge:
        style = textTheme.labelLarge!;
        break;
      case AppTextVariant.labelMedium:
        style = textTheme.labelMedium!;
        break;
      case AppTextVariant.labelSmall:
        style = textTheme.labelSmall!;
        break;

      case AppTextVariant.bodyLarge:
        style = textTheme.bodyLarge!;
        break;
      case AppTextVariant.bodyMedium:
        style = textTheme.bodyMedium!;
        break;
      case AppTextVariant.bodySmall:
        style = textTheme.bodySmall!;
        break;

      // ✨ 自定義邏輯：基於 bodySmall 縮小
      case AppTextVariant.bodyExtraSmall:
        // 先取得定義的樣式
        final specStyle = AppTypographyExtra.bodyExtraSmall;
        // 確保顏色跟隨當前的主題 (因為靜態定義通常是黑色的)
        style = specStyle.copyWith(
          color: textTheme.bodySmall?.color,
          fontFamily: textTheme.bodySmall?.fontFamily, // 確保字體家族一致
        );
        break;
    }

    // 2. 套用 Design System 的字體覆寫 (Font Family Override)
    // 判斷是否為展示型標題 (Display ~ HeadlineSmall)
    final isDisplay = index <= AppTextVariant.headlineSmall.index;

    final fontFamily = isDisplay
        ? designTheme?.typography.displayFontFamily
        : designTheme?.typography.bodyFontFamily;

    return style.copyWith(fontFamily: fontFamily);
  }
}

class AppText extends StatelessWidget {
  const AppText(
    this.data, {
    super.key,
    this.variant = AppTextVariant.bodyMedium,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
    this.fontWeight,
    this.height,
  });

  final String data;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight; // 允許微調粗細
  final double? height; // 允許微調行高

// ==========================================
  // 🏭 Semantic Factories (語義化捷徑)
  // 僅開放最常用的 color, textAlign, maxLines
  // ==========================================

  /// 大標題 (Page Title) -> Headline Medium
  factory AppText.headline(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.headlineMedium,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);

  /// 副標題 (Section Title) -> Title Medium
  factory AppText.subhead(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.titleMedium,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);

  /// 內文 (Body Text) -> Body Medium
  factory AppText.body(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.bodyMedium,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);

  /// 說明文字 (Caption) -> Body Small
  factory AppText.caption(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.bodySmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);

  /// 微型文字 (Tag / Timestamp) -> Body Extra Small
  factory AppText.tiny(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.bodyExtraSmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);

  // ==========================================
  // 🏭 Material 3 Mapping Factories
  // ==========================================

  factory AppText.displayLarge(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.displayLarge,
          color: color,
          textAlign: textAlign);
  factory AppText.displayMedium(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.displayMedium,
          color: color,
          textAlign: textAlign);
  factory AppText.displaySmall(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.displaySmall,
          color: color,
          textAlign: textAlign);

  factory AppText.headlineLarge(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.headlineLarge,
          color: color,
          textAlign: textAlign);
  factory AppText.headlineMedium(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.headlineMedium,
          color: color,
          textAlign: textAlign);
  factory AppText.headlineSmall(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.headlineSmall,
          color: color,
          textAlign: textAlign);

  factory AppText.titleLarge(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.titleLarge,
          color: color,
          textAlign: textAlign);
  factory AppText.titleMedium(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.titleMedium,
          color: color,
          textAlign: textAlign);
  factory AppText.titleSmall(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.titleSmall,
          color: color,
          textAlign: textAlign);

  factory AppText.labelLarge(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.labelLarge,
          color: color,
          textAlign: textAlign);
  factory AppText.labelMedium(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.labelMedium,
          color: color,
          textAlign: textAlign);
  factory AppText.labelSmall(String data,
          {Color? color, TextAlign? textAlign}) =>
      AppText(data,
          variant: AppTextVariant.labelSmall,
          color: color,
          textAlign: textAlign);

  factory AppText.bodyLarge(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.bodyLarge,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);
  factory AppText.bodyMedium(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.bodyMedium,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);
  factory AppText.bodySmall(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.bodySmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);

  factory AppText.bodyExtraSmall(String data,
          {Color? color,
          TextAlign? textAlign,
          int? maxLines,
          TextOverflow? overflow}) =>
      AppText(data,
          variant: AppTextVariant.bodyExtraSmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    // ✨ 使用 Extension 解析基礎樣式
    final baseStyle = variant.resolve(context);

    // 疊加顏色與微調
    final effectiveStyle = baseStyle.copyWith(
      color: color ?? theme.surfaceBase.contentColor, // 預設使用當前 Surface 的內容色
      fontWeight: fontWeight,
      height: height,
    );

    return Text(
      data,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
