import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

/// Complete text hierarchy definition (Material 3 Standard + Custom Extensions)
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

  // Custom Extensions
  bodyExtraSmall, // For very small tags or timestamps (e.g. 10sp)
}

/// Core optimization: Extract parsing logic as Extension, so AppTextField can also use it
extension AppTextVariantX on AppTextVariant {
  TextStyle resolve(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    // Use extension<AppDesignTheme>() instead of of(context) to avoid circular dependencies or errors
    final designTheme = Theme.of(context).extension<AppDesignTheme>();

    // 1. Get base TextStyle (Material 3 Mapping)
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

      // Custom logic: scale down based on bodySmall
      case AppTextVariant.bodyExtraSmall:
        // First get the defined style
        final specStyle = AppTypographyExtra.bodyExtraSmall;
        // Ensure color follows current theme (because static definitions are usually black)
        style = specStyle.copyWith(
          color: textTheme.bodySmall?.color,
          fontFamily:
              textTheme.bodySmall?.fontFamily, // Ensure consistent font family
        );
        break;
    }

    // 2. Apply Design System font override (Font Family Override)
    // Determine if it's a display type heading (Display ~ HeadlineSmall)
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
    this.selectable = false,
  });

  final String data;
  final AppTextVariant variant;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  final FontWeight? fontWeight; // Allow fine-tuning of weight
  final double? height; // Allow fine-tuning of line height
  final bool selectable; // Allow text selection

// ==========================================
  // Semantic Factories
  // Only the most commonly used color, textAlign, maxLines are exposed
  // ==========================================

  /// Headline (Page Title) -> Headline Medium
  factory AppText.headline(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.headlineMedium,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);

  /// Subtitle (Section Title) -> Title Medium
  factory AppText.subhead(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.titleMedium,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);

  /// Body Text -> Body Medium
  factory AppText.body(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.bodyMedium,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);

  /// Caption -> Body Small
  factory AppText.caption(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.bodySmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);

  /// Tiny Text (Tag / Timestamp) -> Body Extra Small
  factory AppText.tiny(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.bodyExtraSmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);

  // ==========================================
  // Material 3 Mapping Factories
  // ==========================================

  factory AppText.displayLarge(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.displayLarge,
          color: color,
          textAlign: textAlign,
          selectable: selectable);
  factory AppText.displayMedium(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.displayMedium,
          color: color,
          textAlign: textAlign,
          selectable: selectable);
  factory AppText.displaySmall(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.displaySmall,
          color: color,
          textAlign: textAlign,
          selectable: selectable);

  factory AppText.headlineLarge(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.headlineLarge,
          color: color,
          textAlign: textAlign,
          selectable: selectable);
  factory AppText.headlineMedium(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.headlineMedium,
          color: color,
          textAlign: textAlign,
          selectable: selectable);
  factory AppText.headlineSmall(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.headlineSmall,
          color: color,
          textAlign: textAlign,
          selectable: selectable);

  factory AppText.titleLarge(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.titleLarge,
          color: color,
          textAlign: textAlign,
          selectable: selectable);
  factory AppText.titleMedium(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.titleMedium,
          color: color,
          textAlign: textAlign,
          selectable: selectable);
  factory AppText.titleSmall(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.titleSmall,
          color: color,
          textAlign: textAlign,
          selectable: selectable);

  factory AppText.labelLarge(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.labelLarge,
          color: color,
          textAlign: textAlign,
          selectable: selectable);
  factory AppText.labelMedium(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.labelMedium,
          color: color,
          textAlign: textAlign,
          selectable: selectable);
  factory AppText.labelSmall(
    String data, {
    Color? color,
    TextAlign? textAlign,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.labelSmall,
          color: color,
          textAlign: textAlign,
          selectable: selectable);

  factory AppText.bodyLarge(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.bodyLarge,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);
  factory AppText.bodyMedium(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.bodyMedium,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);
  factory AppText.bodySmall(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.bodySmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);

  factory AppText.bodyExtraSmall(
    String data, {
    Color? color,
    TextAlign? textAlign,
    int? maxLines,
    TextOverflow? overflow,
    bool selectable = false,
  }) =>
      AppText(data,
          variant: AppTextVariant.bodyExtraSmall,
          color: color,
          textAlign: textAlign,
          maxLines: maxLines,
          overflow: overflow,
          selectable: selectable);

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    // Use Extension to parse base style
    final baseStyle = variant.resolve(context);

    // Overlay color and fine-tune
    final effectiveStyle = baseStyle.copyWith(
      color: color ??
          theme.surfaceBase
              .contentColor, // Default to current Surface content color
      fontWeight: fontWeight,
      height: height,
    );

    if (selectable) {
      return SelectableText(
        data,
        style: effectiveStyle,
        textAlign: textAlign,
        maxLines: maxLines,
      );
    }

    return Text(
      data,
      style: effectiveStyle,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }
}
