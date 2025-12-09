import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';

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
class AppStyledText extends StatelessWidget {
  const AppStyledText({
    required this.text,
    this.onTapHandlers = const {},
    this.baseStyle,
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

  /// Base text style. Defaults to theme's bodyMedium.
  final TextStyle? baseStyle;

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

    final effectiveBaseStyle = baseStyle ??
        Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: theme!.surfaceBase.contentColor,
        );

    final spans = _parseText(context, theme!, effectiveBaseStyle!);

    return RichText(
      text: TextSpan(children: spans),
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow,
    );
  }

  /// Parse text and convert tags to TextSpans
  List<InlineSpan> _parseText(
    BuildContext context,
    AppDesignTheme theme,
    TextStyle baseStyle,
  ) {
    final spans = <InlineSpan>[];
    final colorScheme = Theme.of(context).colorScheme;

    // First pass: Handle parametrized tags {{key:text}}
    final paramPattern = RegExp(r'\{\{(\w+):(.*?)\}\}');
    final paramMatches = paramPattern.allMatches(text).toList();

    int offset = 0;

    for (final match in paramMatches) {
      // Add text before the match
      if (match.start > offset) {
        final beforeText = text.substring(offset, match.start);
        spans.addAll(_parseXmlTags(beforeText, baseStyle, colorScheme, theme));
      }

      final key = match.group(1)!;
      final displayText = match.group(2)!;
      final handler = onTapHandlers[key];

      // Create clickable span for parametrized tags
      spans.add(
        TextSpan(
          text: displayText,
          style: _getLinkStyle(baseStyle, colorScheme, theme),
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
      spans.addAll(_parseXmlTags(remainingText, baseStyle, colorScheme, theme));
    }

    return spans;
  }

  /// Parse XML-like tags in text
  List<InlineSpan> _parseXmlTags(
    String text,
    TextStyle baseStyle,
    ColorScheme colorScheme,
    AppDesignTheme theme,
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
          style: baseStyle,
        ));
      }

      final tag = match.group(1)!;
      final content = match.group(2)!;
      final tagStyle = _getXmlTagStyle(tag, baseStyle, colorScheme, theme);

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
        style: baseStyle,
      ));
    }

    return spans;
  }

  /// Get style for XML tags based on tag name
  TextStyle _getXmlTagStyle(
    String tag,
    TextStyle baseStyle,
    ColorScheme colorScheme,
    AppDesignTheme theme,
  ) {
    switch (tag.toLowerCase()) {
      case 'b':
      case 'bold':
        return baseStyle.copyWith(fontWeight: FontWeight.bold);

      case 'i':
      case 'italic':
        return baseStyle.copyWith(fontStyle: FontStyle.italic);

      case 'u':
      case 'underline':
        return baseStyle.copyWith(decoration: TextDecoration.underline);

      case 'color':
        return _getColorStyle(baseStyle, colorScheme, theme);

      case 'large':
        return baseStyle.copyWith(
          fontSize: (baseStyle.fontSize ?? 14.0) * 1.2,
          height: 1.4,
        );

      case 'small':
        return baseStyle.copyWith(
          fontSize: (baseStyle.fontSize ?? 14.0) * 0.85,
          height: 1.2,
        );

      default:
        return baseStyle;
    }
  }

  /// Get link style based on current theme
  TextStyle _getLinkStyle(
    TextStyle baseStyle,
    ColorScheme colorScheme,
    AppDesignTheme theme,
  ) {
    // Theme-adaptive link styling per Constitution
    switch (theme.runtimeType.toString()) {
      case 'PixelDesignTheme':
        return baseStyle.copyWith(
          color: colorScheme.primary,
          decoration: TextDecoration.underline,
          decorationStyle: TextDecorationStyle.solid,
          decorationThickness: 2.0,
        );

      case 'GlassDesignTheme':
        return baseStyle.copyWith(
          color: colorScheme.primary,
          shadows: [
            Shadow(
              color: colorScheme.primary.withValues(alpha: 0.3),
              blurRadius: 4.0,
            ),
          ],
        );

      case 'BrutalDesignTheme':
        return baseStyle.copyWith(
          color: colorScheme.onSurface,
          backgroundColor: colorScheme.primary,
          fontWeight: FontWeight.bold,
        );

      default:
        return baseStyle.copyWith(
          color: colorScheme.primary,
          decoration: TextDecoration.underline,
        );
    }
  }

  /// Get color style based on theme
  TextStyle _getColorStyle(
    TextStyle baseStyle,
    ColorScheme colorScheme,
    AppDesignTheme theme,
  ) {
    // Use theme's primary color for semantic color tags
    return baseStyle.copyWith(color: colorScheme.primary);
  }
}