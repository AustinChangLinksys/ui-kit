import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:ui_kit_library/src/foundation/theme/design_system/specs/styled_text_style.dart';

/// A rich text component with tag-based rendering support.
///
/// Supports both XML-like tags (`<b>Bold</b>`) and parametrized tags (`{{key:Display Text}}`)
/// for easy internationalization and dynamic content styling.
///
/// **Example Usage:**
/// ```dart
/// AppStyledText(
///   text: 'Agree to {{terms:Terms of Service}} and <b>Privacy Policy</b>.',
///   onTapHandlers: {
///     'terms': () => showTermsDialog(),
///   },
/// )
/// ```
///
/// **Supported Tags:**
/// - Text Style: `<b>Bold</b>`, `<i>Italic</i>`, `<u>Underline</u>`
/// - Links: `{{key:Display Text}}` with onTapHandlers
/// - Colors: `<color>Text</color>` (theme-adaptive)
/// - Sizes: `<large>Big Text</large>`, `<small>Tiny Text</small>`
///
/// **Constitution Compliance:**
/// - Uses theme-driven styling (3.1 IoC)
/// - Dumb component pattern (6.2)
/// - Zero internal defaults (3.3)
/// - Constitution 4.6: Uses StyledTextStyle from theme system
/// - Constitution 7.1: No runtime type checking
class AppStyledText extends StatelessWidget {
  const AppStyledText({
    required this.text,
    this.onTapHandlers = const {},
    this.background, // New: Optional background support
    this.textAlign = TextAlign.start,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    super.key,
  });

  /// The text with markup tags.
  ///
  /// Supports:
  /// - XML tags: `<b>Bold</b>`, `<i>Italic</i>`, `<u>Underline</u>`, `<color>Red</color>`
  /// - Parametrized tags: `{{key:Display Text}}` (i18n friendly)
  /// - Size tags: `<large>Big</large>`, `<small>Small</small>`
  final String text;

  /// Map of tag keys to tap handlers for interactive elements.
  /// Used with parametrized tags: `{{terms:Terms of Service}}`
  final Map<String, VoidCallback> onTapHandlers;

  /// Optional background styling using AppSurface.
  /// When provided, wraps the text in an AppSurface container.
  /// Constitution 6.1: AppSurface usage for visual containers.
  final AppSurface? background;

  /// Text alignment
  final TextAlign textAlign;

  /// Maximum number of lines
  final int? maxLines;

  /// Text overflow behavior
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    // Constitution 3.3: Zero Internal Defaults - Fail Fast
    final theme = Theme.of(context).extension<AppDesignTheme>();
    assert(
      theme != null,
      'AppStyledText requires DesignSystem initialization. '
      'Call DesignSystem.init() in MaterialApp.builder.',
    );

    final spans = _parseText(context, theme!);

    final richText = RichText(
      text: TextSpan(children: spans),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );

    // Constitution 6.1: Optional AppSurface wrapper for visual containers
    if (background != null) {
      return AppSurface(
        style: background!.style,
        child: richText,
      );
    }

    return richText;
  }

  /// Parse text and convert tags to TextSpans
  List<InlineSpan> _parseText(
    BuildContext context,
    AppDesignTheme theme,
  ) {
    final spans = <InlineSpan>[];
    final style = theme.styledTextStyle;

    // First pass: Handle parametrized tags {{key:text}}
    final paramPattern = RegExp(r'\{\{(\w+):(.*?)\}\}');
    final paramMatches = paramPattern.allMatches(text).toList();

    int offset = 0;

    for (final match in paramMatches) {
      // Add text before the match
      if (match.start > offset) {
        final beforeText = text.substring(offset, match.start);
        spans.addAll(_parseXmlTags(beforeText, style));
      }

      final key = match.group(1)!;
      final displayText = match.group(2)!;
      final handler = onTapHandlers[key];

      // Constitution 4.6.4: Use StateColorSpec.resolve() for state-based color resolution
      final linkColor = style.linkColors.resolve(
        isActive: handler != null,
        isDisabled: handler == null,
      );

      // Create clickable span for parametrized tags using theme styling
      spans.add(
        TextSpan(
          text: displayText,
          style: style.baseTextStyle.copyWith(
            color: linkColor,
            decoration: style.linkDecoration,
            decorationThickness: style.linkDecorationThickness,
            shadows: style.linkShadows,
            backgroundColor: style.linkBackgroundColor,
          ),
          recognizer: handler != null
              ? (TapGestureRecognizer()..onTap = handler)
              : null,
        ),
      );

      offset = match.end;
    }

    // Add remaining text
    if (offset < text.length) {
      final remainingText = text.substring(offset);
      spans.addAll(_parseXmlTags(remainingText, style));
    }

    return spans;
  }

  /// Parse XML-like tags in text
  /// Constitution 4.9: Uses typography tokens instead of hardcoded font sizes
  List<InlineSpan> _parseXmlTags(
    String text,
    StyledTextStyle style,
  ) {
    if (text.isEmpty) return [];

    final spans = <InlineSpan>[];
    final xmlPattern = RegExp(r'<(\w+)>(.*?)</\1>');
    final matches = xmlPattern.allMatches(text).toList();

    int offset = 0;

    for (final match in matches) {
      // Add text before the match
      if (match.start > offset) {
        spans.add(TextSpan(
          text: text.substring(offset, match.start),
          style: style.baseTextStyle,
        ));
      }

      final tag = match.group(1)!;
      final content = match.group(2)!;
      final tagStyle = _getXmlTagStyle(tag, style);

      spans.add(TextSpan(
        text: content,
        style: tagStyle,
      ));

      offset = match.end;
    }

    // Add remaining text
    if (offset < text.length) {
      spans.add(TextSpan(
        text: text.substring(offset),
        style: style.baseTextStyle,
      ));
    }

    return spans;
  }

  /// Get style for XML tags based on tag name
  /// Constitution 4.9: Uses typography tokens instead of hardcoded calculations
  TextStyle _getXmlTagStyle(
    String tag,
    StyledTextStyle style,
  ) {
    switch (tag.toLowerCase()) {
      case 'b':
      case 'bold':
        return style.boldTextStyle;

      case 'i':
      case 'italic':
        return style.italicTextStyle;

      case 'u':
      case 'underline':
        return style.underlineTextStyle;

      case 'color':
        return style.colorTextStyle;

      case 'large':
        return style.largeTextStyle;

      case 'small':
        return style.smallTextStyle;

      default:
        return style.baseTextStyle;
    }
  }

}