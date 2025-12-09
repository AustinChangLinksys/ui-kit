import 'package:flutter/material.dart';
import 'package:ui_kit_library/ui_kit.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:widgetbook_annotation/widgetbook_annotation.dart' as widgetbook;

/// Widgetbook use cases for AppTextButton component
///
/// Demonstrates all AppTextButton variations including:
/// - Different sizes (small, medium, large)
/// - States (enabled, disabled, loading)
/// - Icon configurations (leading, trailing, none)
/// - Interactive behaviors across all themes

@widgetbook.UseCase(
  name: 'Default',
  type: AppTextButton,
)
Widget appTextButtonUseCase(BuildContext context) {
  return Center(
    child: AppTextButton(
      text: context.knobs.string(
        label: 'Text',
        initialValue: 'Text Button',
      ),
      size: context.knobs.object.dropdown(
        label: 'Size',
        options: AppButtonSize.values,
        initialOption: AppButtonSize.medium,
      ),
      icon: context.knobs.boolean(label: 'Has Icon', initialValue: false)
        ? context.knobs.object.dropdown(
            label: 'Icon',
            options: [
              Icons.add,
              Icons.arrow_forward,
              Icons.save,
              Icons.send,
              Icons.download,
              Icons.favorite,
              Icons.share,
              Icons.edit,
              Icons.delete,
            ],
            initialOption: Icons.arrow_forward,
          )
        : null,
      iconPosition: context.knobs.object.dropdown(
        label: 'Icon Position',
        options: AppButtonIconPosition.values,
        initialOption: AppButtonIconPosition.leading,
      ),
      isLoading: context.knobs.boolean(
        label: 'Loading',
        initialValue: false,
      ),
      onTap: context.knobs.boolean(
        label: 'Enabled',
        initialValue: true,
      ) ? () {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Text button tapped!')),
        );
      } : null,
      semanticLabel: context.knobs.stringOrNull(
        label: 'Semantic Label (Accessibility)',
        initialValue: null,
      ),
    ),
  );
}

@widgetbook.UseCase(
  name: 'All Sizes',
  type: AppTextButton,
)
Widget appTextButtonSizesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextButton(
          text: 'Small Text Button',
          size: AppButtonSize.small,
          onTap: () {},
        ),
        AppGap.md(),
        AppTextButton(
          text: 'Medium Text Button',
          size: AppButtonSize.medium,
          onTap: () {},
        ),
        AppGap.md(),
        AppTextButton(
          text: 'Large Text Button',
          size: AppButtonSize.large,
          onTap: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'With Icons',
  type: AppTextButton,
)
Widget appTextButtonIconsUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextButton(
          text: 'Leading Icon',
          icon: Icons.arrow_forward,
          iconPosition: AppButtonIconPosition.leading,
          onTap: () {},
        ),
        AppGap.md(),
        AppTextButton(
          text: 'Trailing Icon',
          icon: Icons.arrow_forward,
          iconPosition: AppButtonIconPosition.trailing,
          onTap: () {},
        ),
        AppGap.md(),
        AppTextButton(
          text: 'Save Document',
          icon: Icons.save,
          size: AppButtonSize.large,
          onTap: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'States',
  type: AppTextButton,
)
Widget appTextButtonStatesUseCase(BuildContext context) {
  return Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        AppTextButton(
          text: 'Enabled Button',
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Button tapped!')),
            );
          },
        ),
        AppGap.md(),
        const AppTextButton(
          text: 'Disabled Button',
          onTap: null,
        ),
        AppGap.md(),
        AppTextButton(
          text: 'Loading Button',
          isLoading: true,
          onTap: () {},
        ),
        AppGap.md(),
        AppTextButton(
          text: 'Loading with Icon',
          icon: Icons.send,
          isLoading: true,
          onTap: () {},
        ),
      ],
    ),
  );
}

@widgetbook.UseCase(
  name: 'Interactive Demo',
  type: AppTextButton,
)
Widget appTextButtonInteractiveUseCase(BuildContext context) {
  return Center(
    child: Wrap(
      spacing: 16,
      runSpacing: 16,
      alignment: WrapAlignment.center,
      children: [
        AppTextButton(
          text: 'Primary Action',
          onTap: () => _showSnackBar(context, 'Primary action executed'),
        ),
        AppTextButton(
          text: 'Secondary',
          size: AppButtonSize.small,
          onTap: () => _showSnackBar(context, 'Secondary action executed'),
        ),
        AppTextButton(
          text: 'With Icon',
          icon: Icons.favorite,
          onTap: () => _showSnackBar(context, 'Favorite added!'),
        ),
        AppTextButton(
          text: 'Share',
          icon: Icons.share,
          iconPosition: AppButtonIconPosition.trailing,
          onTap: () => _showSnackBar(context, 'Share dialog opened'),
        ),
        AppTextButton(
          text: 'Download',
          icon: Icons.download,
          size: AppButtonSize.large,
          onTap: () => _showSnackBar(context, 'Download started'),
        ),
        const AppTextButton(
          text: 'Disabled',
          onTap: null,
        ),
      ],
    ),
  );
}

void _showSnackBar(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}