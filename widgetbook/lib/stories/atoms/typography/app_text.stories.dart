import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;
import 'package:ui_kit_library/ui_kit.dart';

// --- 1. Define proxy options (to avoid using null directly in Knob) ---

enum _ColorOption {
  themeDefault('Default (Theme)'),
  red('Red'),
  blue('Blue'),
  green('Green'),
  orange('Orange');

  final String label;
  const _ColorOption(this.label);

  Color? resolve() {
    switch (this) {
      case _ColorOption.themeDefault:
        return null;
      case _ColorOption.red:
        return Colors.red;
      case _ColorOption.blue:
        return Colors.blue;
      case _ColorOption.green:
        return Colors.green;
      case _ColorOption.orange:
        return Colors.orange;
    }
  }
}

enum _FontWeightOption {
  themeDefault('Default (Theme)'),
  light('Light (300)'),
  regular('Regular (400)'),
  bold('Bold (700)'),
  black('Black (900)');

  final String label;
  const _FontWeightOption(this.label);

  FontWeight? resolve() {
    switch (this) {
      case _FontWeightOption.themeDefault:
        return null;
      case _FontWeightOption.light:
        return FontWeight.w300;
      case _FontWeightOption.regular:
        return FontWeight.w400;
      case _FontWeightOption.bold:
        return FontWeight.w700;
      case _FontWeightOption.black:
        return FontWeight.w900;
    }
  }
}

// --- 2. Interactive Playground ---

@widgetbook.UseCase(
  name: 'Interactive Playground',
  type: AppText,
)
Widget buildInteractiveText(BuildContext context) {
  // 1. Content Knob
  final content = context.knobs.string(
    label: 'Content',
    initialValue: 'The quick brown fox jumps over the lazy dog.',
  );

  // 2. Variant Knob
  final variant = context.knobs.object.dropdown<AppTextVariant>(
    label: 'Variant',
    options: AppTextVariant.values,
    initialOption: AppTextVariant.bodyMedium,
    labelBuilder: (val) => val.name,
  );

  // 3. Align Knob
  final textAlign = context.knobs.object.dropdown<TextAlign>(
    label: 'Align',
    options: [TextAlign.left, TextAlign.center, TextAlign.right],
    initialOption: TextAlign.left,
    labelBuilder: (val) => val.name,
  );

  // 4. Color Knob (using proxy Enum)
  // Fix: Use non-null Enum to prevent Widgetbook crash
  final colorOption = context.knobs.object.dropdown<_ColorOption>(
    label: 'Color Override',
    options: _ColorOption.values,
    initialOption: _ColorOption.themeDefault,
    labelBuilder: (val) => val.label,
  );

  // 5. Weight Knob (using proxy Enum)
  // Fix: Use non-null Enum
  final weightOption = context.knobs.object.dropdown<_FontWeightOption>(
    label: 'Font Weight',
    options: _FontWeightOption.values,
    initialOption: _FontWeightOption.themeDefault,
    labelBuilder: (val) => val.label,
  );

  return Center(
    child: Padding(
      padding: const EdgeInsets.all(24.0),
      child: AppText(
        content,
        variant: variant,
        textAlign: textAlign,
        // Map Enum back to actual property value
        color: colorOption.resolve(),
        fontWeight: weightOption.resolve(),
      ),
    ),
  );
}

// --- 3. Typography Gallery (Static) ---

@widgetbook.UseCase(
  name: 'Typography Gallery',
  type: AppText,
)
Widget buildTypographyGallery(BuildContext context) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(32.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader('Semantic Factories (shortcuts)'),
        _DemoRow(
          'AppText.headline(...)',
          AppText.headline('Page Headline'),
        ),
        _DemoRow(
          'AppText.subhead(...)',
          AppText.subhead('Section Subhead'),
        ),
        _DemoRow(
          'AppText.body(...)',
          AppText.body(
              'Body text is used for long-form content. It should have good readability and line height.'),
        ),
        _DemoRow(
          'AppText.caption(...)',
          AppText.caption('Caption text (e.g. hints, footnotes)'),
        ),
        _DemoRow(
          'AppText.tiny(...)',
          AppText.tiny('TINY TAG 12:00 PM'),
        ),
        const SizedBox(height: 32),
        const Divider(),
        const SizedBox(height: 32),
        const _SectionHeader('Material 3 Scale (standard levels)'),
        _DemoRow('Display Large', AppText.displayLarge('Display Large')),
        _DemoRow('Display Medium', AppText.displayMedium('Display Medium')),
        _DemoRow('Display Small', AppText.displaySmall('Display Small')),
        const SizedBox(height: 16),
        _DemoRow('Headline Large', AppText.headlineLarge('Headline Large')),
        _DemoRow('Headline Medium', AppText.headlineMedium('Headline Medium')),
        _DemoRow('Headline Small', AppText.headlineSmall('Headline Small')),
        const SizedBox(height: 16),
        _DemoRow('Title Large', AppText.titleLarge('Title Large')),
        _DemoRow('Title Medium', AppText.titleMedium('Title Medium')),
        _DemoRow('Title Small', AppText.titleSmall('Title Small')),
        const SizedBox(height: 16),
        _DemoRow('Label Large', AppText.labelLarge('Label Large (Button)')),
        _DemoRow('Label Medium', AppText.labelMedium('Label Medium')),
        _DemoRow('Label Small', AppText.labelSmall('Label Small')),
        const SizedBox(height: 16),
        _DemoRow('Body Large', AppText.bodyLarge('Body Large')),
        _DemoRow('Body Medium', AppText.bodyMedium('Body Medium')),
        _DemoRow('Body Small', AppText.bodySmall('Body Small')),
      ],
    ),
  );
}

// --- Helpers ---

class _SectionHeader extends StatelessWidget {
  final String text;
  const _SectionHeader(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: Theme.of(context).colorScheme.primary,
          fontSize: 14,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _DemoRow extends StatelessWidget {
  final String label;
  final Widget child;

  const _DemoRow(this.label, this.child);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                color: Colors.grey,
                fontFamily: 'Courier', // Monospace for labels
              ),
            ),
          ),
          Expanded(child: child),
        ],
      ),
    );
  }
}
